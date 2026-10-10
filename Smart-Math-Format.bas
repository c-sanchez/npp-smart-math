#include once "windows.bi"
#include once "vbcompat.bi"
#include once "Inc\MathParser.bi"
#include once "Inc\ConfigManager.bi"
#include once "Inc\Smart-Math-Format.bi"

#ifndef LOCALE_SDECIMAL
const LOCALE_SDECIMAL = &h0000000E
#endif
#ifndef LOCALE_USER_DEFAULT
const LOCALE_USER_DEFAULT = &h0400
#endif

declare function AddThousandsSeparator(byref sRes as String) as String

' The highest LongInt value
const FB_I64_MAX as LongInt = 9223372036854775807
' The highest LongInt value before multiplying by 10
const FB_I64_MAX_DIV10 as LongInt = 922337203685477580
' The maximum allowed digit if LongInt value is exactly equal to the threshold above
const FB_I64_MAX_MOD10 as LongInt = 7

'' IEEE-754 double masks (little-endian storage; same bit pattern as uint64).
'' Defined behavior on Win32/Win64 IEEE-754 double layout (plugin targets).
private const SM_DBL_EXP_MASK as ULongInt = &h7FF0000000000000
private const SM_DBL_FRAC_MASK as ULongInt = &h000FFFFFFFFFFFFF
private const SM_DBL_SIGN_MASK as ULongInt = &h8000000000000000

' UI spellings for non-finite values (parser ValueToString still uses nan/inf/-inf).
const SM_FMT_NAN as String = "NaN"
const SM_FMT_INF as String = "Inf"
const SM_FMT_NEGINF as String = "-Inf"

'' Format-mask fragments (skill: multi-char string literals as named constants).
private const SM_STR_ZERO_DOT as String = "0."
private const SM_STR_SCI_ZERO_PAD_EXP as String = "0E+00"
private const SM_STR_SCI_EXP_SUFFIX as String = "E+00"
private const SM_STR_EXPLICIT_FLOAT_FRAC_DIGIT as String = "0"

'' Lowercase tokens from parser scalar strings (ValueToString / classification).
private const SM_TOK_NAN_LC as String = "nan"
private const SM_TOK_INF_LC as String = "inf"
private const SM_TOK_NEGINF_LC as String = "-inf"

'' LOCALE_SDECIMAL cache invalidation (incremented by ResetSmartMathFormatLocaleCache).
dim shared g_fmtLocaleCacheSerial as Integer = 0

' -----------------------------------------------------------------------------
'  Result Formatting
' -----------------------------------------------------------------------------

private function Pow10Cached(byval n as Integer) as Double
  static powTab(0 to 32) as Double
  static high as Integer = -1
  if n < 0 then return 1.0
  if n > 32 then
    dim pFallback as Double = 1.0
    dim j as Integer
    for j = 1 to n
      pFallback *= 10.0
    next j
    return pFallback
  end if
  while high < n
    high += 1
    if high = 0 then
      powTab(0) = 1.0
    else
      powTab(high) = powTab(high - 1) * 10.0
    end if
  wend
  return powTab(n)
end function

private const SM_NF_NONE as Integer = 0
private const SM_NF_NAN as Integer = 1
private const SM_NF_INF as Integer = 2
private const SM_NF_NEGINF as Integer = 3

private function ClassifyDoubleNonFinite(byval d as Double) as Integer
  dim bits as ULongInt = *cast(ULongInt ptr, @d)
  if (bits and SM_DBL_EXP_MASK) = SM_DBL_EXP_MASK then
    if (bits and SM_DBL_FRAC_MASK) <> 0 then return SM_NF_NAN
    if (bits and SM_DBL_SIGN_MASK) <> 0 then return SM_NF_NEGINF
    return SM_NF_INF
  end if
  if d <> d then return SM_NF_NAN
  if Not (d <= d) then return SM_NF_NAN
  return SM_NF_NONE
end function

private function NonFiniteTextFromClass(byval nfClass as Integer) as String
  select case nfClass
  case SM_NF_NAN: return SM_FMT_NAN
  case SM_NF_NEGINF: return SM_FMT_NEGINF
  case SM_NF_INF: return SM_FMT_INF
  end select
  return ""
