'' RawResult helpers (types and payload layout comments in Inc\MathParserRawResult.bi).

#include once "Inc\MathParserRawResult.bi"

sub RawCartesianScalarClear(byref c as RawCartesianScalar)
  c.kind = RSK_FLOATING
  c.floatValue = 0.0
  c.intValue = 0
  c.uintValue = 0
  c.ratNum = 0
  c.ratDen = 0
end sub

sub RawResultClear(byref r as RawResult)
  r.kind = RRK_NONE
  r.scalar.kind = RSK_FLOATING
  RawCartesianScalarClear(r.scalar.real)
  RawCartesianScalarClear(r.scalar.imag)
  r.scalar.renderBase = 0
  r.scalar.renderUnsigned = FALSE
  erase r.arr
end sub

function RawResultHasValue(byref r as RawResult) as Boolean
  return r.kind <> RRK_NONE
end function

function RawScalarIsComplex(byref s as RawScalar) as Boolean
  return s.kind = RSK_COMPLEX
end function

function RawCartesianIsRational(byref c as RawCartesianScalar) as Boolean
  return c.kind = RSK_RATIONAL
end function

function RawCartesianIsZero(byref c as RawCartesianScalar) as Boolean
  select case c.kind
  case RSK_INT64
    return c.intValue = 0
  case RSK_UINT64
    return c.uintValue = 0
  case RSK_RATIONAL
    return c.ratNum = 0
  case RSK_TIME
    return c.intValue = 0
  case else
    if c.floatValue <> c.floatValue then return FALSE '' NaN is not zero
    return c.floatValue = 0.0
  end select
end function
