#ifndef __SMART_MATH_FORMAT_BI__
#define __SMART_MATH_FORMAT_BI__

#include once "windows.bi"
#include once "Inc\MathParserRawResult.bi"

const SMARTMATH_DECIMALS_MAX = 8
const SMARTMATH_RESULT_PREFIX = " = "
const SMARTMATH_ERROR_PREFIX = " ! "

declare function FormatResult(byval d as Double) as String
declare function FormatRawResultForDisplay(byref r as RawResult) as String
declare function FormatRawEvaluationResult(byref raw as RawResult) as String

#endif