end function

private function MaskFormatCached(byval useScientific as Boolean, byval n as Integer) as String
  static mFixed(0 to SMARTMATH_DECIMALS_MAX) as String
  static okFixed(0 to SMARTMATH_DECIMALS_MAX) as BOOL
  static mSci(0 to SMARTMATH_DECIMALS_MAX) as String
  static okSci(0 to SMARTMATH_DECIMALS_MAX) as BOOL
  if useScientific = FALSE then
    if okFixed(n) = FALSE then
      if n = 0 then
        mFixed(n) = "0"
      else
        mFixed(n) = SM_STR_ZERO_DOT & String(n, 48)
      end if
      okFixed(n) = TRUE
    end if
    return mFixed(n)
  end if
  if okSci(n) = FALSE then
    if n = 0 then
      mSci(n) = SM_STR_SCI_ZERO_PAD_EXP
    else
      mSci(n) = SM_STR_ZERO_DOT & String(n, 48) & SM_STR_SCI_EXP_SUFFIX
    end if
    okSci(n) = TRUE
  end if
  return mSci(n)
end function

private function IndexOfExponentLetter(byref s as String) as Integer
  dim n as Integer = Len(s)
  dim i as Integer
  for i = 1 to n
    select case Asc(s, i)
    case 69, 101
      return i
    end select
  next i
  return 0
end function

private function ReplaceSeparatorWith(byref s as String, byref sep as String, byref target as String) as String
  dim sepLen as Integer = Len(sep)
  if sepLen = 0 then return s
  if InStr(1, s, sep) = 0 then return s
  if sepLen = 1 andalso Len(target) = 1 then
    dim n as Integer = Len(s)
    dim r as String = Space(n)
    dim i as Integer
    dim sch as Integer = Asc(sep)
    dim tch as Integer = Asc(target)
    for i = 1 to n
      dim b as Integer = Asc(s, i)
      if b = sch then
        Mid(r, i, 1) = target
      else
        Mid(r, i, 1) = Chr(b)
      end if
    next i
    return r
  end if
  dim rMulti as String = s
  dim p as Integer = InStr(1, rMulti, sep)
  while p > 0
    rMulti = Left(rMulti, p - 1) & target & Mid(rMulti, p + sepLen)
    p = InStr(1, rMulti, sep)
  wend
  return rMulti
end function

'' FB Format() follows the user default locale; SetThreadLocale affects GetThreadLocale only.
'' Cache both LOCALE_SDECIMAL values so we normalize whatever Format actually emitted.
private sub RefreshCachedLocaleDecimals(byref threadDec as String, byref userDec as String)
  static lastLocaleSerial as Integer = -1
  static cachedThread as String
  static cachedUser as String
  if lastLocaleSerial = g_fmtLocaleCacheSerial andalso lastLocaleSerial >= 0 then
    threadDec = cachedThread
    userDec = cachedUser
    exit sub
  end if
  dim buf as zstring * 8 = any
  buf = ""
  if GetLocaleInfoA(GetThreadLocale(), LOCALE_SDECIMAL, @buf, 8) = 0 then
    cachedThread = ""
  else
    cachedThread = Trim(buf)
  end if
  buf = ""
  if GetLocaleInfoA(LOCALE_USER_DEFAULT, LOCALE_SDECIMAL, @buf, 8) = 0 then
    cachedUser = ""
  else
    cachedUser = Trim(buf)
  end if
  lastLocaleSerial = g_fmtLocaleCacheSerial
  threadDec = cachedThread
  userDec = cachedUser
end sub

private sub ApplyLocaleDecimalToAsciiDot(byref s as String, byref locDec as String)
  dim locLen as Integer = Len(locDec)
  if locLen = 0 orelse locDec = "." then exit sub
  s = ReplaceSeparatorWith(s, locDec, ".")
  if locLen > 1 then
    s = ReplaceSeparatorWith(s, Left(locDec, 1), ".")
  end if
