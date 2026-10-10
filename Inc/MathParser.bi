#ifndef __MATHPARSER_BI__
#define __MATHPARSER_BI__

#include once "Inc\MathParserRawResult.bi"

declare sub Parser_ClearVariables()
declare function Parser_TryEvaluate(byref sExpr as String, byref result as Double) as Boolean
declare function Parser_TryEvaluateEx(byref sExpr as String, byref result as Double, byref resultText as String, byref isArray as Boolean) as Boolean
declare function Parser_TryEvaluateExRaw(byref sExpr as String, byref rawOut as RawResult) as Boolean
declare function Parser_GetLastError() as String
declare function Parser_IsFunctionHintError(byref sErr as String) as Boolean
declare sub Parser_SetShowErrorLine(byval showLine as Boolean)
declare function Parser_GetShowErrorLine() as Boolean
declare sub Parser_SetSupportComplexNumbers(byval enabled as Boolean)
declare function Parser_GetSupportComplexNumbers() as Boolean
declare sub Parser_SetSupportTimeValues(byval enabled as Boolean)
declare function Parser_GetSupportTimeValues() as Boolean
declare sub Parser_SetSupportLambdaFunctions(byval enabled as Boolean)
declare function Parser_GetSupportLambdaFunctions() as Boolean
declare function Parser_GetLastRawResult(byref rawOut as RawResult) as Boolean
declare function Parser_FormatTimeMs(byval totalMs as LongInt) as String
declare function Parser_FormatRawScalarRenderBase(byref s as RawScalar) as String
declare function Parser_FormatRawCartesianRenderBase(byref c as RawCartesianScalar, byval renderBase as Integer, byval renderUnsigned as Boolean) as String

#endif