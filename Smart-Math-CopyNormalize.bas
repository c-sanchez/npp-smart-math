#include once "Inc\Smart-Math-Format.bi"
#include once "Inc\ConfigManager.bi"

private function IndexOfExponentLetterCopy(byref s as String) as Integer
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

private function StripThousandsFromCopyToken(byref t as String) as String
  if not Config_GetUseThousandsSep() then return t
  dim d as String = Config_GetThousandsSep()
  dim dlen as Integer = Len(d)
  if dlen = 0 then return t
  dim r as String = t
  dim p as Integer = InStr(1, r, d)
  while p > 0
    r = Left(r, p - 1) & Mid(r, p + dlen)
    p = InStr(1, r, d)
  wend
  return r
end function

'' Display uses ArrayOutputSep & " " between elements; split on that so decimal commas stay intact.
private function SplitCopyArrayInner(byref inner as String, elems() as String) as Integer
  erase elems
  dim s as String = inner
  dim n as Integer = Len(s)
  if n = 0 then return 0
  dim delim as String = Trim(Config_GetArrayOutputSep()) & " "
  dim dlen as Integer = Len(delim)
  if dlen < 1 then return 0
  dim depth as Integer = 0
  dim start as Integer = 1
  dim partCount as Integer = 0
  dim i as Integer = 1
  while i <= n
    dim ch as String = Mid(s, i, 1)
    if ch = "(" then
      depth += 1
      i += 1
    elseif ch = ")" then
      if depth > 0 then depth -= 1
      i += 1
    elseif depth = 0 andalso i + dlen - 1 <= n andalso Mid(s, i, dlen) = delim then
      dim seg as String = Trim(Mid(s, start, i - start))
      if partCount = 0 then
        redim elems(0 to 0)
      else
        redim preserve elems(0 to partCount)
      end if
      elems(partCount) = seg
      partCount += 1
      i += dlen
      start = i
    else
      i += 1
    end if
  wend
  dim segLast as String = Trim(Mid(s, start, n - start + 1))
  if partCount = 0 then
    redim elems(0 to 0)
  else
    redim preserve elems(0 to partCount)
  end if
  elems(partCount) = segLast
  return partCount + 1
end function

'' Clipboard: ASCII "." decimals (parser-friendly). Strip ThousandsSep only when
'' UseThousandsSep is true; honor DecimalSep; if decimal is "." but a comma
'' remains in the mantissa (locale/display mismatch), normalize those commas too.
private function ElemToCanonicalCopy(byref seg as String) as String
  dim t as String = Trim(seg)
  if Len(t) = 0 then return t
  dim tl as String = LCase(Left(t, 2))
  if tl = "0x" orelse tl = "0b" orelse tl = "0o" then return t

  t = StripThousandsFromCopyToken(t)

  dim ePos as Integer = IndexOfExponentLetterCopy(t)
  dim mant as String
  dim eTail as String
  if ePos > 0 then
    mant = Left(t, ePos - 1)
    eTail = Mid(t, ePos)
  else
    mant = t
    eTail = ""
  end if

  dim ds as String = Config_GetDecimalSep()
  dim dslen as Integer = Len(ds)
  if dslen > 0 andalso ds <> "." then
    dim p as Integer = InStr(1, mant, ds)
    while p > 0
      mant = Left(mant, p - 1) & "." & Mid(mant, p + dslen)
      p = InStr(1, mant, ds)
    wend
  end if

  if Config_GetDecimalSep() = "." then
    dim p2 as Integer = InStr(1, mant, ",")
    while p2 > 0
      mant = Left(mant, p2 - 1) & "." & Mid(mant, p2 + 1)
      p2 = InStr(1, mant, ",")
    wend
  end if

  return mant & eTail
end function

function NormalizeCopiedResult(byref sRes as String) as String
  dim sWork as String = LTrim(sRes)
  if Len(sWork) = 0 then return ""

  '' Display prefixes are " = " / " ! "; Trim/LTrim can leave "= " / "! ".
  dim ch0 as String = Left(sWork, 1)
  if ch0 = "=" then
    dim sOut as String = Trim(Mid(sWork, 2))
    if Len(sOut) >= 2 andalso Left(sOut, 1) = "(" andalso Right(sOut, 1) = ")" then
      dim inner as String = Trim(Mid(sOut, 2, Len(sOut) - 2))
      dim elems() as String
      dim cnt as Integer = SplitCopyArrayInner(inner, elems())
      if cnt <= 0 then return "()"
      dim acc as String = "("
      dim ei as Integer
      for ei = 0 to cnt - 1
        if ei > 0 then acc &= ", "
        acc &= ElemToCanonicalCopy(elems(ei))
      next ei
      acc &= ")"
      return acc
    end if

    return ElemToCanonicalCopy(sOut)
  elseif ch0 = "!" then
    return Trim(Mid(sWork, 2))
  end if
  return sWork
end function