end sub

'' Bumps LOCALE_SDECIMAL memo generation (e.g. after SetThreadLocale in formatter regression tests).
sub ResetSmartMathFormatLocaleCache()
  g_fmtLocaleCacheSerial += 1
end sub

'' Format() takes the decimal symbol from the user default locale (FB rtlib fb_hStrFormat / fb_IntlGet).
'' Normalize thread and user LOCALE_SDECIMAL so SetThreadLocale tests and mixed-locale hosts agree.
'' The runtime stores it as a single C char in the output, so multi-byte LOCALE_SDECIMAL values
'' may appear only as their first byte in s; normalize both the full string and that byte.
'' Downstream logic assumes a single ASCII "." in the mantissa before DecimalSep.
private function FormatWithAsciiDecimal(byval d as Double, byref fmtExpr as String) as String
  dim s as String = Format(d, fmtExpr)
  dim threadDec as String
  dim userDec as String
  RefreshCachedLocaleDecimals(threadDec, userDec)
  ApplyLocaleDecimalToAsciiDot(s, threadDec)
  if userDec <> threadDec then ApplyLocaleDecimalToAsciiDot(s, userDec)
  return s
end function

'' Str() uses ASCII "."; FormatWithAsciiDecimal ensures "." after locale-aware Format().
'' ini may set DecimalSep to ",". Detect either.
private function PositionOfNumericDecimal(byref s as String) as Integer
  dim p as Integer = InStr(1, s, Config_GetDecimalSep())
  if p > 0 then return p
  return InStr(1, s, ".")
end function

private function TrimTrailingFractionZeros(byref s as String) as String
  dim decPos as Integer = PositionOfNumericDecimal(s)
  if decPos = 0 andalso InStr(1, s, ",") = 0 then return s
  dim n as Integer = Len(s)
  while n > 0
    if Asc(s, n) <> 48 then exit while
    n -= 1
  wend
  if n = 0 then return ""
  dim lastCh as String = Mid(s, n, 1)
  if lastCh = Config_GetDecimalSep() orelse lastCh = "," orelse lastCh = "." then
    n -= 1
  end if
  dim slen as Integer = Len(s)
  if n = slen then return s
  return Left(s, n)
end function

'' Map parser scalar token to formatter display; empty if not non-finite.
function FormatNonFiniteDisplayFromParserScalar(byref s as String) as String
  dim t as String = LCase(Trim(s))
  if t = SM_TOK_NAN_LC then return SM_FMT_NAN
  if t = SM_TOK_INF_LC then return SM_FMT_INF
  if t = SM_TOK_NEGINF_LC then return SM_FMT_NEGINF
  return ""
end function

'' Normalize ...E+03 / ...e-04 to lowercase e and trim leading zeros in exponent.
private sub NormalizeScientificExponentTail(byref sRes as String)
  dim ePos as Integer = IndexOfExponentLetter(sRes)
  if ePos = 0 then exit sub
  dim mantissa as String = Left(sRes, ePos - 1)
  dim expPart as String = Mid(sRes, ePos + 1)
  dim expSign as String = "+"
  if Left(expPart, 1) = "-" then
    expSign = "-"
    expPart = Mid(expPart, 2)
  elseif Left(expPart, 1) = "+" then
    expPart = Mid(expPart, 2)
  end if
  while Len(expPart) > 1 andalso Left(expPart, 1) = "0"
    expPart = Mid(expPart, 2)
  wend
  sRes = mantissa & "e" & expSign & expPart
end sub

'' Same grouping as legacy right-to-left loop; builds left-to-right (fewer allocations).
private function InsertThousandsIntPart(byref intPart as String, byref localThouSep as String) as String
  dim n as Integer = Len(intPart)
  if n <= 3 then return intPart
  dim lead as Integer = n mod 3
  if lead = 0 then lead = 3
  dim outText as String = Mid(intPart, 1, lead)
  dim p as Integer = lead + 1
  while p <= n
    outText &= localThouSep & Mid(intPart, p, 3)
    p += 3
  wend
  return outText
end function

