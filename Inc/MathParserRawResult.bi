#ifndef __MATHPARSER_RAWRESULT_BI__
#define __MATHPARSER_RAWRESULT_BI__

enum RawResultKind
  RRK_NONE = 0
  RRK_SCALAR = 1
  RRK_ARRAY = 2
end enum

enum RawScalarKind
  RSK_FLOATING = 0
  RSK_INT64 = 1
  RSK_UINT64 = 2
  RSK_RATIONAL = 3
  RSK_COMPLEX = 4
  RSK_TIME = 5
  RSK_INT_POWER = 6
end enum

'' One real or imaginary component. Only the fields for ``kind`` are meaningful.
type RawCartesianScalar
  kind as RawScalarKind
  floatValue as Double   '' for RSK_FLOATING
  intValue as LongInt    '' for RSK_INT64 and RSK_TIME (total milliseconds)
  uintValue as ULongInt  '' for RSK_UINT64
  ratNum as LongInt      '' for RSK_RATIONAL (ratNum / ratDen); RSK_INT_POWER base (signed)
  ratDen as ULongInt     '' for RSK_RATIONAL; RSK_INT_POWER exponent
end type

'' Non-complex values: payload in ``real`` only; ``imag`` cleared; ``kind`` mirrors ``real.kind``.
'' Complex: ``kind = RSK_COMPLEX``; each part's storage is in ``real`` / ``imag``.
'' Rational -> real.ratNum/ratDen.
'' time -> real.intValue ms.
type RawScalar
  kind as RawScalarKind
  real as RawCartesianScalar
  imag as RawCartesianScalar
  '' Non-decimal display from parser (hex/oct/bin); 0 = decimal.
  renderBase as UInteger
  renderUnsigned as Boolean
end type

type RawResult
  kind as RawResultKind
  scalar as RawScalar
  arr(any) as RawScalar
end type

declare sub RawCartesianScalarClear(byref c as RawCartesianScalar)
declare sub RawResultClear(byref r as RawResult)
declare function RawResultHasValue(byref r as RawResult) as Boolean
declare function RawScalarIsComplex(byref s as RawScalar) as Boolean
declare function RawCartesianIsRational(byref c as RawCartesianScalar) as Boolean
declare function RawCartesianIsZero(byref c as RawCartesianScalar) as Boolean

#endif