private function FormatNumericValue(byval d as Double) as String
  dim sRes as String
  dim eScanPos as Integer

  dim nfCls as Integer = ClassifyDoubleNonFinite(d)
  if nfCls <> SM_NF_NONE then return NonFiniteTextFromClass(nfCls)
  if d = 0.0 then d = 0.0 '' positive zero (Str/Format(-0.0) may yield "-0")

  if Config_GetDecimalPlaces() < 0 then
    sRes = LTrim(Str(d))
    eScanPos = IndexOfExponentLetter(sRes)
  else
    dim useScientific as Boolean = FALSE
    dim ad as Double = Abs(d)

    if ad > 0 then
      dim leadingZeroDigits as Integer = Config_GetDecimalPlaces() \ 2
      if leadingZeroDigits > 0 then
        if ad < 1.0 / Pow10Cached(leadingZeroDigits) then useScientific = TRUE
      end if

      dim isInt64Like as Boolean = FALSE
      '
      ' Note: the Formatter must not do this;
      ' instead, rely on the parser to preserve exact integers.
      '
      ' const I64_MAX_D as Double = 9223372036854775807.0
      ' const I64_MIN_D as Double = -9223372036854775808.0
      ' if d >= I64_MIN_D andalso d <= I64_MAX_D then
      '   if d = Fix(d) then isInt64Like = TRUE
      ' end if

      if isInt64Like = FALSE then
        if ad >= Pow10Cached(Config_GetDecimalPlaces() + 6) then useScientific = TRUE
      end if
    end if

    if useScientific then
      sRes = FormatWithAsciiDecimal(d, MaskFormatCached(TRUE, Config_GetDecimalPlaces()))
    else
      sRes = FormatWithAsciiDecimal(d, MaskFormatCached(FALSE, Config_GetDecimalPlaces()))
    end if

    eScanPos = IndexOfExponentLetter(sRes)
    if eScanPos = 0 then
      sRes = TrimTrailingFractionZeros(sRes)
    end if
  end if

  if eScanPos > 0 then
    dim m as String = TrimTrailingFractionZeros(Left(sRes, eScanPos - 1))
    dim eTail as String = Mid(sRes, eScanPos)
    sRes = m & eTail
  end if

  NormalizeScientificExponentTail(sRes)

  return AddThousandsSeparator(sRes)
end function

function AddThousandsSeparator(byref sRes as String) as String
  if Config_GetUseThousandsSep() then
    dim oldEPos as Integer = IndexOfExponentLetter(sRes)
    dim expPart2 as String = ""
    if oldEPos > 0 then
      expPart2 = Mid(sRes, oldEPos)
      sRes = Left(sRes, oldEPos - 1)
    end if

    dim decPos as Integer = PositionOfNumericDecimal(sRes)
    dim localThouSep as String = Config_GetThousandsSep()

    dim intPart as String
    dim decPart as String

    if decPos > 0 then
      intPart = Left(sRes, decPos - 1)
      decPart = Mid(sRes, decPos)
      if Left(decPart, 1) = "." andalso Config_GetDecimalSep() <> "." then
        decPart = Config_GetDecimalSep() & Mid(decPart, 2)
      end if
    else
      intPart = sRes
      decPart = ""
    end if

    dim isNeg as Boolean = False
    if Len(intPart) > 0 andalso Left(intPart, 1) = "-" then
      isNeg = True
      intPart = Mid(intPart, 2)
    end if

    dim withCommas as String = InsertThousandsIntPart(intPart, localThouSep)

    if isNeg then withCommas = "-" & withCommas
    sRes = withCommas & decPart & expPart2
  end if

  return sRes
end function

private function FormatNonFiniteFromDouble(byval d as Double) as String
  return NonFiniteTextFromClass(ClassifyDoubleNonFinite(d))
end function

private function ScanNumericStringChars(byval wantExponent as Boolean, byval wantFracSep as Boolean, byref s as String) as Boolean
  dim n as Integer = Len(s)
  if n = 0 then return FALSE
  dim p as ZString ptr = strptr(s)
  dim decSepCh as UByte = 0
  if wantFracSep then
    dim decimalSep as String = Config_GetDecimalSep()
    if Len(decimalSep) > 0 then decSepCh = strptr(decimalSep)[0]
  end if
  dim i as Integer = 0
  while i < n
    dim c as UByte = p[i]
    if wantExponent then
      if c = asc("e") orelse c = asc("E") then return TRUE
    end if
    if wantFracSep then
      if c = asc(".") orelse (decSepCh <> 0 andalso c = decSepCh) then return TRUE
    end if
    i += 1
  wend
  return FALSE
end function

private function ContainsExponent(byref s as String) as Boolean
  return ScanNumericStringChars(TRUE, FALSE, s)
end function

private function ContainsDecimalSepOrExponent(byref s as String) as Boolean
  return ScanNumericStringChars(TRUE, TRUE, s)
end function

'' Raw RSK_FLOATING display: append explicit fractional digit when none is shown.
private function FormatRawFloatingValue(byval d as Double) as String
  dim nf as String = FormatNonFiniteFromDouble(d)
  if Len(nf) > 0 then return nf
  dim s as String = FormatNumericValue(d)
  if ContainsDecimalSepOrExponent(s) = FALSE then
    s &= Config_GetDecimalSep() & SM_STR_EXPLICIT_FLOAT_FRAC_DIGIT
  end if
  return s
end function

private function ImagCoeffNeedsStarBeforeI(byref coeffStr as String, byval forceImagStar as Boolean) as Boolean
  if forceImagStar then return TRUE
  if coeffStr = SM_FMT_NAN orelse coeffStr = SM_FMT_INF orelse coeffStr = SM_FMT_NEGINF then return TRUE
  if ContainsExponent(coeffStr) then return TRUE
  return FALSE
end function

private sub AppendImagUnitSuffix(byref imagPart as String, byval forceImagStar as Boolean)
  if ImagCoeffNeedsStarBeforeI(imagPart, forceImagStar) then imagPart &= "*"
  imagPart &= "i"
end sub

private function AssembleComplexCartesianDisplay(byref rePart as String, byref imagCoeff as String, byval reZero as Boolean, byval forceImagStar as Boolean) as String
  if reZero then
    if forceImagStar = FALSE andalso imagCoeff = "1" then return "i"
    if forceImagStar = FALSE andalso imagCoeff = "-1" then return "-i"
    dim imagOnly as String = imagCoeff
    AppendImagUnitSuffix(imagOnly, forceImagStar)
    return imagOnly
  end if
  if forceImagStar = FALSE andalso imagCoeff = "1" then return rePart & " + i"
  if forceImagStar = FALSE andalso imagCoeff = "-1" then return rePart & " - i"
  dim signCh as String = "+"
  dim coeffBody as String = imagCoeff
  if left(coeffBody, 1) = "-" then
    signCh = "-"
    coeffBody = mid(coeffBody, 2)
  end if
  dim imagTail as String = coeffBody
  AppendImagUnitSuffix(imagTail, forceImagStar)
  return rePart & " " & signCh & " " & imagTail
end function

private function FormatRawCartesianComponentText(byref c as RawCartesianScalar) as String
  select case c.kind
  case RSK_TIME
    return Parser_FormatTimeMs(c.intValue)
  case RSK_INT64
    return AddThousandsSeparator(ltrim(str(c.intValue)))
  case RSK_UINT64
    return AddThousandsSeparator(ltrim(str(c.uintValue)))
  case RSK_RATIONAL
    if c.ratDen = 1 then return AddThousandsSeparator(ltrim(str(c.ratNum)))
    return AddThousandsSeparator(ltrim(str(c.ratNum))) & "/" & AddThousandsSeparator(ltrim(str(c.ratDen)))
  case RSK_INT_POWER
    if c.ratDen <= 1 then return AddThousandsSeparator(ltrim(str(c.ratNum)))
    return AddThousandsSeparator(ltrim(str(c.ratNum))) & "**" & AddThousandsSeparator(ltrim(str(c.ratDen)))
  case else
    return FormatRawFloatingValue(c.floatValue)
  end select
end function

private function FormatRawCartesianDisplay(byref c as RawCartesianScalar) as String
  return FormatRawCartesianComponentText(c)
end function

private function RawCartesianIsZeroForComplexReal(byref c as RawCartesianScalar) as Boolean
  if c.kind = RSK_FLOATING then
    if Len(FormatNonFiniteFromDouble(c.floatValue)) > 0 then return FALSE
  end if
  return RawCartesianIsZero(c)
end function

private function RawCartesianIsNaN(byref c as RawCartesianScalar) as Boolean
  if c.kind <> RSK_FLOATING then return FALSE
  return FormatNonFiniteFromDouble(c.floatValue) = SM_FMT_NAN
end function

private function RawComplexHasNaNComponent(byref s as RawScalar) as Boolean
  if s.kind <> RSK_COMPLEX then return FALSE
  return RawCartesianIsNaN(s.real) orelse RawCartesianIsNaN(s.imag)
end function

private function FormatRawComplexDisplay(byref s as RawScalar) as String
  if s.kind <> RSK_COMPLEX then return ""
  if RawComplexHasNaNComponent(s) then return SM_FMT_NAN
  dim realStr as String = FormatRawCartesianDisplay(s.real)
  dim imagStr as String = FormatRawCartesianDisplay(s.imag)
  dim forceImagStar as Boolean = RawCartesianIsRational(s.imag)

  return AssembleComplexCartesianDisplay(realStr, imagStr, RawCartesianIsZeroForComplexReal(s.real), forceImagStar)
end function

private function FormatRawComplexRenderBaseDisplay(byref s as RawScalar) as String
  if s.kind <> RSK_COMPLEX then return ""
  if RawComplexHasNaNComponent(s) then return SM_FMT_NAN
  dim reStr as String = Parser_FormatRawCartesianRenderBase(s.real, s.renderBase, s.renderUnsigned)
  dim imagStr as String = Parser_FormatRawCartesianRenderBase(s.imag, s.renderBase, s.renderUnsigned)
  if Len(reStr) = 0 orelse Len(imagStr) = 0 then return ""
  return AssembleComplexCartesianDisplay(reStr, imagStr, RawCartesianIsZeroForComplexReal(s.real), TRUE)
end function

private function FormatRawScalarDisplay(byref s as RawScalar) as String
  if RawScalarIsComplex(s) then return FormatRawComplexDisplay(s)
  return FormatRawCartesianDisplay(s.real)
end function

private function FormatRawScalarForDisplayContext(byref s as RawScalar) as String
  if s.renderBase <> 0 then
    if RawScalarIsComplex(s) then
      dim cxBase as String = FormatRawComplexRenderBaseDisplay(s)
      if Len(cxBase) > 0 then return cxBase
    else
      dim baseText as String = Parser_FormatRawScalarRenderBase(s)
      if Len(baseText) > 0 then return baseText
    end if
  end if
  return FormatRawScalarDisplay(s)
end function

private function FormatRawArrayBody(byref r as RawResult) as String
  dim outText as String = "("
  dim i as Integer
  for i = 0 to ubound(r.arr)
    if i > 0 then outText &= Config_GetArrayOutputSep() & " "
    outText &= FormatRawScalarForDisplayContext(r.arr(i))
  next i
  outText &= ")"
  return outText
end function

function FormatRawResultForDisplay(byref r as RawResult) as String
  if RawResultHasValue(r) = FALSE then return ""
  if r.kind = RRK_SCALAR then
    return SMARTMATH_RESULT_PREFIX & FormatRawScalarForDisplayContext(r.scalar)
  end if
  if r.kind <> RRK_ARRAY then return ""
  return SMARTMATH_RESULT_PREFIX & FormatRawArrayBody(r)
end function

function FormatRawEvaluationResult(byref raw as RawResult) as String
  return FormatRawResultForDisplay(raw)
end function

function FormatResult(byval d as Double) as String
  return SMARTMATH_RESULT_PREFIX & FormatRawFloatingValue(d)
end function
