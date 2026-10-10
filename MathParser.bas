#include once "crt.bi"
#include once "Inc\MathParser.bi"
#include once "MathParserRawResult.bas"

extern "C"
declare function acosh (byval x as double) as double
declare function asinh (byval x as double) as double
declare function atanh (byval x as double) as double
'' CRT libm (not FB intrinsics: built-in sin/cos/tan mishandle |x| >= 2^63).
declare function libc_sin alias "sin" (byval x as double) as double
declare function libc_cos alias "cos" (byval x as double) as double
declare function libc_tan alias "tan" (byval x as double) as double
end extern

private function LibSin(byval x as Double) as Double
  return libc_sin(x)
end function

private function LibCos(byval x as Double) as Double
  return libc_cos(x)
end function

private function LibTan(byval x as Double) as Double
  return libc_tan(x)
end function

const FB_STR_AT as string = " at "
const FB_STR_LINE_1_PREFIX as string = "line 1, "
const FB_STR_COL as string = "col "
const FB_STR_COLON as string = ":  "
const FB_STR_COMMA as string = ", "
const FB_STR_RAND as string = "rand"
const FB_STR_RANDOM as string = "random"
const FB_STR_BIN as string = "bin"
const FB_STR_HEX as string = "hex"
const FB_STR_OCT as string = "oct"
const FB_STR_POW as string = "pow"
const FB_STR_ATAN2 as string = "atan2"
const FB_STR_SIN as string = "sin"
const FB_STR_COS as string = "cos"
const FB_STR_TAN as string = "tan"
const FB_STR_ASIN as string = "asin"
const FB_STR_ARCSIN as string = "arcsin"
const FB_STR_ACOS as string = "acos"
const FB_STR_ARCCOS as string = "arccos"
const FB_STR_ATAN as string = "atan"
const FB_STR_ARCTAN as string = "arctan"
const FB_STR_SINH as string = "sinh"
const FB_STR_COSH as string = "cosh"
const FB_STR_TANH as string = "tanh"
const FB_STR_ACOSH as string = "acosh"
const FB_STR_ASINH as string = "asinh"
const FB_STR_ATANH as string = "atanh"
const FB_STR_EXP as string = "exp"
const FB_STR_LOG as string = "log"
const FB_STR_LN as string = "ln"
const FB_STR_LOG10 as string = "log10"
const FB_STR_SQRT as string = "sqrt"
const FB_STR_SQR as string = "sqr"
const FB_STR_INT as string = "int"
const FB_STR_FRAC as string = "frac"
const FB_STR_FRACT as string = "fract"
const FB_STR_ABS as string = "abs"
const FB_STR_FLOOR as string = "floor"
const FB_STR_CEIL as string = "ceil"
const FB_STR_TRUNC as string = "trunc"
const FB_STR_ROUND as string = "round"
const FB_STR_SIGN as string = "sign"
const FB_STR_DEG as string = "deg"
const FB_STR_RAD as string = "rad"
const FB_STR_SUM as string = "sum"
const FB_STR_MEDIAN as string = "median"
const FB_STR_VARIANCE as string = "variance"
const FB_STR_STDDEV as string = "stddev"
const FB_STR_SORT as string = "sort"
const FB_STR_SORTED as string = "sorted"
const FB_STR_SORTBY as string = "sortby"
const FB_STR_RATIO as string = "ratio"
const FB_STR_RANGE as string = "range"
const FB_STR_REVERSE as string = "reverse"
const FB_STR_REVERSED as string = "reversed"
const FB_STR_UNIQUE as string = "unique"
const FB_STR_UNPACK as string = "unpack"
const FB_STR_FLAT as string = "flat"
const FB_STR_REPEAT as string = "repeat"
const FB_STR_LEN as string = "len"
const FB_STR_LENGTH as string = "length"
const FB_STR_FACT as string = "fact"
const FB_STR_FACTORIAL as string = "factorial"
const FB_STR_FACTORINT as string = "factorint"
const FB_STR_DOUBLE_ASTERISK as string = "**"
const FB_STR_AVG as string = "avg"
const FB_STR_MEAN as string = "mean"
const FB_STR_MOD as string = "mod"
const FB_STR_CLAMP as string = "clamp"
const FB_STR_HYPOT as string = "hypot"
const FB_STR_GCD as string = "gcd"
const FB_STR_LCM as string = "lcm"
const FB_STR_NCR as string = "ncr"
const FB_STR_NPR as string = "npr"
const FB_STR_PRODUCT as string = "product"
const FB_STR_PROD as string = "prod"
const FB_STR_MIN as string = "min"
const FB_STR_MAX as string = "max"
const FB_STR_UHEX as string = "uhex"
const FB_STR_UOCT as string = "uoct"
const FB_STR_UBIN as string = "ubin"
const FB_STR_NOT as string = "not"
const FB_STR_AND as string = "and"
const FB_STR_OR as string = "or"
const FB_STR_PI as string = "pi"
const FB_STR_E as string = "e"
const FB_STR_I as string = "i"
const FB_STR_INF as string = "inf"
const FB_STR_NAN as string = "nan"
const FB_STR_PAR as string = "()"
const FB_STR_PAR_MIN_COMMA_MAX as string = "(min, max)"
const FB_STR_PAR_DOTDOTDOT as string = "(...)"
const FB_STR_PAR_VALUE_COMMA_POWER as string = "(value, power)"
const FB_STR_PAR_Y_COMMA_X as string = "(y, x)"
const FB_STR_PAR_ANGLE as string = "(angle)"
const FB_STR_PAR_VALUE as string = "(value)"
const FB_STR_PAR_VALUE_COMMA_BASE as string = "(value, base)"
const FB_STR_PAR_N as string = "(n)"
const FB_STR_PAR_VALUE_COMMA_DIVISOR as string = "(value, divisor)"
const FB_STR_PAR_VALUE_COMMA_MIN_COMMA_MAX as string = "(value, min, max)"
const FB_STR_PAR_X_COMMA_Y as string = "(x, y)"
const FB_STR_PAR_A_COMMA_B as string = "(a, b)"
const FB_STR_PAR_N_COMMA_R as string = "(n, r)"
const FB_STR_PAR_X_COMMA_N as string = "(x, n)"
const FB_STR_PAR_X as string = "(x)"
const FB_STR_PAR_START_COMMA_STOP_COMMA_STEP as string = "(start, stop [, step])"
const FB_STR_PAR_STEP_MUST_NOT_BE_ZERO as string = "() step must not be zero"
const FB_STR_PAR_PRODUCES_NO_VALUES as string = "() produces no values"
const FB_STR_PAR_PRODUCES_TOO_MANY_VALUES as string = "() produces too many values"
const BUILTIN_MAX_PRODUCED_ITEMS as Integer = 1000
const FB_STR_PAR_ANS as string = "(ans)"
const FB_STR_PREFIX_HEX as string = "0x"
const FB_STR_PREFIX_OCT as string = "0o"
const FB_STR_PREFIX_BIN as string = "0b"
const FB_STR_ANS as string = "ans"
const FB_STR_FORMAL_VALIDATION_PROBE as string = "_"
const FB_STR_INDEXING_REQUIRES_AN_ARRAY_VALUE as string = "indexing requires an array value"
const FB_STR_MISSING_INDEX as string = "missing index"
const FB_STR_ARRAY_INDEX_MUST_BE_A_SCALAR as string = "array index must be a scalar integer"
const FB_STR_ARRAY_INDEX_MUST_BE_AN_INTEGER as string = "array index must be an integer"
const FB_STR_MISMATCHED_CLOSING_PARENTHESIS as string = "mismatched closing parenthesis"
const FB_STR_MISMATCHED_CLOSING_BRACE as string = "mismatched closing brace"
const FB_STR_MISSING_CLOSING_BRACKET as string = "missing closing bracket"
const FB_STR_ARRAY_INDEX_IS_OUT_OF_RANGE as string = "array index is out of range"
const FB_STR_SLICE_STEP_MUST_NOT_BE_ZERO as string = "slice step must not be zero"
const FB_STR_PAR_EXPECTS as string = "() expects "
const FB_STR_ARGUMENT_PAR_S_COMMA as string = " argument(s), "
const FB_STR_GIVEN as string = " given"
const FB_STR_RECURSIVE_USER_FUNCTION_CALL_COLON as string = "recursive function call: "
const FB_STR_USER_FUNCTION_CALL_STACK_OVERFLOW as string = "function call stack overflow"
const FB_STR_MODULO_OPERANDS_MUST_BE_INTEGER_VALUES as string = "modulo operands must be integer values"
const FB_STR_BITWISE_OPERANDS_MUST_BE_INTEGER_VALUES as string = "bitwise operands must be integer values"
const FB_STR_INCOMPATIBLE_OPERANDS as string = "incompatible operands"
const FB_STR_TIME_EMPTY_SEGMENT as string = "time literal: empty segment between colons"
const FB_STR_TIME_INVALID_SEGMENT as string = "time literal: invalid segment"
const FB_STR_TIME_COMPACT_EXPECTED_UNIT as string = "compact time literal: expected unit suffix"
const FB_STR_TIME_COMPACT_UNIT_ORDER as string = "compact time literal: unit order or duplicate unit"
const FB_STR_TIME_COMPACT_INVALID_SUFFIX as string = "compact time literal: invalid suffix"
const FB_STR_TIME_NEGATIVE_SEGMENT as string = "time literal: negative segment"
const FB_STR_TIME_NON_FINITE as string = "time value: non-finite operand"
const FB_STR_TIME_ARRAY_MIXED as string = "time values cannot be mixed with non-time values"
const FB_STR_TIME_EXPECTS_TIME_ARG as string = "() expects a time value"
const FB_STR_MILLISECOND as string = "millisecond"
const FB_STR_SECOND as string = "second"
const FB_STR_MINUTE as string = "minute"
const FB_STR_HOUR as string = "hour"
const FB_STR_DAY as string = "day"
const FB_STR_MILLISECONDS as string = "milliseconds"
const FB_STR_SECONDS as string = "seconds"
const FB_STR_MINUTES as string = "minutes"
const FB_STR_HOURS as string = "hours"
const FB_STR_DAYS as string = "days"
const FB_STR_REAL as string = "real"
const FB_STR_IMAG as string = "imag"
const FB_STR_PHASE as string = "phase"
const FB_STR_POLAR as string = "polar"
const FB_STR_CART as string = "cart"
const FB_STR_CONJ as string = "conj"
const FB_STR_PAR_EXPECTS_AT_LEAST as string = "() expects at least "
const FB_STR_ARGUMENT as string = " argument"
const FB_STR_ARGUMENTS as string = " arguments"
const FB_STR_MISSING_OPENING_BRACKET as string = "missing opening bracket"
const FB_STR_UNEXPECTED_COMMA as string = "unexpected comma"
const FB_STR_MISMATCHED_CLOSING_BRACKET as string = "mismatched closing bracket"
const FB_STR_MISSING_CLOSING_PARENTHESIS as string = "missing closing parenthesis"
const FB_STR_NUMERIC_ERROR_IN as string = "numeric error in "
const FB_STR_PAR_EXPECTS_A_NON_DASH as string = "() expects a non-negative integer"
const FB_STR_PAR_EXPECTS_A_POSITIVE_INTEGER as string = "() expects a positive integer"
const FB_STR_PAR_EXPECTS_SCALAR_VALUES as string = "() expects scalar values"
const FB_STR_PAR_EXPECTS_SCALAR_MIN_SLASH as string = "() expects scalar min/max"
const FB_STR_PAR_EXPECTS_INTEGER_VALUES as string = "() expects integer values"
const FB_STR_INVALID_HEX_LITERAL as string = "invalid hex literal"
const FB_STR_INVALID_BINARY_LITERAL as string = "invalid binary literal"
const FB_STR_INVALID_OCTAL_LITERAL as string = "invalid octal literal"
const FB_STR_UNEXPECTED_TOKEN as string = "unexpected token"
const FB_STR_HINT_PREFIX as string = "function: "
const FB_STR_ARRAY_ELEMENT_MUST_BE_SCALAR as string = "array element must be scalar"
const FB_STR_EXPRESSION_IS_TOO_LONG as string = "expression is too long"
const FB_STR_EMPTY_STATEMENT as string = "empty statement"
const FB_STR_RESERVED_FUNCTION_NAME_COLON as string = "reserved function name: "
const FB_STR_RESERVED_CONSTANT_NAME_COLON as string = "reserved constant name: "
const FB_STR_RESERVED_BUILTIN_VARIABLE_NAME_COLON as string = "reserved built-in variable name: "
const FB_STR_DUPLICATE_PARAMETER_NAME_COLON as string = "duplicate parameter name: "
const FB_STR_FUNCTION_BODY_IS_EMPTY as string = "function body is empty"
const FB_STR_FAILED_TO_PARSE_USER_FUNCTION_BODY as string = "failed to parse user function body"
const FB_STR_UNEXPECTED_INPUT as string = "unexpected characters"
const FB_STR_INTERNAL_UNARY_OP as string = "internal unary op"
const FB_STR_INTERNAL_BINARY_OP as string = "internal binary op"
const FB_STR_INTERNAL_EVAL_ERROR as string = "internal eval error"
const FB_STR_NUMERIC_ERROR_IN_POWER_OPERATION as string = "numeric error in power operation"
const FB_STR_NUMERIC_ERROR_IN_EXPRESSION as string = "numeric error in expression"
const FB_STR_MAX_EVALUATION_DEPTH_REACHED as string = "max evaluation depth reached"
const FB_STR_INVALID_NUMERIC_LITERAL as string = "invalid numeric literal"
const FB_STR_PERCENTAGE_REQUIRES_SCALAR_VALUE as string = "percentage requires scalar value"
const FB_STR_FAILED_TO_BUILD_ARRAY_LITERAL as string = "failed to build array literal"
const FB_STR_INTERNAL_ERROR_IN_AGGREGATE_BUILTIN as string = "internal error in aggregate builtin"
const FB_STR_INTERNAL_ERROR_IN_SCALAR_BINARY_BUILTIN as string = "internal error in scalar binary builtin"
const FB_STR_INTERNAL_ERROR_IN_UNARY_MATH_BUILTIN as string = "internal error in unary math builtin"
const FB_STR_UNEXPECTED_TOKEN_AFTER_EXPRESSION as string = "unexpected token after expression"
const FB_STR_SCALAR_ONLY_EXPRESSION_ENCOUNTERED_NON as string = "scalar-only expression encountered non-scalar value"
const FB_STR_PARSE_FAILED as string = "parse failed"
const FB_STR_DEFINED as string = "defined "
const FB_STR_UNKNOWN_VARIABLE_COLON as string = "unknown variable: "
const FB_STR_USER_DEFINED_FUNCTION_COLON as string = "user-defined function: "
const FB_STR_UNKNOWN_FUNCTION_COLON as string = "unknown function: "
const FB_STR_SORTBY_EXPECTS_ONE_FUNCTION as string = "sortby expects exactly one function"
const FB_STR_SORTBY_EXPECTS_UNARY_FUNCTION as string = "sortby expects a function that takes 1 parameter"
const RATIO_APPROX_EPS as Double = 1e-14
const RATIO_MAX_DENOMINATOR as LongInt = 10000000
const RATIO_MAX_POWER10_EXP as Integer = 18
const RATIO_SEMICONV_LINEAR_THRESH as Integer = 64
const FB_STR_SORTBY_KEY_MUST_BE_SCALAR_OR_ARRAY as string = "sortby key function must return a scalar or an array"
const LAMBDA_BODY_UNTIL_RPAREN as Integer = 1
const LAMBDA_BODY_UNTIL_SEMICOLON_EOF as Integer = 2
const LAMBDA_BODY_UNTIL_SORTBY_DELIM as Integer = 3
const FB_STR_PAR_ARRAY_COMMA_FUNC as string = "(array, func)"
const FB_STR_SEMICOLON_UNKNOWN_FUNCTION_COLON as string = "; unknown function: "

const FB_U64_MAX as ULongInt = &hFFFFFFFFFFFFFFFFULL
const FB_I64_MIN as LongInt = -9223372036854775807 - 1 ' -0x8000000000000000
const FB_I64_MAX as LongInt = 9223372036854775807 ' 0x7FFFFFFFFFFFFFFF
const FB_I64_MAX_U as ULongInt = 9223372036854775807
const FB_I64_MIN_MAG_U as ULongInt = &h8000000000000000ULL
const FB_I64_MIN_D as Double = -9223372036854775808.0
const FB_I64_MAX_D as Double = 9223372036854775807.0
const FB_MAX_EXACT_INT_FROM_DOUBLE as Double = 9007199254740992.0 ' 2^53
'' IEEE double: 2^64 (next representable above UINT64_MAX).
const FB_2_POW_64_D as Double = 1.8446744073709551616e+19
const FB_PI_VAL as Double = 4.0 * atn(1.0) ' pi

' -----------------------------------------------------------------------------
'  ASCII byte constants (single-byte stream; multi-byte UTF-8 not interpreted)
' -----------------------------------------------------------------------------
const CHAR_NUL as UByte = 0                ' string terminator / NUL
const CHAR_TAB as UByte = 9                ' horizontal tab
const CHAR_LF as UByte = 10                ' line feed
const CHAR_CR as UByte = 13                ' carriage return
const CHAR_SPACE as UByte = 32             ' space
const CHAR_EXCLAMATION as UByte = 33       ' !
const CHAR_HASH as UByte = 35              ' #
const CHAR_PERCENT as UByte = 37           ' %
const CHAR_AMPERSAND as UByte = 38         ' &
const CHAR_LPAREN as UByte = 40            ' (
const CHAR_RPAREN as UByte = 41            ' )
const CHAR_ASTERISK as UByte = 42          ' *
const CHAR_PLUS as UByte = 43              ' +
const CHAR_COMMA as UByte = 44             ' ,
const CHAR_MINUS as UByte = 45             ' -
const CHAR_DOT as UByte = 46               ' .
const CHAR_DIVIDE as UByte = 47            ' /
const CHAR_DIGIT_0 as UByte = 48           ' digit 0
const CHAR_DIGIT_1 as UByte = 49           ' digit 1
const CHAR_DIGIT_2 as UByte = 50           ' digit 2
const CHAR_DIGIT_3 as UByte = 51           ' digit 3
const CHAR_DIGIT_4 as UByte = 52           ' digit 4
const CHAR_DIGIT_5 as UByte = 53           ' digit 5
const CHAR_DIGIT_6 as UByte = 54           ' digit 6
const CHAR_DIGIT_7 as UByte = 55           ' digit 7
const CHAR_DIGIT_8 as UByte = 56           ' digit 8
const CHAR_DIGIT_9 as UByte = 57           ' digit 9
const CHAR_COLON as UByte = 58             ' :
const CHAR_SEMICOLON as UByte = 59         ' ;
const CHAR_LESS_THAN as UByte = 60         ' <
const CHAR_EQUALS as UByte = 61            ' =
const CHAR_GREATER_THAN as UByte = 62      ' >
const CHAR_QUESTION as UByte = 63          ' ?
const CHAR_AT as UByte = 64                ' @
const CHAR_A as UByte = 65                 ' A
const CHAR_B as UByte = 66                 ' B
const CHAR_C as UByte = 67                 ' C
const CHAR_D as UByte = 68                 ' D
const CHAR_E as UByte = 69                 ' E
const CHAR_F as UByte = 70                 ' F
const CHAR_G as UByte = 71                 ' G
const CHAR_H as UByte = 72                 ' H
const CHAR_I as UByte = 73                 ' I
const CHAR_J as UByte = 74                 ' J
const CHAR_K as UByte = 75                 ' K
const CHAR_L as UByte = 76                 ' L
const CHAR_M as UByte = 77                 ' M
const CHAR_N as UByte = 78                 ' N
const CHAR_O as UByte = 79                 ' O
const CHAR_P as UByte = 80                 ' P
const CHAR_Q as UByte = 81                 ' Q
const CHAR_R as UByte = 82                 ' R
const CHAR_S as UByte = 83                 ' S
const CHAR_T as UByte = 84                 ' T
const CHAR_U as UByte = 85                 ' U
const CHAR_V as UByte = 86                 ' V
const CHAR_W as UByte = 87                 ' W
const CHAR_X as UByte = 88                 ' X
const CHAR_Y as UByte = 89                 ' Y
const CHAR_Z as UByte = 90                 ' Z
const CHAR_LBRACKET as UByte = 91          ' [
const CHAR_BACKSLASH as UByte = 92         ' backslash
const CHAR_RBRACKET as UByte = 93          ' ]
const CHAR_CARET as UByte = 94             ' ^
const CHAR_UNDERSCORE as UByte = 95        ' _
const CHAR_LC_A as UByte = 97              ' a
const CHAR_LC_B as UByte = 98              ' b
const CHAR_LC_C as UByte = 99              ' c
const CHAR_LC_D as UByte = 100             ' d
const CHAR_LC_E as UByte = 101             ' e
const CHAR_LC_F as UByte = 102             ' f
const CHAR_LC_G as UByte = 103             ' g
const CHAR_LC_H as UByte = 104             ' h
const CHAR_LC_I as UByte = 105             ' i
const CHAR_LC_J as UByte = 106             ' j
const CHAR_LC_K as UByte = 107             ' k
const CHAR_LC_L as UByte = 108             ' l
const CHAR_LC_M as UByte = 109             ' m
const CHAR_LC_N as UByte = 110             ' n
const CHAR_LC_O as UByte = 111             ' o
const CHAR_LC_P as UByte = 112             ' p
const CHAR_LC_Q as UByte = 113             ' q
const CHAR_LC_R as UByte = 114             ' r
const CHAR_LC_S as UByte = 115             ' s
const CHAR_LC_T as UByte = 116             ' t
const CHAR_LC_U as UByte = 117             ' u
const CHAR_LC_V as UByte = 118             ' v
const CHAR_LC_W as UByte = 119             ' w
const CHAR_LC_X as UByte = 120             ' x
const CHAR_LC_Y as UByte = 121             ' y
const CHAR_LC_Z as UByte = 122             ' z
const CHAR_LBRACE as UByte = 123           ' {
const CHAR_PIPE as UByte = 124             ' |
const CHAR_RBRACE as UByte = 125           ' }
const CHAR_TILDE as UByte = 126            ' ~

enum ValueKind
  VK_SCALAR = 0
  VK_ARRAY = 1
  VK_FUNCTION_REF = 2
  VK_INLINE_LAMBDA = 3
end enum

enum ScalarStorageKind
  SSK_FLOATINGPOINT = 0
  SSK_INT64 = 1
  SSK_UINT64 = 2
  SSK_TIME = 3
end enum

enum ScalarFlags
  SVF_EXACT_INT64_VALID = &h01
  SVF_EXACT_UINT64_VALID = &h02
  SVF_DEC_SCI_POW63_HIGH = &h10
  SVF_IMAG_EXACT_INT64_VALID = &h20
  SVF_IMAG_EXACT_UINT64_VALID = &h40
  SVF_RENDER_RATIONAL = &h80
  SVF_IMAG_RENDER_RATIONAL = &h100
  SVF_RENDER_INT_POWER = &h200
end enum

enum EvalFlags
  EVF_EXPAND_ARGS = &h01
  EVF_RENDER_UNSIGNED = &h02
  EVF_RENDER_RATIONAL = &h04
  EVF_RENDER_BASE_SHIFT = 8
  EVF_RENDER_BASE_MASK = &h0000FF00
end enum

enum BuiltinFunctionId
  FUNC_RAND = 0
  FUNC_RANDOM
  FUNC_BIN
  FUNC_HEX
  FUNC_OCT
  FUNC_POW
  FUNC_ATAN2
  FUNC_SIN
  FUNC_COS
  FUNC_TAN
  FUNC_ASIN
  FUNC_ACOS
  FUNC_ATAN
  FUNC_SINH
  FUNC_COSH
  FUNC_TANH
  FUNC_ACOSH
  FUNC_ASINH
  FUNC_ATANH
  FUNC_EXP
  FUNC_LOG
  FUNC_LN
  FUNC_LOG10
  FUNC_SQRT
  FUNC_SQR
  FUNC_INT
  FUNC_FRAC
  FUNC_ABS
  FUNC_FLOOR
  FUNC_CEIL
  FUNC_TRUNC
  FUNC_ROUND
  FUNC_SIGN
  FUNC_DEG
  FUNC_RAD
  FUNC_SUM
  FUNC_MEDIAN
  FUNC_VARIANCE
  FUNC_STDDEV
  FUNC_SORT
  FUNC_SORTBY
  FUNC_RATIO
  FUNC_RANGE
  FUNC_REVERSE
  FUNC_UNIQUE
  FUNC_UNPACK
  FUNC_FLAT
  FUNC_REPEAT
  FUNC_LEN
  FUNC_FACT
  FUNC_FACTORINT
  FUNC_AVG
  FUNC_MEAN
  FUNC_MOD
  FUNC_CLAMP
  FUNC_HYPOT
  FUNC_GCD
  FUNC_LCM
  FUNC_NCR
  FUNC_NPR
  FUNC_PRODUCT
  FUNC_MIN
  FUNC_MAX
  FUNC_UHEX
  FUNC_UOCT
  FUNC_UBIN
  FUNC_MILLISECONDS
  FUNC_SECONDS
  FUNC_MINUTES
  FUNC_HOURS
  FUNC_DAYS
  FUNC_REAL
  FUNC_IMAG
  FUNC_PHASE
  FUNC_POLAR
  FUNC_CART
  FUNC_CONJ
  FUNC__COUNT
end enum

enum ScalarExactKind
  SEK_SIGNED = 0
  SEK_UNSIGNED
end enum

enum UnaryScalarKind
  USK_NONE = 0
  USK_PRIMARY_TRIG
  USK_INVERSE_TRIG
  USK_HYPERBOLIC_TRIG
  USK_INVERSE_HYPERBOLIC_TRIG
  USK_EXP
  USK_LN
  USK_LOG10
  USK_SQRT
  USK_SQR
  USK_ROUNDING
  USK_FRAC
  USK_ABS
  USK_SIGN
  USK_DEG
  USK_RAD
end enum

'' Static parse/eval error ids (order matches C++ ParseErrorId / kParseErrorTexts).
enum ParseErrorId
  PARSE_ERR_UNEXPECTED_COMMA = 0
  PARSE_ERR_INDEXING_REQUIRES_ARRAY
  PARSE_ERR_MISSING_INDEX
  PARSE_ERR_ARRAY_INDEX_MUST_BE_SCALAR
  PARSE_ERR_ARRAY_INDEX_MUST_BE_INTEGER
  PARSE_ERR_ARRAY_INDEX_OUT_OF_RANGE
  PARSE_ERR_MISSING_CLOSING_BRACKET
  PARSE_ERR_MISSING_CLOSING_PARENTHESIS
  PARSE_ERR_MISMATCHED_CLOSING_PARENTHESIS
  PARSE_ERR_MISMATCHED_CLOSING_BRACKET
  PARSE_ERR_MISMATCHED_CLOSING_BRACE
  PARSE_ERR_BITWISE_INTEGER_OPERANDS
  PARSE_ERR_MODULO_INTEGER_OPERANDS
  PARSE_ERR_INCOMPATIBLE_OPERANDS
  PARSE_ERR_INVALID_HEX_LITERAL
  PARSE_ERR_INVALID_BINARY_LITERAL
  PARSE_ERR_INVALID_OCTAL_LITERAL
  PARSE_ERR_INTERNAL_UNARY_OP
  PARSE_ERR_INTERNAL_BINARY_OP
  PARSE_ERR_INTERNAL_EVAL_ERROR
  PARSE_ERR_NUMERIC_ERROR_IN_POWER_OPERATION
  PARSE_ERR_NUMERIC_ERROR_IN_EXPRESSION
  PARSE_ERR_USER_FUNCTION_CALL_STACK_OVERFLOW
  PARSE_ERR_MAX_EVALUATION_DEPTH_REACHED
  PARSE_ERR_INVALID_NUMERIC_LITERAL
  PARSE_ERR_PERCENTAGE_REQUIRES_SCALAR_VALUE
  PARSE_ERR_FAILED_TO_BUILD_ARRAY_LITERAL
  PARSE_ERR_INTERNAL_AGGREGATE_BUILTIN
  PARSE_ERR_INTERNAL_SCALAR_BINARY_BUILTIN
  PARSE_ERR_INTERNAL_UNARY_MATH_BUILTIN
  PARSE_ERR_UNEXPECTED_TOKEN_AFTER_EXPRESSION
  PARSE_ERR_SCALAR_ONLY_EXPRESSION_ENCOUNTERED_NON
  PARSE_ERR_PARSE_FAILED
  PARSE_ERR_UNEXPECTED_TOKEN
  PARSE_ERR_UNEXPECTED_INPUT
  PARSE_ERR_COUNT
end enum

enum AggregateFoldMode
  AFM_REAL = 0
  AFM_COMPLEX
  AFM_TIME
end enum

enum BuiltinCategory
  BC_RAND = 0
  BC_SCALAR_BINARY
  BC_BASE_FORMAT
  BC_POW
  BC_UNARY_MATH
  BC_DEG_RAD
  BC_AGGREGATE
  BC_ARRAY_TRANSFORM
  BC_REPEAT
  BC_RANGE
  BC_SORTBY
  BC_RATIO
  BC_FACTORIAL
  BC_FACTORINT
  BC_MOD
  BC_TIME_UNIT
  BC_POLAR_CART
  BC_LOG
  BC_UNKNOWN
end enum

enum BuiltinHintKind
  BHK_NONE = 0
  BHK_EMPTY_PAR
  BHK_MIN_MAX
  BHK_DOTDOTDOT
  BHK_VALUE_POWER
  BHK_Y_X
  BHK_ANGLE
  BHK_VALUE
  BHK_VALUE_BASE
  BHK_N
  BHK_VALUE_DIVISOR
  BHK_VALUE_MIN_MAX
  BHK_X_Y
  BHK_A_B
  BHK_N_R
  BHK_X_N
  BHK_X
  BHK_START_STOP_STEP
  BHK_ARRAY_FUNC
end enum

type ScalarValue
  scalarStorageKind as ScalarStorageKind
  '' Do not read ``flags`` for exact-int or render-rational policy; use ScalarHas* / ScalarExact* getters.
  flags as UInteger
  scalar as Double
  '' Numerator for ``SVF_RENDER_RATIONAL`` and exact integers; use getters, not direct reads, in eval paths.
  exactInt64 as LongInt
  '' Denominator for ``SVF_RENDER_RATIONAL`` and exact uintegers; use getters, not direct reads, in eval paths.
  exactUInt64 as ULongInt
  imag as Double
  '' Imaginary numerator; use ScalarImag* getters (``SVF_IMAG_RENDER_RATIONAL`` uses imag exact fields).
  imagExactInt64 as LongInt
  imagExactUInt64 as ULongInt
  declare property exactInt64Valid() as Boolean
  declare property exactInt64Valid(byval v as Boolean)
  declare property exactUInt64Valid() as Boolean
  declare property exactUInt64Valid(byval v as Boolean)
  declare property decScientificPow63High() as Boolean
  declare property decScientificPow63High(byval v as Boolean)
end type

type EvalValue
  kind as ValueKind
  flags as UInteger
  scalarValue as ScalarValue
  arr(any) as ScalarValue
  funcRefName as String
  lambdaParams(any) as String
  lambdaBody as String
  sortbyKeyErrorCol as Integer
  sortbyKeyBodyErrorCol as Integer
  declare property renderBase() as Integer ' 0=decimal, 16=hex, 8=octal, 2=binary
  declare property renderBase(byval v as Integer)
  ' uhex/uoct/ubin: two's complement as unsigned; hex/oct/bin: signed magnitude for negatives
  declare property scalarStorageKind() as Integer
  declare property scalarStorageKind(byval v as Integer)
  declare property scalar() byref as Double
  declare property scalar(byval v as Double)
  declare property exactInt64Valid() as Boolean
  declare property exactInt64Valid(byval v as Boolean)
  declare property exactInt64() byref as LongInt
  declare property exactInt64(byval v as LongInt)
  declare property exactUInt64Valid() as Boolean
  declare property exactUInt64Valid(byval v as Boolean)
  declare property exactUInt64() byref as ULongInt
  declare property exactUInt64(byval v as ULongInt)
  declare property expandArgs() as Boolean
  declare property expandArgs(byval v as Boolean)
  declare property renderUnsigned() as Boolean
  declare property renderUnsigned(byval v as Boolean)
end type

type DoubleBits
  union
    d as Double
    u as ULongInt
  end union
end type

declare function ScalarHasRenderRational(byref sv as ScalarValue) as Boolean
declare function ScalarHasImagRenderRational(byref sv as ScalarValue) as Boolean
declare function ScalarExactInt64Valid(byref sv as ScalarValue) as Boolean
declare function ScalarExactUInt64Valid(byref sv as ScalarValue) as Boolean
declare function ScalarImagExactInt64Valid(byref sv as ScalarValue) as Boolean
declare function ScalarImagExactUInt64Valid(byref sv as ScalarValue) as Boolean
declare function ScalarImagExactMetadataMatchesFloat(byref sv as ScalarValue) as Boolean
declare sub ScalarClearCartesianRenderExact(byref sv as ScalarValue)
declare sub ScalarApplyExactInt64Part(byref sv as ScalarValue, byval imagPart as Boolean, byval n as LongInt)
declare sub ScalarApplyReducedRationalPart(byref sv as ScalarValue, byval imagPart as Boolean, byval num as LongInt, byval den as ULongInt)
declare sub RawCartesianAssignReducedRational(byval num as LongInt, byval den as ULongInt, byref outC as RawCartesianScalar)
declare function TryGetExactInt64FromDouble(byval n as Double, byref outV as LongInt) as Boolean
declare sub ScalarRepairExactMetadata(byref sv as ScalarValue)
declare function ScalarNumericReal(byref sv as ScalarValue) as Double
declare function ScalarNumericImag(byref sv as ScalarValue) as Double
declare sub ScalarSetExactUInt64Valid(byref sv as ScalarValue, byval v as Boolean)
declare sub ScalarSetExactInt64Valid(byref sv as ScalarValue, byval v as Boolean)
declare sub ScalarSyncExactInt64WithUIntMirror(byref sv as ScalarValue, byval n as LongInt)
declare sub ScalarSyncExactUInt64WithIntMirror(byref sv as ScalarValue, byval n as ULongInt)
declare sub ScalarSyncImagExactInt64WithUIntMirror(byref sv as ScalarValue, byval n as LongInt)
declare sub ValueSetArrayFromScalarValues(byref outV as EvalValue, vals() as ScalarValue)
declare function GcdULong(byval a as ULongInt, byval b as ULongInt) as ULongInt
declare function TryPowULong(byval baseV as ULongInt, byval expV as ULongInt, byref outV as ULongInt) as Boolean

property ScalarValue.exactInt64Valid() as Boolean
  return ScalarExactInt64Valid(this)
end property

property ScalarValue.exactInt64Valid(byval v as Boolean)
  ScalarSetExactInt64Valid(this, v)
end property

property ScalarValue.exactUInt64Valid() as Boolean
  return ScalarExactUInt64Valid(this)
end property

property ScalarValue.exactUInt64Valid(byval v as Boolean)
  if v then
    this.flags or= SVF_EXACT_UINT64_VALID
  else
    this.flags and= not CUInt(SVF_EXACT_UINT64_VALID)
  end if
end property

property ScalarValue.decScientificPow63High() as Boolean
  return (this.flags and SVF_DEC_SCI_POW63_HIGH) <> 0
end property

property ScalarValue.decScientificPow63High(byval v as Boolean)
  if v then
    this.flags or= SVF_DEC_SCI_POW63_HIGH
  else
    this.flags and= not CUInt(SVF_DEC_SCI_POW63_HIGH)
  end if
end property

property EvalValue.scalarStorageKind() as Integer
  return CInt(this.scalarValue.scalarStorageKind)
end property

property EvalValue.scalarStorageKind(byval v as Integer)
  this.scalarValue.scalarStorageKind = v
end property

property EvalValue.scalar() byref as Double
  return this.scalarValue.scalar
end property

property EvalValue.scalar(byval v as Double)
  this.scalarValue.scalar = v
end property

property EvalValue.exactInt64Valid() as Boolean
  return this.scalarValue.exactInt64Valid
end property

property EvalValue.exactInt64Valid(byval v as Boolean)
  this.scalarValue.exactInt64Valid = v
end property

property EvalValue.exactInt64() byref as LongInt
  return this.scalarValue.exactInt64
end property

property EvalValue.exactInt64(byval v as LongInt)
  this.scalarValue.exactInt64 = v
end property

property EvalValue.exactUInt64Valid() as Boolean
  return this.scalarValue.exactUInt64Valid
end property

property EvalValue.exactUInt64Valid(byval v as Boolean)
  this.scalarValue.exactUInt64Valid = v
end property

property EvalValue.exactUInt64() byref as ULongInt
  return this.scalarValue.exactUInt64
end property

property EvalValue.exactUInt64(byval v as ULongInt)
  this.scalarValue.exactUInt64 = v
end property

property EvalValue.renderBase() as Integer
  dim raw as UInteger = (this.flags and EVF_RENDER_BASE_MASK) shr EVF_RENDER_BASE_SHIFT
  if raw = 0 then return 10
  return CInt(raw)
end property

property EvalValue.renderBase(byval v as Integer)
  this.flags and= not CUInt(EVF_RENDER_BASE_MASK)
  this.flags or= (CUInt(v and &hFF) shl EVF_RENDER_BASE_SHIFT)
end property

property EvalValue.expandArgs() as Boolean
  return (this.flags and EVF_EXPAND_ARGS) <> 0
end property

property EvalValue.expandArgs(byval v as Boolean)
  if v then
    this.flags or= EVF_EXPAND_ARGS
  else
    this.flags and= not CUInt(EVF_EXPAND_ARGS)
  end if
end property

property EvalValue.renderUnsigned() as Boolean
  return (this.flags and EVF_RENDER_UNSIGNED) <> 0
end property

property EvalValue.renderUnsigned(byval v as Boolean)
  if v then
    this.flags or= EVF_RENDER_UNSIGNED
  else
    this.flags and= not CUInt(EVF_RENDER_UNSIGNED)
  end if
end property

type VarEntry
  name as String
  value as EvalValue
end type

type FuncEntry
  name as String
  params(any) as String
  expr as String
end type

#include once "MathParserFactorInt.bas"

#define __FB_FUNC_VARS_OVERRIDE_GLOBALS__ 1
'
'  With a fixed formal probe of 0, `f(x)=1%x` fails validation (mod 0).
'  With 1, `f(x)=1%(x-1)` can fail (again, mode 0).
'  When this define is enabled, each formal parameter is given the value
'  of scalar variable `_` during UDF body validation if `_` exists,
'  otherwise the default probe 1.
'  Example: `_=10; f(x)=1%(x-1)` passes the validation.
'  Runtime calls still use real arguments.
'
'  Without this define, `x=1; f(x)=1%x` and `x=2; f(x)=1%(x-1)` work by
'  seeding x during validation when a global variable shares a formal name.
'  A name is either a user function or a variable: defining f(...) removes variable f;
'  assigning to x removes user function x (see SetUserFunction / assignment path).

dim shared variables() as VarEntry
dim shared userFunctions() as FuncEntry
dim shared pStream as ZString ptr
dim shared parseError as Integer
dim shared arrayIndexBracketDepth as Integer = 0
dim shared wasPercentage as Boolean
dim shared lastErrorText as String
dim shared lastRawResultValid as Boolean = FALSE
dim shared lastRawResult as RawResult
dim shared unknownVarsText as String
dim shared unknownFuncsText as String
#ifdef __FB_FUNC_VARS_OVERRIDE_GLOBALS__
dim shared functionVariableNames() as String
dim shared functionVariableCount as Integer
#endif
dim shared evalDepth as Integer
const UDF_CALL_STACK_MAX as Integer = 128
dim shared udfCallStack(0 to UDF_CALL_STACK_MAX - 1) as String
dim shared udfCallStackSp as Integer
dim shared validatingUserFunctionName as String
' suppressBareFunctionTailHint: skip bare-function tail hints when ';' context was lost.
' Path A: whole bare name + ';' (e.g. cos;) -> unexpected token in TryEvaluateTopLevelStatements.
' Path B: ';' still in pStream -> TryHandleBareBuiltinOrUdfIdent checks pStream[0].
' Path C: trailing ';' stripped or stmt split without ';' -> set flag from normalize return or caller.
dim shared suppressBareFunctionTailHint as Boolean
dim shared exprStart as ZString ptr
dim shared errorBaseCol as Integer
dim shared rootInputExpr as String
dim shared sortbyKeyParseErrorCol as Integer = 0
dim shared sortbyKeyBodyParseErrorCol as Integer = 0
dim shared sortbyLambdaEvalBodyErrorCol as Integer = 0
dim shared Parser_ShowErrorLine as Boolean = FALSE
dim shared Parser_SupportComplexNumbers as Boolean = FALSE
dim shared Parser_SupportTimeValues as Boolean = TRUE
dim shared Parser_SupportLambdaFunctions as Boolean = TRUE

private function MakeNaN() as Double
  return 0.0 / 0.0
end function

private function IsNaNValue(byval d as Double) as Boolean
  return (_isnan(d) <> 0)
end function

private function IsInfValue(byval d as Double) as Boolean
  if _isnan(d) <> 0 then return FALSE
  dim infV as Double = 1.0 / 0.0
  return abs(d) = infV
end function

private function IsNonFiniteValue(byval d as Double) as Boolean
  return IsNaNValue(d) orelse IsInfValue(d)
end function

private function RoundHalfUpDoubleToLongInt(byval x as Double) as LongInt
  if IsNonFiniteValue(x) then return 0
  if x >= 0 then
    return CLngInt(Int(x + 0.5))
  end if
  return -CLngInt(Int(-x + 0.5))
end function

private function ULongIntToString(byval x as ULongInt) as String
  if x = 0 then return "0"
  dim s as String = ""
  while x > 0
    s = chr(48 + (x mod 10)) + s
    x \= 10
  wend
  return s
end function

private function Pad2Digits(byval n as LongInt) as String
  if n < 0 then n = 0
  if n >= 100 then return ltrim(str(n))
  if n >= 10 then return chr(48 + n \ 10) & chr(48 + n mod 10)
  return "0" & chr(48 + n mod 10)
end function

private function ScalarIsTime(byref sv as ScalarValue) as Boolean
  if Parser_SupportTimeValues = FALSE then return FALSE
  return (sv.scalarStorageKind = SSK_TIME)
end function

private function TimeTotalMsFromScalarValue(byref sv as ScalarValue) as LongInt
  return sv.exactInt64
end function

private function FormatTimeCanonicalFromMs(byval totalMs as LongInt) as String
  dim neg as Boolean = (totalMs < 0)
  dim rU as ULongInt
  if neg then
    if totalMs = FB_I64_MIN then
      rU = CULngInt(FB_I64_MIN_MAG_U)
    else
      rU = CULngInt(-totalMs)
    end if
  else
    rU = CULngInt(totalMs)
  end if
  dim msPart as LongInt = CLngInt(rU mod 1000ull)
  rU = rU \ 1000ull
  dim sPart as LongInt = CLngInt(rU mod 60ull)
  rU = rU \ 60ull
  dim mPart as LongInt = CLngInt(rU mod 60ull)
  rU = rU \ 60ull
  dim hPart as LongInt = CLngInt(rU mod 24ull)
  rU = rU \ 24ull
  dim dPart as ULongInt = rU
  dim body as String
  if dPart > 0ull then
    body = ULongIntToString(dPart) & ":" & Pad2Digits(hPart) & ":" & Pad2Digits(mPart) & ":" & Pad2Digits(sPart)
  elseif hPart > 0 then
    body = Pad2Digits(hPart) & ":" & Pad2Digits(mPart) & ":" & Pad2Digits(sPart)
  else
    body = Pad2Digits(mPart) & ":" & Pad2Digits(sPart)
  end if
  if msPart <> 0 then
    body &= "." & chr(48 + (msPart \ 100)) & chr(48 + ((msPart \ 10) mod 10)) & chr(48 + (msPart mod 10))
  end if
  if neg then return "-" & body
  return body
end function

private sub ValueSetTimeMs(byref v as EvalValue, byval totalMs as LongInt)
  v.kind = VK_SCALAR
  v.scalarStorageKind = SSK_TIME
  v.scalar = CDbl(totalMs) / 1000.0
  v.exactInt64Valid = FALSE
  v.exactInt64 = totalMs
  v.exactUInt64Valid = FALSE
  v.exactUInt64 = 0
  v.expandArgs = FALSE
  v.renderBase = 10
  v.renderUnsigned = FALSE
  erase v.arr
end sub

private function TryAddTimeMsChecked(byval a as LongInt, byval b as LongInt, byref outMs as LongInt) as Boolean
  dim t as Double = CDbl(a) + CDbl(b)
  if t < CDbl(FB_I64_MIN) orelse t > CDbl(FB_I64_MAX) then return FALSE
  outMs = RoundHalfUpDoubleToLongInt(t)
  return TRUE
end function

private function TrySubTimeMsChecked(byval a as LongInt, byval b as LongInt, byref outMs as LongInt) as Boolean
  dim t as Double = CDbl(a) - CDbl(b)
  if t < CDbl(FB_I64_MIN) orelse t > CDbl(FB_I64_MAX) then return FALSE
  outMs = RoundHalfUpDoubleToLongInt(t)
  return TRUE
end function

private function ScalarHasRenderRational(byref sv as ScalarValue) as Boolean
  return (sv.flags and SVF_RENDER_RATIONAL) <> 0
end function

private function ScalarHasImagRenderRational(byref sv as ScalarValue) as Boolean
  return (sv.flags and SVF_IMAG_RENDER_RATIONAL) <> 0
end function

private function ScalarExactInt64MetadataValid(byref sv as ScalarValue) as Boolean
  return (sv.flags and SVF_EXACT_INT64_VALID) <> 0
end function

private function ScalarExactUInt64MetadataValid(byref sv as ScalarValue) as Boolean
  return (sv.flags and SVF_EXACT_UINT64_VALID) <> 0
end function

private function ScalarImagExactInt64MetadataValid(byref sv as ScalarValue) as Boolean
  return (sv.flags and SVF_IMAG_EXACT_INT64_VALID) <> 0
end function

private function ScalarImagExactUInt64MetadataValid(byref sv as ScalarValue) as Boolean
  return (sv.flags and SVF_IMAG_EXACT_UINT64_VALID) <> 0
end function

private function ScalarImagExactInt64Valid(byref sv as ScalarValue) as Boolean
  if ScalarHasImagRenderRational(sv) then return FALSE
  return ScalarImagExactInt64MetadataValid(sv)
end function

private function ScalarImagExactUInt64Valid(byref sv as ScalarValue) as Boolean
  if ScalarHasImagRenderRational(sv) then return FALSE
  return ScalarImagExactUInt64MetadataValid(sv)
end function

private function ScalarHasNonzeroImaginaryPart(byref sv as ScalarValue) as Boolean
  ' NaN comparisons are not reliable for "nonzero" checks, and we must not
  ' normalize complex values with NaN/Inf imaginary components into pure-real.
  if IsNaNValue(sv.imag) then return TRUE
  if IsInfValue(sv.imag) then return TRUE
  if sv.imag <> 0.0 then return TRUE
  if ScalarImagExactInt64Valid(sv) andalso sv.imagExactInt64 <> 0 then return TRUE
  return FALSE
end function

private function EvalValueHasNonzeroImaginary(byref v as EvalValue) as Boolean
  if v.kind = VK_SCALAR then
    return ScalarHasNonzeroImaginaryPart(v.scalarValue)
  end if
  dim j as Integer
  for j = lbound(v.arr) to ubound(v.arr)
    if ScalarHasNonzeroImaginaryPart(v.arr(j)) then return TRUE
  next j
  return FALSE
end function

private function CallArgsInvolveComplex(args() as EvalValue) as Boolean
  if Parser_SupportComplexNumbers = FALSE then return FALSE
  dim i as Integer
  if ubound(args) < lbound(args) then return FALSE
  for i = lbound(args) to ubound(args)
    if EvalValueHasNonzeroImaginary(args(i)) then return TRUE
  next i
  return FALSE
end function

declare function ApplyTimeBinaryScalars(byref leftS as ScalarValue, byref rightS as ScalarValue, byval op as UByte, byref outV as EvalValue) as Boolean
declare function FormatComplexScalarValue(byref sv as ScalarValue) as String
declare function ApplyUnaryComplexSupportScalars(byval fnId as Integer, byref scalarV as ScalarValue, byref outV as EvalValue) as Boolean
declare function ApplyUnaryComplexTrigById(byval fnId as Integer, byval ar as Double, byval ai as Double, byref outR as Double, byref outI as Double) as Boolean
declare function TryApplyUnaryComplexMathOverlay(byval fnId as Integer, byref scalarV as ScalarValue, byref outV as EvalValue) as Boolean
declare function ApplyUnaryBuiltin(byval fnId as Integer, byref scalarV as ScalarValue, byref outV as EvalValue) as Boolean
declare function TryApplyUnaryRealByKind(byval fnId as Integer, byref scalarV as ScalarValue, byref outV as EvalValue) as Boolean
declare sub calcRoundingFn(byval fnId as Integer, byref scalarV as ScalarValue, byref outV as EvalValue)
declare function TryApplyFactorialScalarInt(byval n as LongInt, byref outV as EvalValue) as Boolean

private function ExprStartPointsIntoRootInput() as Boolean
  if len(rootInputExpr) = 0 then return FALSE
  if exprStart = 0 then return FALSE
  dim root0 as ZString ptr = StrPtr(rootInputExpr)
  dim rootEnd as ZString ptr = root0 + len(rootInputExpr)
  return (exprStart >= root0) andalso (exprStart <= rootEnd)
end function

private function ExprTextForErrorSnippet() as String
  if len(rootInputExpr) > 0 then
    if exprStart = 0 orelse ExprStartPointsIntoRootInput() then
      return rootInputExpr
    end if
  end if
  if exprStart = 0 then return ""
  if len(rootInputExpr) > 0 then return rootInputExpr
  return *exprStart
end function

private function BuildErrorSnippet(byval col as Integer, byref exprText as String) as String
  if len(exprText) = 0 then return ""

  dim exprLen as Integer = len(exprText)
  if col < 1 then col = 1
  if col > exprLen + 1 then col = exprLen + 1

  dim leftSpan as Integer = 18
  dim rightSpan as Integer = 18
  dim startPos as Integer = col - leftSpan
  dim endPos as Integer = col + rightSpan
  if startPos < 1 then startPos = 1
  if endPos > exprLen then endPos = exprLen
  if endPos < startPos then endPos = startPos

  dim snippet as String = mid(exprText, startPos, endPos - startPos + 1)
  dim markerPos as Integer = col - startPos + 1
  if markerPos < 1 then markerPos = 1
  if markerPos > len(snippet) + 1 then markerPos = len(snippet) + 1
  return left(snippet, markerPos - 1) & "|" & mid(snippet, markerPos)
end function

private function StripErrorLocationSuffix(byref errFull as String) as String
  dim posAt as Integer = instr(errFull, FB_STR_AT)
  if posAt > 0 then return left(errFull, posAt - 1)
  return errFull
end function

private sub SetParseErrorAtColumn(byref msg as String, byval col as Integer)
  if parseError = 0 then parseError = 1
  if lastErrorText <> "" then exit sub
  dim exprText as String = rootInputExpr
  if len(exprText) = 0 then exprText = ExprTextForErrorSnippet()
  if len(exprText) = 0 then
    lastErrorText = msg
    exit sub
  end if
  dim locationPart as String = FB_STR_AT
  if Parser_ShowErrorLine then locationPart = locationPart & FB_STR_LINE_1_PREFIX
  locationPart = locationPart & FB_STR_COL & ltrim(str(col)) & FB_STR_COLON
  lastErrorText = msg & locationPart & BuildErrorSnippet(col, exprText)
end sub

private function CurrentParseErrorColumn() as Integer
  if exprStart = 0 then return 0
  return errorBaseCol + (pStream - exprStart)
end function

private sub CopySortbyKeyParseColumnsToEvalValue(byref outV as EvalValue)
  outV.sortbyKeyErrorCol = sortbyKeyParseErrorCol
  outV.sortbyKeyBodyErrorCol = sortbyKeyBodyParseErrorCol
end sub

private function SortbyKeyFunctionFailureMessage(byref innerMsg as String) as String
  if innerMsg = "" then return FB_STR_INCOMPATIBLE_OPERANDS
  if instr(innerMsg, FB_STR_USER_DEFINED_FUNCTION_COLON) > 0 then return innerMsg
  if instr(innerMsg, FB_STR_HINT_PREFIX) > 0 then return innerMsg
  return innerMsg
end function

private sub RemapParseErrorToSortbyKeyColumn(byref keyArg as EvalValue)
  dim msg as String = SortbyKeyFunctionFailureMessage(StripErrorLocationSuffix(lastErrorText))
  dim col as Integer = 0
  if sortbyLambdaEvalBodyErrorCol > 0 andalso keyArg.sortbyKeyBodyErrorCol > 0 then
    col = keyArg.sortbyKeyBodyErrorCol + sortbyLambdaEvalBodyErrorCol - 1
    if instr(msg, FB_STR_UNKNOWN_VARIABLE_COLON) > 0 then
      dim uvName as String = trim(mid(msg, instr(msg, FB_STR_UNKNOWN_VARIABLE_COLON) + len(FB_STR_UNKNOWN_VARIABLE_COLON)))
      if len(uvName) > 0 then
        dim identCol as Integer = instr(keyArg.sortbyKeyBodyErrorCol, rootInputExpr, uvName)
        if identCol > 0 then col = identCol
      end if
    end if
  elseif keyArg.sortbyKeyErrorCol > 0 then
    col = keyArg.sortbyKeyErrorCol
  end if
  sortbyLambdaEvalBodyErrorCol = 0
  if col <= 0 then exit sub
  lastErrorText = ""
  parseError = 0
  SetParseErrorAtColumn(msg, col)
end sub

private sub SetParseError(byref msg as String)
  if parseError = 0 then parseError = 1
  if lastErrorText = "" then
    dim isExpr as Boolean = (exprStart <> 0) andalso (pStream <> 0) andalso (pStream >= exprStart)
    if isExpr andalso ExprStartPointsIntoRootInput() then
      dim col as Integer = CurrentParseErrorColumn()
      dim exprText as String = ExprTextForErrorSnippet()
      if len(exprText) = 0 then
        lastErrorText = msg
      else
        dim locationPart as String = FB_STR_AT
        if Parser_ShowErrorLine then locationPart = locationPart & FB_STR_LINE_1_PREFIX
        locationPart = locationPart & FB_STR_COL & ltrim(str(col)) & FB_STR_COLON
        lastErrorText = msg & locationPart & BuildErrorSnippet(col, exprText)
      end if
    else
      lastErrorText = msg
    end if
  end if
end sub

private function ParseErrorTextById(byval id as ParseErrorId) as String
  select case id
    case PARSE_ERR_UNEXPECTED_COMMA: return FB_STR_UNEXPECTED_COMMA
    case PARSE_ERR_INDEXING_REQUIRES_ARRAY: return FB_STR_INDEXING_REQUIRES_AN_ARRAY_VALUE
    case PARSE_ERR_MISSING_INDEX: return FB_STR_MISSING_INDEX
    case PARSE_ERR_ARRAY_INDEX_MUST_BE_SCALAR: return FB_STR_ARRAY_INDEX_MUST_BE_A_SCALAR
    case PARSE_ERR_ARRAY_INDEX_MUST_BE_INTEGER: return FB_STR_ARRAY_INDEX_MUST_BE_AN_INTEGER
    case PARSE_ERR_ARRAY_INDEX_OUT_OF_RANGE: return FB_STR_ARRAY_INDEX_IS_OUT_OF_RANGE
    case PARSE_ERR_MISSING_CLOSING_BRACKET: return FB_STR_MISSING_CLOSING_BRACKET
    case PARSE_ERR_MISSING_CLOSING_PARENTHESIS: return FB_STR_MISSING_CLOSING_PARENTHESIS
    case PARSE_ERR_MISMATCHED_CLOSING_PARENTHESIS: return FB_STR_MISMATCHED_CLOSING_PARENTHESIS
    case PARSE_ERR_MISMATCHED_CLOSING_BRACKET: return FB_STR_MISMATCHED_CLOSING_BRACKET
    case PARSE_ERR_MISMATCHED_CLOSING_BRACE: return FB_STR_MISMATCHED_CLOSING_BRACE
    case PARSE_ERR_BITWISE_INTEGER_OPERANDS: return FB_STR_BITWISE_OPERANDS_MUST_BE_INTEGER_VALUES
    case PARSE_ERR_MODULO_INTEGER_OPERANDS: return FB_STR_MODULO_OPERANDS_MUST_BE_INTEGER_VALUES
    case PARSE_ERR_INCOMPATIBLE_OPERANDS: return FB_STR_INCOMPATIBLE_OPERANDS
    case PARSE_ERR_INVALID_HEX_LITERAL: return FB_STR_INVALID_HEX_LITERAL
    case PARSE_ERR_INVALID_BINARY_LITERAL: return FB_STR_INVALID_BINARY_LITERAL
    case PARSE_ERR_INVALID_OCTAL_LITERAL: return FB_STR_INVALID_OCTAL_LITERAL
    case PARSE_ERR_INTERNAL_UNARY_OP: return FB_STR_INTERNAL_UNARY_OP
    case PARSE_ERR_INTERNAL_BINARY_OP: return FB_STR_INTERNAL_BINARY_OP
    case PARSE_ERR_INTERNAL_EVAL_ERROR: return FB_STR_INTERNAL_EVAL_ERROR
    case PARSE_ERR_NUMERIC_ERROR_IN_POWER_OPERATION: return FB_STR_NUMERIC_ERROR_IN_POWER_OPERATION
    case PARSE_ERR_NUMERIC_ERROR_IN_EXPRESSION: return FB_STR_NUMERIC_ERROR_IN_EXPRESSION
    case PARSE_ERR_USER_FUNCTION_CALL_STACK_OVERFLOW: return FB_STR_USER_FUNCTION_CALL_STACK_OVERFLOW
    case PARSE_ERR_MAX_EVALUATION_DEPTH_REACHED: return FB_STR_MAX_EVALUATION_DEPTH_REACHED
    case PARSE_ERR_INVALID_NUMERIC_LITERAL: return FB_STR_INVALID_NUMERIC_LITERAL
    case PARSE_ERR_PERCENTAGE_REQUIRES_SCALAR_VALUE: return FB_STR_PERCENTAGE_REQUIRES_SCALAR_VALUE
    case PARSE_ERR_FAILED_TO_BUILD_ARRAY_LITERAL: return FB_STR_FAILED_TO_BUILD_ARRAY_LITERAL
    case PARSE_ERR_INTERNAL_AGGREGATE_BUILTIN: return FB_STR_INTERNAL_ERROR_IN_AGGREGATE_BUILTIN
    case PARSE_ERR_INTERNAL_SCALAR_BINARY_BUILTIN: return FB_STR_INTERNAL_ERROR_IN_SCALAR_BINARY_BUILTIN
    case PARSE_ERR_INTERNAL_UNARY_MATH_BUILTIN: return FB_STR_INTERNAL_ERROR_IN_UNARY_MATH_BUILTIN
    case PARSE_ERR_UNEXPECTED_TOKEN_AFTER_EXPRESSION: return FB_STR_UNEXPECTED_TOKEN_AFTER_EXPRESSION
    case PARSE_ERR_SCALAR_ONLY_EXPRESSION_ENCOUNTERED_NON: return FB_STR_SCALAR_ONLY_EXPRESSION_ENCOUNTERED_NON
    case PARSE_ERR_PARSE_FAILED: return FB_STR_PARSE_FAILED
    case PARSE_ERR_UNEXPECTED_TOKEN: return FB_STR_UNEXPECTED_TOKEN
    case PARSE_ERR_UNEXPECTED_INPUT: return FB_STR_UNEXPECTED_INPUT
    case else: return ""
  end select
end function

private sub SetParseErrorById(byval id as ParseErrorId)
  dim msg as String = ParseErrorTextById(id)
  SetParseError(msg)
end sub

private sub AppendUniqueName(byref listText as String, byref n as String)
  dim token as String = "," & listText & ","
  if instr(token, "," & n & ",") > 0 then exit sub
  if listText = "" then
    listText = n
  else
    listText &= FB_STR_COMMA & n
  end if
end sub

' Builtin metadata: one row per builtin in K_BUILTIN_META_ROWS (mirrors C++ kBuiltinMeta[] + kUnaryScalarKind[]).
private const BUILTIN_META_ARITY_UNSET as UByte = 254
private const BUILTIN_META_ARITY_UNBOUNDED as UByte = 255

private const BUILTIN_FLAG_UNARY as UInteger = 1u shl 0
private const BUILTIN_FLAG_FORMAT as UInteger = 1u shl 1
private const BUILTIN_FLAG_INTEGER_ONLY as UInteger = 1u shl 2
private const BUILTIN_FLAG_NON_CALCULATING as UInteger = 1u shl 3
private const BUILTIN_FLAG_FINITE_REQUIRED as UInteger = 1u shl 4
private const BUILTIN_FLAG_TRAILING_FORMATTER as UInteger = 1u shl 5

type BuiltinMetaRow
  flags as UInteger
  minArgs as UByte
  maxArgs as UByte
  hintKind as UByte
  unaryScalarKind as UnaryScalarKind
  category as BuiltinCategory
end type

dim shared as BuiltinMetaRow K_BUILTIN_META_ROWS(0 to FUNC__COUNT - 1) = { _
  (BUILTIN_FLAG_NON_CALCULATING, 0, 0, BHK_EMPTY_PAR, USK_NONE, BC_RAND), _ ' Rand
  (BUILTIN_FLAG_FINITE_REQUIRED, 2, 2, BHK_MIN_MAX, USK_NONE, BC_SCALAR_BINARY), _ ' Random
  (BUILTIN_FLAG_FORMAT or BUILTIN_FLAG_NON_CALCULATING or BUILTIN_FLAG_TRAILING_FORMATTER, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_BASE_FORMAT), _ ' Bin
  (BUILTIN_FLAG_FORMAT or BUILTIN_FLAG_NON_CALCULATING or BUILTIN_FLAG_TRAILING_FORMATTER, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_BASE_FORMAT), _ ' Hex
  (BUILTIN_FLAG_FORMAT or BUILTIN_FLAG_NON_CALCULATING or BUILTIN_FLAG_TRAILING_FORMATTER, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_BASE_FORMAT), _ ' Oct
  (0u, 2, 2, BHK_VALUE_POWER, USK_NONE, BC_POW), _ ' Pow
  (0u, 2, 2, BHK_Y_X, USK_NONE, BC_SCALAR_BINARY), _ ' Atan2
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_ANGLE, USK_PRIMARY_TRIG, BC_UNARY_MATH), _ ' Sin
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_ANGLE, USK_PRIMARY_TRIG, BC_UNARY_MATH), _ ' Cos
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_ANGLE, USK_PRIMARY_TRIG, BC_UNARY_MATH), _ ' Tan
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_INVERSE_TRIG, BC_UNARY_MATH), _ ' Asin
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_INVERSE_TRIG, BC_UNARY_MATH), _ ' Acos
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_INVERSE_TRIG, BC_UNARY_MATH), _ ' Atan
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_HYPERBOLIC_TRIG, BC_UNARY_MATH), _ ' Sinh
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_HYPERBOLIC_TRIG, BC_UNARY_MATH), _ ' Cosh
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_HYPERBOLIC_TRIG, BC_UNARY_MATH), _ ' Tanh
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_INVERSE_HYPERBOLIC_TRIG, BC_UNARY_MATH), _ ' Acosh
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_INVERSE_HYPERBOLIC_TRIG, BC_UNARY_MATH), _ ' Asinh
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_INVERSE_HYPERBOLIC_TRIG, BC_UNARY_MATH), _ ' Atanh
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_EXP, BC_UNARY_MATH), _ ' Exp
  (0u, 2, 2, BHK_VALUE_BASE, USK_NONE, BC_LOG), _ ' Log
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_LN, BC_UNARY_MATH), _ ' Ln
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_LOG10, BC_UNARY_MATH), _ ' Log10
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_SQRT, BC_UNARY_MATH), _ ' Sqrt
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_SQR, BC_UNARY_MATH), _ ' Sqr
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_ROUNDING, BC_UNARY_MATH), _ ' Int
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_FRAC, BC_UNARY_MATH), _ ' Frac
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_ABS, BC_UNARY_MATH), _ ' Abs
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_ROUNDING, BC_UNARY_MATH), _ ' Floor
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_ROUNDING, BC_UNARY_MATH), _ ' Ceil
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_ROUNDING, BC_UNARY_MATH), _ ' Trunc
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_ROUNDING, BC_UNARY_MATH), _ ' Round
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_SIGN, BC_UNARY_MATH), _ ' Sign
  (BUILTIN_FLAG_TRAILING_FORMATTER, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_DEG, BC_DEG_RAD), _ ' Deg
  (BUILTIN_FLAG_TRAILING_FORMATTER, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_RAD, BC_DEG_RAD), _ ' Rad
  (0u, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_AGGREGATE), _ ' Sum
  (0u, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_AGGREGATE), _ ' Median
  (0u, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_AGGREGATE), _ ' Variance
  (0u, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_AGGREGATE), _ ' Stddev
  (BUILTIN_FLAG_NON_CALCULATING, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_ARRAY_TRANSFORM), _ ' Sort
  (BUILTIN_FLAG_NON_CALCULATING, 2, 2, BHK_ARRAY_FUNC, USK_NONE, BC_SORTBY), _ ' Sortby
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_NONE, BC_RATIO), _ ' Ratio
  (BUILTIN_FLAG_NON_CALCULATING, 2, 3, BHK_START_STOP_STEP, USK_NONE, BC_RANGE), _ ' Range
  (BUILTIN_FLAG_NON_CALCULATING, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_ARRAY_TRANSFORM), _ ' Reverse
  (BUILTIN_FLAG_NON_CALCULATING, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_ARRAY_TRANSFORM), _ ' Unique
  (BUILTIN_FLAG_NON_CALCULATING, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_ARRAY_TRANSFORM), _ ' Unpack
  (BUILTIN_FLAG_NON_CALCULATING, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_ARRAY_TRANSFORM), _ ' Flat
  (BUILTIN_FLAG_NON_CALCULATING, 2, 2, BHK_X_N, USK_NONE, BC_REPEAT), _ ' Repeat
  (BUILTIN_FLAG_NON_CALCULATING, 0, BUILTIN_META_ARITY_UNBOUNDED, BHK_X, USK_NONE, BC_ARRAY_TRANSFORM), _ ' Len
  (BUILTIN_FLAG_UNARY or BUILTIN_FLAG_INTEGER_ONLY, 1, 1, BHK_N, USK_NONE, BC_FACTORIAL), _ ' Fact
  (BUILTIN_FLAG_UNARY or BUILTIN_FLAG_INTEGER_ONLY, 1, 1, BHK_N, USK_NONE, BC_FACTORINT), _ ' Factorint
  (0u, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_AGGREGATE), _ ' Avg
  (0u, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_AGGREGATE), _ ' Mean
  (BUILTIN_FLAG_INTEGER_ONLY, 2, 2, BHK_VALUE_DIVISOR, USK_NONE, BC_MOD), _ ' Mod
  (0u, 3, 3, BHK_VALUE_MIN_MAX, USK_NONE, BC_SCALAR_BINARY), _ ' Clamp
  (0u, 2, 2, BHK_X_Y, USK_NONE, BC_SCALAR_BINARY), _ ' Hypot
  (BUILTIN_FLAG_INTEGER_ONLY, 2, 2, BHK_A_B, USK_NONE, BC_SCALAR_BINARY), _ ' Gcd
  (BUILTIN_FLAG_INTEGER_ONLY, 2, 2, BHK_A_B, USK_NONE, BC_SCALAR_BINARY), _ ' Lcm
  (BUILTIN_FLAG_INTEGER_ONLY, 2, 2, BHK_N_R, USK_NONE, BC_SCALAR_BINARY), _ ' Ncr
  (BUILTIN_FLAG_INTEGER_ONLY, 2, 2, BHK_N_R, USK_NONE, BC_SCALAR_BINARY), _ ' Npr
  (0u, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_AGGREGATE), _ ' Product
  (0u, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_AGGREGATE), _ ' Min
  (0u, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_AGGREGATE), _ ' Max
  (BUILTIN_FLAG_FORMAT or BUILTIN_FLAG_NON_CALCULATING or BUILTIN_FLAG_TRAILING_FORMATTER, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_BASE_FORMAT), _ ' Uhex
  (BUILTIN_FLAG_FORMAT or BUILTIN_FLAG_NON_CALCULATING or BUILTIN_FLAG_TRAILING_FORMATTER, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_BASE_FORMAT), _ ' Uoct
  (BUILTIN_FLAG_FORMAT or BUILTIN_FLAG_NON_CALCULATING or BUILTIN_FLAG_TRAILING_FORMATTER, 1, BUILTIN_META_ARITY_UNBOUNDED, BHK_DOTDOTDOT, USK_NONE, BC_BASE_FORMAT), _ ' Ubin
  (0u, 1, 1, BHK_VALUE, USK_NONE, BC_TIME_UNIT), _ ' Milliseconds
  (0u, 1, 1, BHK_VALUE, USK_NONE, BC_TIME_UNIT), _ ' Seconds
  (0u, 1, 1, BHK_VALUE, USK_NONE, BC_TIME_UNIT), _ ' Minutes
  (0u, 1, 1, BHK_VALUE, USK_NONE, BC_TIME_UNIT), _ ' Hours
  (0u, 1, 1, BHK_VALUE, USK_NONE, BC_TIME_UNIT), _ ' Days
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_NONE, BC_UNARY_MATH), _ ' Real
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_NONE, BC_UNARY_MATH), _ ' Imag
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_NONE, BC_UNARY_MATH), _ ' Phase
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_NONE, BC_POLAR_CART), _ ' Polar
  (0u, 1, 2, BHK_VALUE, USK_NONE, BC_POLAR_CART), _ ' Cart
  (BUILTIN_FLAG_UNARY, 1, 1, BHK_VALUE, USK_NONE, BC_UNARY_MATH) _ ' Conj
}

enum OperatorNameId
  OP_NOT = 0
  OP_AND
  OP_OR
  OP_MOD
  OP__COUNT
end enum

enum OperatorCmpNameId
  OP_CMP_NONE = 0
  OP_CMP_EQ  ' =, ==
  OP_CMP_NE  ' <>, !=
  OP_CMP_LT  ' <
  OP_CMP_GT  ' >
  OP_CMP_LE  ' <=
  OP_CMP_GE  ' >=
  OP_CMP__COUNT
end enum

enum OperatorBitNameId
  OP_BIT_NONE = 0
  OP_BIT_AND  ' &
  OP_BIT_OR   ' |
  OP_BIT_XOR  ' ^
  OP_BIT_SHL  ' <<
  OP_BIT_SHR  ' >>
  OP_BIT_MOD  ' % (mod)
  OP_BIT__COUNT
end enum

enum BuiltinConstId
  CONST_PI = 0
  CONST_E
  CONST_INF
  CONST_NAN
  CONST_MILLISECOND
  CONST_SECOND
  CONST_MINUTE
  CONST_HOUR
  CONST_DAY
  CONST_I
  CONST__COUNT
end enum

dim shared FunctionNames(0 to FUNC__COUNT - 1) as String
dim shared OperatorNames(0 to OP__COUNT - 1) as String
dim shared ConstNames(0 to CONST__COUNT - 1) as String
dim shared FunctionNamesInitialized as Boolean = FALSE
dim shared OperatorNamesInitialized as Boolean = FALSE
dim shared ConstNamesInitialized as Boolean = FALSE
const BUILTIN_FN_LOOKUP_CAPACITY as Integer = 127
dim shared BuiltinFnLookupKeys(0 to BUILTIN_FN_LOOKUP_CAPACITY - 1) as String
dim shared BuiltinFnLookupIds(0 to BUILTIN_FN_LOOKUP_CAPACITY - 1) as Integer
dim shared BuiltinFnLookupInitialized as Boolean = FALSE
const BUILTIN_CONST_LOOKUP_CAPACITY as Integer = 32
dim shared BuiltinConstLookupKeys(0 to BUILTIN_CONST_LOOKUP_CAPACITY - 1) as String
dim shared BuiltinConstLookupIds(0 to BUILTIN_CONST_LOOKUP_CAPACITY - 1) as Integer
dim shared BuiltinConstLookupInitialized as Boolean = FALSE

private sub EnsureFunctionNames()
  if FunctionNamesInitialized then exit sub
  FunctionNames(FUNC_RAND) = FB_STR_RAND
  FunctionNames(FUNC_RANDOM) = FB_STR_RANDOM
  FunctionNames(FUNC_BIN) = FB_STR_BIN
  FunctionNames(FUNC_HEX) = FB_STR_HEX
  FunctionNames(FUNC_OCT) = FB_STR_OCT
  FunctionNames(FUNC_POW) = FB_STR_POW
  FunctionNames(FUNC_ATAN2) = FB_STR_ATAN2
  FunctionNames(FUNC_SIN) = FB_STR_SIN
  FunctionNames(FUNC_COS) = FB_STR_COS
  FunctionNames(FUNC_TAN) = FB_STR_TAN
  FunctionNames(FUNC_ASIN) = FB_STR_ASIN
  FunctionNames(FUNC_ACOS) = FB_STR_ACOS
  FunctionNames(FUNC_ATAN) = FB_STR_ATAN
  FunctionNames(FUNC_SINH) = FB_STR_SINH
  FunctionNames(FUNC_COSH) = FB_STR_COSH
  FunctionNames(FUNC_TANH) = FB_STR_TANH
  FunctionNames(FUNC_ACOSH) = FB_STR_ACOSH
  FunctionNames(FUNC_ASINH) = FB_STR_ASINH
  FunctionNames(FUNC_ATANH) = FB_STR_ATANH
  FunctionNames(FUNC_EXP) = FB_STR_EXP
  FunctionNames(FUNC_LOG) = FB_STR_LOG
  FunctionNames(FUNC_LN) = FB_STR_LN
  FunctionNames(FUNC_LOG10) = FB_STR_LOG10
  FunctionNames(FUNC_SQRT) = FB_STR_SQRT
  FunctionNames(FUNC_SQR) = FB_STR_SQR
  FunctionNames(FUNC_INT) = FB_STR_INT
  FunctionNames(FUNC_FRAC) = FB_STR_FRAC
  FunctionNames(FUNC_ABS) = FB_STR_ABS
  FunctionNames(FUNC_FLOOR) = FB_STR_FLOOR
  FunctionNames(FUNC_CEIL) = FB_STR_CEIL
  FunctionNames(FUNC_TRUNC) = FB_STR_TRUNC
  FunctionNames(FUNC_ROUND) = FB_STR_ROUND
  FunctionNames(FUNC_SIGN) = FB_STR_SIGN
  FunctionNames(FUNC_DEG) = FB_STR_DEG
  FunctionNames(FUNC_RAD) = FB_STR_RAD
  FunctionNames(FUNC_SUM) = FB_STR_SUM
  FunctionNames(FUNC_MEDIAN) = FB_STR_MEDIAN
  FunctionNames(FUNC_VARIANCE) = FB_STR_VARIANCE
  FunctionNames(FUNC_STDDEV) = FB_STR_STDDEV
  FunctionNames(FUNC_SORT) = FB_STR_SORT
  FunctionNames(FUNC_SORTBY) = FB_STR_SORTBY
  FunctionNames(FUNC_RATIO) = FB_STR_RATIO
  FunctionNames(FUNC_RANGE) = FB_STR_RANGE
  FunctionNames(FUNC_REVERSE) = FB_STR_REVERSE
  FunctionNames(FUNC_UNIQUE) = FB_STR_UNIQUE
  FunctionNames(FUNC_UNPACK) = FB_STR_UNPACK
  FunctionNames(FUNC_FLAT) = FB_STR_FLAT
  FunctionNames(FUNC_REPEAT) = FB_STR_REPEAT
  FunctionNames(FUNC_LEN) = FB_STR_LEN
  FunctionNames(FUNC_FACT) = FB_STR_FACT
  FunctionNames(FUNC_FACTORINT) = FB_STR_FACTORINT
  FunctionNames(FUNC_AVG) = FB_STR_AVG
  FunctionNames(FUNC_MEAN) = FB_STR_MEAN
  FunctionNames(FUNC_MOD) = FB_STR_MOD
  FunctionNames(FUNC_CLAMP) = FB_STR_CLAMP
  FunctionNames(FUNC_HYPOT) = FB_STR_HYPOT
  FunctionNames(FUNC_GCD) = FB_STR_GCD
  FunctionNames(FUNC_LCM) = FB_STR_LCM
  FunctionNames(FUNC_NCR) = FB_STR_NCR
  FunctionNames(FUNC_NPR) = FB_STR_NPR
  FunctionNames(FUNC_PRODUCT) = FB_STR_PRODUCT
  FunctionNames(FUNC_MIN) = FB_STR_MIN
  FunctionNames(FUNC_MAX) = FB_STR_MAX
  FunctionNames(FUNC_UHEX) = FB_STR_UHEX
  FunctionNames(FUNC_UOCT) = FB_STR_UOCT
  FunctionNames(FUNC_UBIN) = FB_STR_UBIN
  FunctionNames(FUNC_MILLISECONDS) = FB_STR_MILLISECONDS
  FunctionNames(FUNC_SECONDS) = FB_STR_SECONDS
  FunctionNames(FUNC_MINUTES) = FB_STR_MINUTES
  FunctionNames(FUNC_HOURS) = FB_STR_HOURS
  FunctionNames(FUNC_DAYS) = FB_STR_DAYS
  FunctionNames(FUNC_REAL) = FB_STR_REAL
  FunctionNames(FUNC_IMAG) = FB_STR_IMAG
  FunctionNames(FUNC_PHASE) = FB_STR_PHASE
  FunctionNames(FUNC_POLAR) = FB_STR_POLAR
  FunctionNames(FUNC_CART) = FB_STR_CART
  FunctionNames(FUNC_CONJ) = FB_STR_CONJ
  FunctionNamesInitialized = TRUE
end sub

private function HashLowerIdent(byref s as String) as UInteger
  dim h as UInteger = 2166136261u
  dim i as Integer
  for i = 1 to len(s)
    h xor= asc(mid(s, i, 1))
    h *= 16777619u
  next i
  return h
end function

private sub InsertBuiltinFnAliasLookup(byref aliasKey as String, byval id as Integer)
  dim slot as Integer = CInt(HashLowerIdent(aliasKey) mod BUILTIN_FN_LOOKUP_CAPACITY)
  dim probed as Integer
  for probed = 0 to BUILTIN_FN_LOOKUP_CAPACITY - 1
    if BuiltinFnLookupKeys(slot) = "" then
      BuiltinFnLookupKeys(slot) = aliasKey
      BuiltinFnLookupIds(slot) = id
      exit sub
    elseif BuiltinFnLookupKeys(slot) = aliasKey then
      exit sub
    end if
    slot = (slot + 1) mod BUILTIN_FN_LOOKUP_CAPACITY
  next probed
end sub

private sub EnsureBuiltinFunctionLookup()
  if BuiltinFnLookupInitialized then exit sub
  EnsureFunctionNames()
  dim i as Integer
  for i = 0 to BUILTIN_FN_LOOKUP_CAPACITY - 1
    BuiltinFnLookupKeys(i) = ""
    BuiltinFnLookupIds(i) = -1
  next i
  for i = 0 to FUNC__COUNT - 1
    dim key as String = FunctionNames(i)
    dim slot as Integer = CInt(HashLowerIdent(key) mod BUILTIN_FN_LOOKUP_CAPACITY)
    do while BuiltinFnLookupKeys(slot) <> ""
      slot = (slot + 1) mod BUILTIN_FN_LOOKUP_CAPACITY
    loop
    BuiltinFnLookupKeys(slot) = key
    BuiltinFnLookupIds(slot) = i
  next i
  InsertBuiltinFnAliasLookup FB_STR_ARCSIN, FUNC_ASIN
  InsertBuiltinFnAliasLookup FB_STR_ARCCOS, FUNC_ACOS
  InsertBuiltinFnAliasLookup FB_STR_ARCTAN, FUNC_ATAN
  InsertBuiltinFnAliasLookup FB_STR_FRACT, FUNC_FRAC
  InsertBuiltinFnAliasLookup FB_STR_SORTED, FUNC_SORT
  InsertBuiltinFnAliasLookup FB_STR_REVERSED, FUNC_REVERSE
  InsertBuiltinFnAliasLookup FB_STR_FACTORIAL, FUNC_FACT
  InsertBuiltinFnAliasLookup FB_STR_PROD, FUNC_PRODUCT
  InsertBuiltinFnAliasLookup FB_STR_LENGTH, FUNC_LEN
  BuiltinFnLookupInitialized = TRUE
end sub

private sub EnsureOperatorNames()
  if OperatorNamesInitialized then exit sub
  OperatorNames(OP_NOT) = FB_STR_NOT
  OperatorNames(OP_AND) = FB_STR_AND
  OperatorNames(OP_OR) = FB_STR_OR
  OperatorNames(OP_MOD) = FB_STR_MOD
  OperatorNamesInitialized = TRUE
end sub

'' Spelling for each BuiltinConstId; keep TryGetConstant in sync when adding constants.
private sub EnsureConstNames()
  if ConstNamesInitialized then exit sub
  ConstNames(CONST_PI) = FB_STR_PI
  ConstNames(CONST_E) = FB_STR_E
  ConstNames(CONST_INF) = FB_STR_INF
  ConstNames(CONST_NAN) = FB_STR_NAN
  ConstNames(CONST_MILLISECOND) = FB_STR_MILLISECOND
  ConstNames(CONST_SECOND) = FB_STR_SECOND
  ConstNames(CONST_MINUTE) = FB_STR_MINUTE
  ConstNames(CONST_HOUR) = FB_STR_HOUR
  ConstNames(CONST_DAY) = FB_STR_DAY
  ConstNames(CONST_I) = FB_STR_I
  ConstNamesInitialized = TRUE
end sub

private sub EnsureBuiltinConstLookup()
  if BuiltinConstLookupInitialized then exit sub
  EnsureConstNames()
  dim i as Integer
  for i = 0 to BUILTIN_CONST_LOOKUP_CAPACITY - 1
    BuiltinConstLookupKeys(i) = ""
    BuiltinConstLookupIds(i) = -1
  next i
  for i = 0 to CONST__COUNT - 1
    dim key as String = ConstNames(i)
    dim slot as Integer = CInt(HashLowerIdent(key) mod BUILTIN_CONST_LOOKUP_CAPACITY)
    do while BuiltinConstLookupKeys(slot) <> ""
      slot = (slot + 1) mod BUILTIN_CONST_LOOKUP_CAPACITY
    loop
    BuiltinConstLookupKeys(slot) = key
    BuiltinConstLookupIds(slot) = i
  next i
  BuiltinConstLookupInitialized = TRUE
end sub

private function TryFindBuiltinConstId(byref n as String) as Integer
  EnsureBuiltinConstLookup()
  dim low as String = lcase(n)
  dim slot as Integer = CInt(HashLowerIdent(low) mod BUILTIN_CONST_LOOKUP_CAPACITY)
  dim probed as Integer
  for probed = 0 to BUILTIN_CONST_LOOKUP_CAPACITY - 1
    if BuiltinConstLookupKeys(slot) = "" then return -1
    if BuiltinConstLookupKeys(slot) = low then return BuiltinConstLookupIds(slot)
    slot = (slot + 1) mod BUILTIN_CONST_LOOKUP_CAPACITY
  next probed
  return -1
end function

private function GetFunctionName(byval id as BuiltinFunctionId) as String
  EnsureFunctionNames()
  return FunctionNames(id)
end function

private function OpName(byval id as OperatorNameId) as String
  EnsureOperatorNames()
  return OperatorNames(id)
end function

private function TryFindBuiltinFunctionId(byref nameText as String) as Integer
  EnsureBuiltinFunctionLookup()
  dim lowName as String = lcase(nameText)
  dim slot as Integer = CInt(HashLowerIdent(lowName) mod BUILTIN_FN_LOOKUP_CAPACITY)
  dim probed as Integer
  for probed = 0 to BUILTIN_FN_LOOKUP_CAPACITY - 1
    if BuiltinFnLookupKeys(slot) = "" then return -1
    if BuiltinFnLookupKeys(slot) = lowName then return BuiltinFnLookupIds(slot)
    slot = (slot + 1) mod BUILTIN_FN_LOOKUP_CAPACITY
  next probed
  return -1
end function

private function IsOpKeyword(byref nameText as String, byval id as OperatorNameId) as Boolean
  return lcase(nameText) = OpName(id)
end function

private const BUILTIN_ARITY_UNBOUNDED as Integer = BUILTIN_META_ARITY_UNBOUNDED

private function GetBuiltinCategory(byval fnId as Integer) as BuiltinCategory
  if fnId < 0 orelse fnId >= FUNC__COUNT then return BC_UNKNOWN
  return K_BUILTIN_META_ROWS(fnId).category
end function

private sub ApplyBuiltinFormatRenderMeta(byval fnId as Integer, byref outV as EvalValue)
  if (fnId = FUNC_HEX) orelse (fnId = FUNC_UHEX) then
    outV.renderBase = 16
  elseif (fnId = FUNC_OCT) orelse (fnId = FUNC_UOCT) then
    outV.renderBase = 8
  else
    outV.renderBase = 2
  end if
  outV.renderUnsigned = (fnId = FUNC_UHEX) orelse (fnId = FUNC_UOCT) orelse (fnId = FUNC_UBIN)
end sub

private function HasBuiltinFlag(byval id as Integer, byval flagMask as UInteger) as Boolean
  if id < 0 orelse id >= FUNC__COUNT then return FALSE
  return (K_BUILTIN_META_ROWS(id).flags and flagMask) <> 0u
end function

private function IsUnaryBuiltin(byref fn as String) as Boolean
  dim id as Integer = TryFindBuiltinFunctionId(lcase(fn))
  return HasBuiltinFlag(id, BUILTIN_FLAG_UNARY)
end function

private function GetBuiltinHintKind(byval id as Integer) as BuiltinHintKind
  if id < 0 orelse id >= FUNC__COUNT then return BHK_NONE
  return CInt(K_BUILTIN_META_ROWS(id).hintKind)
end function

private function GetBuiltinHintDisplayName(byval id as Integer, byref lowFn as String) as String
  select case id
    case FUNC_ASIN
      if lowFn = FB_STR_ARCSIN then return GetFunctionName(FUNC_ASIN)
    case FUNC_ACOS
      if lowFn = FB_STR_ARCCOS then return GetFunctionName(FUNC_ACOS)
    case FUNC_ATAN
      if lowFn = FB_STR_ARCTAN then return GetFunctionName(FUNC_ATAN)
    case FUNC_FRAC
      if lowFn = FB_STR_FRACT then return GetFunctionName(FUNC_FRAC)
    case FUNC_SORT
      if lowFn = FB_STR_SORTED then return GetFunctionName(FUNC_SORT)
    case FUNC_REVERSE
      if lowFn = FB_STR_REVERSED then return GetFunctionName(FUNC_REVERSE)
    case FUNC_FACT
      if lowFn = FB_STR_FACTORIAL then return GetFunctionName(FUNC_FACT)
    case FUNC_PRODUCT
      if lowFn = FB_STR_PROD then return GetFunctionName(FUNC_PRODUCT)
    case FUNC_LEN
      if lowFn = FB_STR_LENGTH then return GetFunctionName(FUNC_LEN)
  end select
  return lowFn
end function

private function TryGetBuiltinSignatureHint(byref fn as String, byref hint as String) as Boolean
  dim lowFn as String = lcase(fn)
  dim id as Integer = TryFindBuiltinFunctionId(lowFn)
  if id < 0 then return FALSE
  dim kind as BuiltinHintKind = GetBuiltinHintKind(id)
  dim displayFn as String = GetBuiltinHintDisplayName(id, lowFn)
  select case kind
    case BHK_EMPTY_PAR: hint = GetFunctionName(id) & FB_STR_PAR
    case BHK_MIN_MAX: hint = GetFunctionName(id) & FB_STR_PAR_MIN_COMMA_MAX
    case BHK_DOTDOTDOT: hint = displayFn & FB_STR_PAR_DOTDOTDOT
    case BHK_VALUE_POWER: hint = GetFunctionName(id) & FB_STR_PAR_VALUE_COMMA_POWER
    case BHK_Y_X: hint = GetFunctionName(id) & FB_STR_PAR_Y_COMMA_X
    case BHK_ANGLE: hint = displayFn & FB_STR_PAR_ANGLE
    case BHK_VALUE: hint = displayFn & FB_STR_PAR_VALUE
    case BHK_VALUE_BASE: hint = GetFunctionName(id) & FB_STR_PAR_VALUE_COMMA_BASE
    case BHK_N: hint = GetFunctionName(id) & FB_STR_PAR_N
    case BHK_VALUE_DIVISOR: hint = GetFunctionName(id) & FB_STR_PAR_VALUE_COMMA_DIVISOR
    case BHK_VALUE_MIN_MAX: hint = GetFunctionName(id) & FB_STR_PAR_VALUE_COMMA_MIN_COMMA_MAX
    case BHK_X_Y: hint = GetFunctionName(id) & FB_STR_PAR_X_COMMA_Y
    case BHK_A_B: hint = lowFn & FB_STR_PAR_A_COMMA_B
    case BHK_N_R: hint = lowFn & FB_STR_PAR_N_COMMA_R
    case BHK_X_N: hint = GetFunctionName(id) & FB_STR_PAR_X_COMMA_N
    case BHK_X: hint = displayFn & FB_STR_PAR_X
    case BHK_START_STOP_STEP: hint = GetFunctionName(id) & FB_STR_PAR_START_COMMA_STOP_COMMA_STEP
    case BHK_ARRAY_FUNC: hint = displayFn & FB_STR_PAR_ARRAY_COMMA_FUNC
    case else: return FALSE
  end select
  return TRUE
end function

private function IsLogicalBinaryOperatorKeyword(byref nameText as String) as Boolean
  return IsOpKeyword(nameText, OP_AND) orelse IsOpKeyword(nameText, OP_OR)
end function

private function IsReservedOperatorKeyword(byref nameText as String) as Boolean
  return IsOpKeyword(nameText, OP_NOT) orelse IsLogicalBinaryOperatorKeyword(nameText)
end function

private function IsBuiltinFunctionName(byref nameText as String) as Boolean
  return (TryFindBuiltinFunctionId(nameText) >= 0)
end function

private function IsReservedUserFunctionName(byref nameText as String) as Boolean
  if IsBuiltinFunctionName(nameText) then return TRUE
  if IsReservedOperatorKeyword(nameText) then return TRUE
  return FALSE
end function

private function IsReservedBuiltinVariableNameForUserFunction(byref nameText as String) as Boolean
  if lcase(nameText) = FB_STR_ANS then return TRUE
  if nameText = FB_STR_FORMAL_VALIDATION_PROBE then return TRUE
  return FALSE
end function

private function IsTrailingFormatterFunctionName(byref nameText as String) as Boolean
  dim lowName as String = lcase(nameText)
  dim id as Integer = TryFindBuiltinFunctionId(lowName)
  return HasBuiltinFlag(id, BUILTIN_FLAG_TRAILING_FORMATTER)
end function

private function TryRewriteTrailingFormatterStmt(byref stmt as String, byref rewritten as String) as Boolean
  dim s as String = trim(stmt)
  if len(s) = 0 then return FALSE
  dim p as ZString ptr = strptr(s)
  dim n as Integer = len(s)
  dim i as Integer = 0
  dim ch as UByte = p[i]
  if not ((ch >= asc("A") andalso ch <= asc("Z")) orelse (ch >= asc("a") andalso ch <= asc("z")) orelse ch = asc("_")) then return FALSE
  while i < n
    ch = p[i]
    if (ch >= asc("A") andalso ch <= asc("Z")) orelse (ch >= asc("a") andalso ch <= asc("z")) orelse (ch >= asc("0") andalso ch <= asc("9")) orelse ch = asc("_") then
      i += 1
    else
      exit while
    end if
  wend
  dim fnName as String = left(s, i)
  if IsTrailingFormatterFunctionName(fnName) = FALSE then return FALSE
  while i < n andalso (p[i] = asc(" ") orelse p[i] = 9)
    i += 1
  wend
  dim rest as String = mid(s, i + 1)
  if len(rest) = 0 then
    rewritten = lcase(fnName) & FB_STR_PAR_ANS
    return TRUE
  end if
  if rest[0] <> CHAR_LPAREN then return FALSE
  dim rp as ZString ptr = strptr(rest)
  dim rLen as Integer = len(rest)
  dim rPos as Integer = 1
  while rPos < rLen
    ch = rp[rPos]
    if ch = asc(" ") orelse ch = 9 then
      rPos += 1
    else
      exit while
    end if
  wend
  if rPos >= rLen orelse rp[rPos] <> CHAR_RPAREN then return FALSE
  rPos += 1
  while rPos < rLen
    ch = rp[rPos]
    if ch = asc(" ") orelse ch = 9 then
      rPos += 1
    else
      return FALSE
    end if
  wend
  rewritten = lcase(fnName) & FB_STR_PAR_ANS
  return TRUE
end function

private const POW10_0 as ULongInt = 1ull
private const POW10_1 as ULongInt = 10ull
private const POW10_2 as ULongInt = 100ull
private const POW10_3 as ULongInt = 1000ull
private const POW10_4 as ULongInt = 10000ull
private const POW10_5 as ULongInt = 100000ull
private const POW10_6 as ULongInt = 1000000ull
private const POW10_7 as ULongInt = 10000000ull
private const POW10_8 as ULongInt = 100000000ull
private const POW10_9 as ULongInt = 1000000000ull
private const POW10_10 as ULongInt = 10000000000ull
private const POW10_11 as ULongInt = 100000000000ull
private const POW10_12 as ULongInt = 1000000000000ull
private const POW10_13 as ULongInt = 10000000000000ull
private const POW10_14 as ULongInt = 100000000000000ull
private const POW10_15 as ULongInt = 1000000000000000ull
private const POW10_16 as ULongInt = 10000000000000000ull
private const POW10_17 as ULongInt = 100000000000000000ull
private const POW10_18 as ULongInt = 1000000000000000000ull
private const POW10_19 as ULongInt = 10000000000000000000ull

private function Pow10U64(byval n as Integer) as ULongInt
  select case n
  case 0: return POW10_0
  case 1: return POW10_1
  case 2: return POW10_2
  case 3: return POW10_3
  case 4: return POW10_4
  case 5: return POW10_5
  case 6: return POW10_6
  case 7: return POW10_7
  case 8: return POW10_8
  case 9: return POW10_9
  case 10: return POW10_10
  case 11: return POW10_11
  case 12: return POW10_12
  case 13: return POW10_13
  case 14: return POW10_14
  case 15: return POW10_15
  case 16: return POW10_16
  case 17: return POW10_17
  case 18: return POW10_18
  case 19: return POW10_19
  case else: return POW10_0
  end select
end function

private function TryAddULongChecked(byval a as ULongInt, byval b as ULongInt, byref outV as ULongInt) as Boolean
  if a > (FB_U64_MAX - b) then return FALSE
  outV = a + b
  return TRUE
end function

private function TryMulULongChecked(byval a as ULongInt, byval b as ULongInt, byref outV as ULongInt) as Boolean
  if b <> 0ull andalso a > (FB_U64_MAX \ b) then return FALSE
  outV = a * b
  return TRUE
end function

private function TryMult10_N_TimesImpl(byval x as ULongInt, byval N as Integer, byref outV as ULongInt) as Boolean
  outV = x
  if N <= 0 then return TRUE

  while N >= 19
    if TryMulULongChecked(outV, Pow10U64(19), outV) = FALSE then return FALSE
    N -= 19
  wend

  if N > 0 then
    dim m as ULongInt = Pow10U64(N)
    if TryMulULongChecked(outV, m, outV) = FALSE then return FALSE
  end if

  return TRUE
end function

private function quickMult10(byval x as ULongInt) as ULongInt
  ' x*10 = x*(8+2) = x*8 + x*2 = (x<<3) + (x<<1)
  return (x shl 3) + (x shl 1)
end function

private function TryMult10OnceChecked(byval x as ULongInt, byref outV as ULongInt) as Boolean
  if x > (FB_U64_MAX \ 10ull) then return FALSE
  outV = quickMult10(x)
  return TRUE
end function

'' sin/cos/tan use MinGW libc for |theta| < 2^53; at 2^53 and above, results are rejected.
private function IsTrigRadiansInRange(byval radians as Double) as Boolean
  if IsNaNValue(radians) orelse IsInfValue(radians) then return FALSE
  return abs(radians) < FB_MAX_EXACT_INT_FROM_DOUBLE
end function

private function IsTrigCartesianInRange(byval ar as Double, byval ai as Double) as Boolean
  return IsTrigRadiansInRange(ar) andalso IsTrigRadiansInRange(ai)
end function

private function IsUnaryTrigFnId(byval fnId as Integer) as Boolean
  return (fnId = FUNC_SIN) orelse (fnId = FUNC_COS) orelse (fnId = FUNC_TAN) orelse _
         (fnId = FUNC_SINH) orelse (fnId = FUNC_COSH) orelse (fnId = FUNC_TANH)
end function

private sub ScalarClearImag(byref sv as ScalarValue)
  sv.imag = 0.0
  sv.imagExactInt64 = 0
  sv.imagExactUInt64 = 0
  sv.flags and= not (SVF_IMAG_EXACT_INT64_VALID or SVF_IMAG_EXACT_UINT64_VALID)
end sub

private sub ScalarSetImagExactInt64Valid(byref sv as ScalarValue, byval v as Boolean)
  if v then
    sv.flags or= SVF_IMAG_EXACT_INT64_VALID
  else
    sv.flags and= not CUInt(SVF_IMAG_EXACT_INT64_VALID)
  end if
end sub

private sub ScalarSetImagExactUInt64Valid(byref sv as ScalarValue, byval v as Boolean)
  if v then
    sv.flags or= SVF_IMAG_EXACT_UINT64_VALID
  else
    sv.flags and= not CUInt(SVF_IMAG_EXACT_UINT64_VALID)
  end if
end sub

private function ScalarNumericReal(byref sv as ScalarValue) as Double
  ScalarRepairExactMetadata(sv)
  if ScalarHasRenderRational(sv) then
    if IsNaNValue(sv.scalar) orelse IsInfValue(sv.scalar) orelse sv.scalar <> 0.0 then return sv.scalar
    if sv.exactUInt64 = 0 then return sv.scalar
    return CDbl(sv.exactInt64) / CDbl(sv.exactUInt64)
  end if
  if ScalarExactInt64Valid(sv) then
    if sv.exactInt64 = FB_I64_MIN then return FB_I64_MIN_D
    return CDbl(sv.exactInt64)
  end if
  if sv.scalarStorageKind = SSK_INT64 then
    if sv.exactInt64 = FB_I64_MIN then return FB_I64_MIN_D
    return CDbl(sv.exactInt64)
  end if
  if ScalarExactUInt64Valid(sv) then return CDbl(sv.exactUInt64)
  if sv.scalarStorageKind = SSK_UINT64 then return CDbl(sv.exactUInt64)
  return sv.scalar
end function

private function ScalarNumericImag(byref sv as ScalarValue) as Double
  ScalarRepairExactMetadata(sv)
  if ScalarHasImagRenderRational(sv) then
    if IsNaNValue(sv.imag) orelse IsInfValue(sv.imag) orelse sv.imag <> 0.0 then return sv.imag
    if sv.imagExactUInt64 = 0 then return sv.imag
    return CDbl(sv.imagExactInt64) / CDbl(sv.imagExactUInt64)
  end if
  if ScalarImagExactInt64Valid(sv) orelse ScalarImagExactUInt64Valid(sv) then
    if ScalarImagExactMetadataMatchesFloat(sv) = FALSE then return sv.imag
  end if
  if ScalarImagExactInt64Valid(sv) then
    return CDbl(sv.imagExactInt64)
  end if
  if ScalarImagExactUInt64Valid(sv) then
    return CDbl(sv.imagExactUInt64)
  end if
  return sv.imag
end function

'' Exact int64 for arithmetic/metadata (not render-rational numerator storage).
function ScalarExactInt64Valid(byref sv as ScalarValue) as Boolean
  if ScalarHasRenderRational(sv) then return FALSE
  return ScalarExactInt64MetadataValid(sv)
end function

sub ScalarSetExactInt64Valid(byref sv as ScalarValue, byval v as Boolean)
  if v then
    sv.flags or= SVF_EXACT_INT64_VALID
  else
    sv.flags and= not CUInt(SVF_EXACT_INT64_VALID)
  end if
end sub

function ScalarExactUInt64Valid(byref sv as ScalarValue) as Boolean
  if ScalarHasRenderRational(sv) then return FALSE
  return ScalarExactUInt64MetadataValid(sv)
end function

sub ScalarSetExactUInt64Valid(byref sv as ScalarValue, byval v as Boolean)
  if v then
    sv.flags or= SVF_EXACT_UINT64_VALID
  else
    sv.flags and= not CUInt(SVF_EXACT_UINT64_VALID)
  end if
end sub

private sub ScalarSyncExactInt64WithUIntMirror(byref sv as ScalarValue, byval n as LongInt)
  ScalarSetExactInt64Valid(sv, TRUE)
  sv.exactInt64 = n
  if n >= 0 then
    ScalarSetExactUInt64Valid(sv, TRUE)
    sv.exactUInt64 = CULngInt(n)
  else
    ScalarSetExactUInt64Valid(sv, FALSE)
    sv.exactUInt64 = 0
  end if
end sub

private sub ScalarSyncExactUInt64WithIntMirror(byref sv as ScalarValue, byval n as ULongInt)
  ScalarSetExactUInt64Valid(sv, TRUE)
  sv.exactUInt64 = n
  if n <= FB_I64_MAX_U then
    ScalarSetExactInt64Valid(sv, TRUE)
    sv.exactInt64 = CLngInt(n)
  else
    ScalarSetExactInt64Valid(sv, FALSE)
    sv.exactInt64 = 0
  end if
end sub

private sub ScalarSyncImagExactInt64WithUIntMirror(byref sv as ScalarValue, byval n as LongInt)
  ScalarSetImagExactInt64Valid(sv, TRUE)
  sv.imagExactInt64 = n
  if n >= 0 then
    ScalarSetImagExactUInt64Valid(sv, TRUE)
    sv.imagExactUInt64 = CULngInt(n)
  else
    ScalarSetImagExactUInt64Valid(sv, FALSE)
    sv.imagExactUInt64 = 0
  end if
end sub

'' Keep SVF_* flags aligned with scalarStorageKind and exact* fields (stale flags break exact complex ops).
sub ScalarRepairExactMetadata(byref sv as ScalarValue)
  select case sv.scalarStorageKind
  case SSK_INT64
    ScalarSetExactInt64Valid(sv, TRUE)
    if sv.exactInt64 >= 0 then
      ScalarSetExactUInt64Valid(sv, TRUE)
      sv.exactUInt64 = CULngInt(sv.exactInt64)
    elseif sv.exactUInt64 <> 0 then
      ScalarSetExactUInt64Valid(sv, TRUE)
    else
      ScalarSetExactUInt64Valid(sv, FALSE)
      sv.exactUInt64 = 0
    end if
  case SSK_UINT64
    ScalarSetExactUInt64Valid(sv, TRUE)
    if sv.exactUInt64 <= FB_I64_MAX_U then
      ScalarSetExactInt64Valid(sv, TRUE)
      sv.exactInt64 = CLngInt(sv.exactUInt64)
    else
      ScalarSetExactInt64Valid(sv, FALSE)
      sv.exactInt64 = 0
    end if
  case else
    '' Rationals keep num/den in exactInt64/exactUInt64 with SVF_RENDER_RATIONAL (not SSK_INT64).
    if (sv.flags and SVF_RENDER_RATIONAL) <> 0 then
      ScalarSetExactInt64Valid(sv, TRUE)
      ScalarSetExactUInt64Valid(sv, TRUE)
    else
      ScalarSetExactInt64Valid(sv, FALSE)
      ScalarSetExactUInt64Valid(sv, FALSE)
    end if
  end select
  '' INT_POWER stores base in imagExactInt64 and exponent in imagExactUInt64; do not remap imag fields.
  if (sv.flags and SVF_RENDER_INT_POWER) = 0 then
    dim tIm as LongInt
    if ScalarImagExactInt64Valid(sv) = FALSE andalso sv.imagExactInt64 <> 0 then
      if TryGetExactInt64FromDouble(sv.imag, tIm) andalso tIm = sv.imagExactInt64 then
        ScalarSetImagExactInt64Valid(sv, TRUE)
        if sv.imagExactInt64 >= 0 then
          ScalarSetImagExactUInt64Valid(sv, TRUE)
          sv.imagExactUInt64 = CULngInt(sv.imagExactInt64)
        end if
      end if
    elseif ScalarImagExactUInt64Valid(sv) = FALSE andalso sv.imagExactUInt64 <> 0 then
      if TryGetExactInt64FromDouble(sv.imag, tIm) andalso CULngInt(tIm) = sv.imagExactUInt64 then
        ScalarSetImagExactUInt64Valid(sv, TRUE)
        if sv.imagExactUInt64 <= FB_I64_MAX_U then
          ScalarSetImagExactInt64Valid(sv, TRUE)
          sv.imagExactInt64 = CLngInt(sv.imagExactUInt64)
        end if
      end if
    end if
  end if
end sub

private sub ScalarNormalizeIfPureReal(byref sv as ScalarValue)
  if ScalarHasNonzeroImaginaryPart(sv) = FALSE then
    ScalarClearImag(sv)
  end if
end sub

private sub ScalarLoadCartesian(byref sv as ScalarValue, byref ar as Double, byref ai as Double)
  ar = ScalarNumericReal(sv)
  ai = ScalarNumericImag(sv)
end sub

private sub ValueClearLambdaPayload(byref v as EvalValue)
  erase v.lambdaParams
  v.lambdaBody = ""
  v.sortbyKeyErrorCol = 0
  v.sortbyKeyBodyErrorCol = 0
end sub

private sub ValueSetScalar(byref v as EvalValue, byval n as Double)
  ValueClearLambdaPayload(v)
  v.funcRefName = ""
  v.kind = VK_SCALAR
  v.scalarValue.scalarStorageKind = SSK_FLOATINGPOINT
  v.scalarValue.flags and= not CUInt(SVF_RENDER_RATIONAL or SVF_IMAG_RENDER_RATIONAL or SVF_RENDER_INT_POWER)
  v.scalarValue.scalar = n
  ScalarClearImag(v.scalarValue)
  v.expandArgs = FALSE
  v.renderBase = 0
  v.renderUnsigned = FALSE
  ScalarSetExactInt64Valid(v.scalarValue, FALSE)
  v.scalarValue.exactInt64 = 0
  ScalarSetExactUInt64Valid(v.scalarValue, FALSE)
  v.scalarValue.exactUInt64 = 0
  erase v.arr
end sub

private function ScalarValueFromEvalScalar(byref v as EvalValue) as ScalarValue
  dim outV as ScalarValue
  outV.scalarStorageKind = v.scalarStorageKind
  outV.scalar = v.scalar
  outV.exactInt64 = v.exactInt64
  outV.exactUInt64 = v.exactUInt64
  outV.imag = v.scalarValue.imag
  outV.imagExactInt64 = v.scalarValue.imagExactInt64
  outV.imagExactUInt64 = v.scalarValue.imagExactUInt64
  outV.flags = v.scalarValue.flags
  return outV
end function

private sub EvalScalarFromScalarValue(byref s as ScalarValue, byref outV as EvalValue)
  ValueSetScalar(outV, s.scalar)
  outV.scalarStorageKind = s.scalarStorageKind
  outV.scalarValue.exactInt64 = s.exactInt64
  outV.scalarValue.exactUInt64 = s.exactUInt64
  outV.scalarValue.flags = (outV.scalarValue.flags and not (SVF_EXACT_INT64_VALID or SVF_EXACT_UINT64_VALID)) or (s.flags and (SVF_EXACT_INT64_VALID or SVF_EXACT_UINT64_VALID))
  outV.scalarValue.imag = s.imag
  outV.scalarValue.imagExactInt64 = s.imagExactInt64
  outV.scalarValue.imagExactUInt64 = s.imagExactUInt64
  dim extraFlags as UInteger = s.flags and (SVF_IMAG_EXACT_INT64_VALID or SVF_IMAG_EXACT_UINT64_VALID or SVF_DEC_SCI_POW63_HIGH or SVF_RENDER_RATIONAL or SVF_IMAG_RENDER_RATIONAL or SVF_RENDER_INT_POWER)
  outV.scalarValue.flags = (outV.scalarValue.flags and not (SVF_IMAG_EXACT_INT64_VALID or SVF_IMAG_EXACT_UINT64_VALID or SVF_DEC_SCI_POW63_HIGH or SVF_RENDER_RATIONAL or SVF_IMAG_RENDER_RATIONAL or SVF_RENDER_INT_POWER)) or extraFlags
  ScalarRepairExactMetadata(outV.scalarValue)
end sub

private sub ValueInitArrayLike(byref v as EvalValue, byval lb as Integer, byval ub as Integer)
  ValueSetScalar(v, 0)
  v.kind = VK_ARRAY
  if ub >= lb then
    redim v.arr(lb to ub)
  end if
end sub

private sub ValueSetArrayElemFromScalar(byref arrV as EvalValue, byval idx as Integer, byref scalarV as EvalValue)
  arrV.arr(idx) = ScalarValueFromEvalScalar(scalarV)
end sub

private sub ValueGetArrayElemAsScalar(byref arrV as EvalValue, byval idx as Integer, byref outV as EvalValue)
  EvalScalarFromScalarValue(arrV.arr(idx), outV)
end sub

private function ValueArrayLen(byref v as EvalValue) as Integer
  if v.kind <> VK_ARRAY then return 0
  if ubound(v.arr) < lbound(v.arr) then return 0
  return ubound(v.arr) - lbound(v.arr) + 1
end function

private sub ValueSetInt64(byref v as EvalValue, byval n as LongInt)
  if n = FB_I64_MIN then
    ValueSetScalar(v, FB_I64_MIN_D)
  else
    ValueSetScalar(v, CDbl(n))
  end if
  v.scalarValue.scalarStorageKind = SSK_INT64
  ScalarSyncExactInt64WithUIntMirror(v.scalarValue, n)
  ScalarRepairExactMetadata(v.scalarValue)
end sub

private sub ValueSetUInt64(byref v as EvalValue, byval n as ULongInt)
  ValueSetScalar(v, CDbl(n))
  v.scalarValue.scalarStorageKind = SSK_UINT64
  ScalarSyncExactUInt64WithIntMirror(v.scalarValue, n)
  ScalarRepairExactMetadata(v.scalarValue)
end sub

function TryGetExactInt64FromDouble(byval n as Double, byref outV as LongInt) as Boolean
  if IsNonFiniteValue(n) then return FALSE
  if n < -FB_MAX_EXACT_INT_FROM_DOUBLE orelse n > FB_MAX_EXACT_INT_FROM_DOUBLE then return FALSE
  if n < FB_I64_MIN_D orelse n > FB_I64_MAX_D then return FALSE
  dim t as LongInt = CLngInt(n)
  if n <> CDbl(t) then return FALSE
  outV = t
  return TRUE
end function

'' True when imag exact metadata matches the stored float imag (guards stale imagExactInt64).
private function ScalarImagExactMetadataMatchesFloat(byref sv as ScalarValue) as Boolean
  dim t as LongInt
  if TryGetExactInt64FromDouble(sv.imag, t) = FALSE then return FALSE
  if ScalarImagExactInt64MetadataValid(sv) andalso t = sv.imagExactInt64 then return TRUE
  if ScalarImagExactUInt64MetadataValid(sv) andalso CULngInt(t) = sv.imagExactUInt64 then return TRUE
  return FALSE
end function

private sub ValueSetScalarComplexFromDoubles(byref v as EvalValue, byval re as Double, byval im as Double)
  if IsNaNValue(re) andalso IsNaNValue(im) then
    ValueSetScalar(v, MakeNaN())
    exit sub
  end if
  v.kind = VK_SCALAR
  v.scalarValue.scalarStorageKind = SSK_FLOATINGPOINT
  v.scalarValue.flags and= not CUInt(SVF_RENDER_RATIONAL or SVF_IMAG_RENDER_RATIONAL or SVF_RENDER_INT_POWER)
  v.scalarValue.scalar = re
  ScalarSetExactInt64Valid(v.scalarValue, FALSE)
  v.scalarValue.exactInt64 = 0
  ScalarSetExactUInt64Valid(v.scalarValue, FALSE)
  v.scalarValue.exactUInt64 = 0
  v.scalarValue.imag = im
  ScalarSetImagExactInt64Valid(v.scalarValue, FALSE)
  ScalarSetImagExactUInt64Valid(v.scalarValue, FALSE)
  v.scalarValue.imagExactInt64 = 0
  v.scalarValue.imagExactUInt64 = 0
  v.expandArgs = FALSE
  v.renderBase = 0
  v.renderUnsigned = FALSE
  erase v.arr
  dim tri as LongInt, tii as LongInt
  if TryGetExactInt64FromDouble(re, tri) then
    v.scalarValue.scalarStorageKind = SSK_INT64
    ScalarSyncExactInt64WithUIntMirror(v.scalarValue, tri)
  end if
  if TryGetExactInt64FromDouble(im, tii) then
    ScalarSyncImagExactInt64WithUIntMirror(v.scalarValue, tii)
  end if
  ScalarNormalizeIfPureReal(v.scalarValue)
end sub

private sub ValueSetImagUnit(byref v as EvalValue)
  ValueSetScalarComplexFromDoubles(v, 0.0, 1.0)
  v.scalarValue.scalarStorageKind = SSK_INT64
  ScalarSetExactInt64Valid(v.scalarValue, TRUE)
  v.scalarValue.exactInt64 = 0
  ScalarSetExactUInt64Valid(v.scalarValue, TRUE)
  v.scalarValue.exactUInt64 = 0
  ScalarSetImagExactInt64Valid(v.scalarValue, TRUE)
  v.scalarValue.imagExactInt64 = 1
  ScalarSetImagExactUInt64Valid(v.scalarValue, TRUE)
  v.scalarValue.imagExactUInt64 = 1
  v.scalarValue.scalar = 0.0
  v.scalarValue.imag = 1.0
end sub

private function TryGetExactInt64(byref v as EvalValue, byref outV as LongInt) as Boolean
  if v.kind <> VK_SCALAR then return FALSE
  if v.exactInt64Valid then
    outV = v.exactInt64
    return TRUE
  end if
  if v.exactUInt64Valid then
    outV = CLngInt(v.exactUInt64)
    return TRUE
  end if
  return TryGetExactInt64FromDouble(v.scalar, outV)
end function

private function TryGetExactInt64Scalar(byref s as ScalarValue, byref outV as LongInt) as Boolean
  ScalarRepairExactMetadata(s)
  if ScalarExactInt64Valid(s) then
    outV = s.exactInt64
    return TRUE
  end if
  if s.scalarStorageKind = SSK_INT64 then
    outV = s.exactInt64
    return TRUE
  end if
  if ScalarExactUInt64Valid(s) then
    outV = CLngInt(s.exactUInt64)
    return TRUE
  end if
  if s.scalarStorageKind = SSK_UINT64 andalso s.exactUInt64 <= FB_I64_MAX_U then
    outV = CLngInt(s.exactUInt64)
    return TRUE
  end if
  return TryGetExactInt64FromDouble(s.scalar, outV)
end function

private function TryGetExactNonNegativeUInt64Scalar(byref s as ScalarValue, byref outV as ULongInt) as Boolean
  ScalarRepairExactMetadata(s)
  if ScalarExactUInt64Valid(s) orelse s.scalarStorageKind = SSK_UINT64 then
    outV = s.exactUInt64
    return TRUE
  end if
  if ScalarExactInt64Valid(s) andalso s.exactInt64 >= 0 then
    outV = CULngInt(s.exactInt64)
    return TRUE
  end if
  if s.scalarStorageKind = SSK_INT64 andalso s.exactInt64 >= 0 then
    outV = CULngInt(s.exactInt64)
    return TRUE
  end if
  return FALSE
end function

'' Exact signed int64, including from uint64 metadata only when value fits LLONG_MAX (no wrap).
private function TryGetExactSignedInt64NoUIntWrapScalar(byref s as ScalarValue, byref outV as LongInt) as Boolean
  if ScalarExactInt64Valid(s) then
    outV = s.exactInt64
    return TRUE
  end if
  if ScalarExactUInt64Valid(s) andalso s.exactUInt64 <= FB_I64_MAX_U then
    outV = CLngInt(s.exactUInt64)
    return TRUE
  end if
  return TryGetExactInt64FromDouble(s.scalar, outV)
end function

'' Metadata-only signed int64 (no float restore); for sqr/hypot exact integer paths.
private function TryGetExactSignedInt64NoUIntWrapScalarStrict(byref s as ScalarValue, byref outV as LongInt) as Boolean
  ScalarRepairExactMetadata(s)
  if ScalarExactInt64Valid(s) then
    outV = s.exactInt64
    return TRUE
  end if
  if ScalarExactUInt64Valid(s) andalso s.exactUInt64 <= FB_I64_MAX_U then
    outV = CLngInt(s.exactUInt64)
    return TRUE
  end if
  if s.scalarStorageKind = SSK_INT64 then
    outV = s.exactInt64
    return TRUE
  end if
  if s.scalarStorageKind = SSK_UINT64 andalso s.exactUInt64 <= FB_I64_MAX_U then
    outV = CLngInt(s.exactUInt64)
    return TRUE
  end if
  return FALSE
end function

private function UniqueHashKeyFromDouble(byval v as Double) as ULongInt
  if v = 0 then return 0 ' Canonicalize +0/-0.
  dim bits as DoubleBits
  bits.d = v
  return bits.u
end function

private function NextPow2AtLeast(byval n as Integer) as Integer
  dim cap as Integer = 1
  while cap < n
    if cap > &h3FFFFFFF then return n
    cap = cap shl 1
  wend
  return cap
end function

private sub SwapDouble(byref a as Double, byref b as Double)
  dim t as Double = a
  a = b
  b = t
end sub

private function TryAddInt64(byval a as LongInt, byval b as LongInt, byref outV as LongInt) as Boolean
  '' Post-hoc signed overflow test (avoids FB_I64_MIN/MAX +/- b on x86_64 -gen gcc).
  outV = a + b
  if b > 0 andalso outV < a then return FALSE
  if b < 0 andalso outV > a then return FALSE
  return TRUE
end function

private function TrySubInt64(byval a as LongInt, byval b as LongInt, byref outV as LongInt) as Boolean
  outV = a - b
  if b > 0 andalso outV > a then return FALSE
  if b < 0 andalso outV < a then return FALSE
  return TRUE
end function

private function TryMulInt64(byval a as LongInt, byval b as LongInt, byref outV as LongInt) as Boolean
  if a = 0 orelse b = 0 then outV = 0: return TRUE
  if a = -1 then
    if b = FB_I64_MIN then return FALSE
    outV = -b
    return TRUE
  end if
  if b = -1 then
    if a = FB_I64_MIN then return FALSE
    outV = -a
    return TRUE
  end if
  '' Post-hoc signed overflow test (avoids FB_I64_MAX \ b style pre-checks under -gen gcc -O2).
  outV = a * b
  if a <> 0 andalso (outV \ a) <> b then return FALSE
  return TRUE
end function

private function ScalarHasExactIntegerPayload(byref sv as ScalarValue) as Boolean
  if ScalarIsTime(sv) then return FALSE
  return ScalarExactInt64Valid(sv) orelse ScalarExactUInt64Valid(sv) orelse _
    sv.scalarStorageKind = SSK_INT64 orelse sv.scalarStorageKind = SSK_UINT64
end function

private function TryMulExactInt64Square(byval i as LongInt, byref outV as LongInt) as Boolean
  dim u as ULongInt
  if i >= 0 then
    u = CULngInt(i)
  elseif i = FB_I64_MIN then
    return FALSE
  else
    u = CULngInt(-i)
  end if
  dim sqU as ULongInt
  if TryMulULongChecked(u, u, sqU) = FALSE orelse sqU > FB_I64_MAX_U then return FALSE
  outV = CLngInt(sqU)
  return TRUE
end function

'' Verify (rootR + rootI*i)^2 = expR + expI*i using checked int64 arithmetic.
private function TryVerifyComplexCartesianSquareExact(byval rootR as LongInt, byval rootI as LongInt, byval expR as LongInt, byval expI as LongInt) as Boolean
  dim rr as LongInt
  dim ii as LongInt
  dim ri as LongInt
  dim outRe as LongInt
  dim outIm as LongInt
  if TryMulExactInt64Square(rootR, rr) = FALSE then return FALSE
  if TryMulExactInt64Square(rootI, ii) = FALSE then return FALSE
  if TrySubInt64(rr, ii, outRe) = FALSE then return FALSE
  if TryMulInt64(rootR, rootI, ri) = FALSE then return FALSE
  if TryAddInt64(ri, ri, outIm) = FALSE then return FALSE
  if outRe <> expR orelse outIm <> expI then return FALSE
  return TRUE
end function

'' sqrt: library root; exact-int output only for exact-int input when round(r)^2 equals input (checked mul).
private sub ApplySqrtScalarValue(byref sv as ScalarValue, byref outV as EvalValue)
  ScalarRepairExactMetadata(sv)
  dim xIn as Double
  dim ai as Double
  ScalarLoadCartesian(sv, xIn, ai)
  dim r as Double = sqr(xIn)
  if ScalarHasExactIntegerPayload(sv) = FALSE then
    ValueSetScalar(outV, r)
    exit sub
  end if
  if IsNonFiniteValue(r) then
    ValueSetScalar(outV, r)
    exit sub
  end if
  dim inpU as ULongInt
  if TryGetExactNonNegativeUInt64Scalar(sv, inpU) = FALSE then
    ValueSetScalar(outV, r)
    exit sub
  end if
  dim n as ULongInt = CULngInt(round(r))
  dim sq as ULongInt
  if TryMulULongChecked(n, n, sq) andalso sq = inpU then
    if n <= FB_I64_MAX_U then
      ValueSetInt64(outV, CLngInt(n))
    else
      ValueSetUInt64(outV, n)
    end if
  else
    ValueSetScalar(outV, r)
  end if
end sub

private function TryApplySqrExactScalar(byref sv as ScalarValue, byref outV as EvalValue) as Boolean
  ScalarRepairExactMetadata(sv)
  if ScalarHasExactIntegerPayload(sv) = FALSE then return FALSE
  dim i as LongInt
  if TryGetExactSignedInt64NoUIntWrapScalarStrict(sv, i) then
    dim sq as LongInt
    if TryMulExactInt64Square(i, sq) then ValueSetInt64(outV, sq): return TRUE
  else
    dim u as ULongInt
    if TryGetExactNonNegativeUInt64Scalar(sv, u) then
      dim sqU as ULongInt
      if TryMulULongChecked(u, u, sqU) then
        if sqU <= FB_I64_MAX_U then
          ValueSetInt64(outV, CLngInt(sqU))
        else
          ValueSetUInt64(outV, sqU)
        end if
        return TRUE
      end if
    end if
  end if
  return FALSE
end function

private function TryApplyHypotExactScalars(byref leftS as ScalarValue, byref rightS as ScalarValue, byref outV as EvalValue) as Boolean
  ScalarRepairExactMetadata(leftS)
  ScalarRepairExactMetadata(rightS)
  if ScalarHasExactIntegerPayload(leftS) = FALSE orelse ScalarHasExactIntegerPayload(rightS) = FALSE then return FALSE
  dim la as LongInt, lb as LongInt
  if TryGetExactSignedInt64NoUIntWrapScalarStrict(leftS, la) andalso TryGetExactSignedInt64NoUIntWrapScalarStrict(rightS, lb) then
    dim aa as LongInt, bb as LongInt, sumSq as LongInt
    if TryMulExactInt64Square(la, aa) andalso TryMulExactInt64Square(lb, bb) andalso TryAddInt64(aa, bb, sumSq) then
      ValueSetScalar(outV, sqr(CDbl(sumSq)))
      return TRUE
    end if
    return FALSE
  end if
  dim ua as ULongInt, ub as ULongInt
  if TryGetExactNonNegativeUInt64Scalar(leftS, ua) andalso TryGetExactNonNegativeUInt64Scalar(rightS, ub) then
    dim aaU as ULongInt, bbU as ULongInt, sumSqU as ULongInt
    if TryMulULongChecked(ua, ua, aaU) andalso TryMulULongChecked(ub, ub, bbU) andalso TryAddULongChecked(aaU, bbU, sumSqU) then
      ValueSetScalar(outV, sqr(CDbl(sumSqU)))
      return TRUE
    end if
  end if
  return FALSE
end function

'' Exact-int pow/**: float guess, then checked integer power verifies root or integer exponent.
private function ScalarExactIntFitsPowExactPolicy(byref s as ScalarValue, byref outI as LongInt) as Boolean
  if ScalarIsTime(s) then return FALSE
  if TryGetExactSignedInt64NoUIntWrapScalarStrict(s, outI) = FALSE then return FALSE
  if outI = FB_I64_MIN then return FALSE
  dim mag as ULongInt
  if outI >= 0 then
    mag = CULngInt(outI)
  else
    mag = CULngInt(-outI)
  end if
  return mag < CULngInt(FB_MAX_EXACT_INT_FROM_DOUBLE)
end function

private function TryPowInt64(byval baseV as LongInt, byval expV as LongInt, byref outV as LongInt) as Boolean
  if expV < 0 then return FALSE
  dim r as LongInt = 1
  dim b as LongInt = baseV
  dim e as LongInt = expV
  while e > 0
    if (e and 1) <> 0 then
      if TryMulInt64(r, b, r) = FALSE then return FALSE
    end if
    e = e shr 1
    if e > 0 then
      if TryMulInt64(b, b, b) = FALSE then return FALSE
    end if
  wend
  outV = r
  return TRUE
end function

function TryPowULong(byval baseV as ULongInt, byval expV as ULongInt, byref outV as ULongInt) as Boolean
  dim r as ULongInt = 1
  dim b as ULongInt = baseV
  dim e as ULongInt = expV
  while e > 0ull
    if (e and 1ull) <> 0ull then
      if TryMulULongChecked(r, b, r) = FALSE then return FALSE
    end if
    e = e shr 1
    if e > 0ull then
      if TryMulULongChecked(b, b, b) = FALSE then return FALSE
    end if
  wend
  outV = r
  return TRUE
end function

private function TryPowVerifyRootExact(byval valueInt as LongInt, byval rootCand as LongInt, byval rootDeg as LongInt) as Boolean
  if rootDeg < 2 orelse rootDeg > 63 then return FALSE
  if valueInt < 0 andalso (rootDeg and 1) = 0 then return FALSE
  if rootCand >= 0 andalso valueInt >= 0 then
    dim reconU as ULongInt
    if TryPowULong(CULngInt(rootCand), CULngInt(rootDeg), reconU) = FALSE then return FALSE
    return CLngInt(reconU) = valueInt
  end if
  dim reconI as LongInt
  if TryPowInt64(rootCand, rootDeg, reconI) = FALSE then return FALSE
  return reconI = valueInt
end function

private function FractionalPowerIsOddUnitRoot(byval p as Double, byref outN as LongInt) as Boolean
  if p <= 0.0 orelse p >= 1.0 then return FALSE
  dim inv as Double = 1.0 / p
  if inv < 2.0 orelse inv > 63.0 then return FALSE
  outN = CLngInt(round(inv))
  if outN < 2 orelse outN > 63 then return FALSE
  if abs(inv - CDbl(outN)) > 1e-6 then return FALSE
  return (outN and 1) <> 0
end function

'' Fractional exponent 1/n (odd n) or 1/2 (principal sqrt / half-power).
private function FractionalPowerResolveRootDegree(byval p as Double, byref outN as LongInt) as Boolean
  if FractionalPowerIsOddUnitRoot(p, outN) then return TRUE
  if abs(p - 0.5) < 1e-12 then
    outN = 2
    return TRUE
  end if
  return FALSE
end function

'' Float pow(negative, non-integer) is NaN on some runtimes; odd unit roots use |base|^power with sign.
private function TryPowFloatGuess(byval valueInt as LongInt, byval baseScalar as Double, byval p as Double, byref outR as Double) as Boolean
  if valueInt >= 0 orelse p <= 0.0 orelse p >= 1.0 then
    outR = baseScalar ^ p
    return IsNonFiniteValue(outR) = FALSE
  end if
  dim nRoot as LongInt
  if FractionalPowerIsOddUnitRoot(p, nRoot) = FALSE then
    outR = baseScalar ^ p
    return IsNonFiniteValue(outR) = FALSE
  end if
  dim magD as Double
  if valueInt = FB_I64_MIN then
    magD = CDbl(FB_I64_MIN_MAG_U)
  else
    magD = CDbl(-valueInt)
  end if
  dim rootMag as Double = magD ^ p
  if IsNonFiniteValue(rootMag) then return FALSE
  outR = -rootMag
  return TRUE
end function

private function TryPowVerifyIntExponentExact(byval valueInt as LongInt, byval powResult as LongInt, byval expDeg as LongInt) as Boolean
  if expDeg < 0 orelse expDeg > 63 then return FALSE
  dim recon as LongInt
  if TryPowInt64(valueInt, expDeg, recon) = FALSE then return FALSE
  return recon = powResult
end function

'' Negative real base, fractional power 1/n (odd n): use real IEEE pow, never principal complex.
private function TryApplyRealScalarPowNegFractional(byref leftS as ScalarValue, byval p as Double, byref outV as EvalValue) as Boolean
  dim nRoot as LongInt
  if FractionalPowerIsOddUnitRoot(p, nRoot) = FALSE then return FALSE
  dim ar as Double, ai as Double
  ScalarLoadCartesian(leftS, ar, ai)
  if ai <> 0.0 orelse ar >= 0.0 then return FALSE
  dim valueInt as LongInt
  if TryGetExactSignedInt64NoUIntWrapScalarStrict(leftS, valueInt) then
    if valueInt <> FB_I64_MIN then
      dim realR as Double
      if TryPowFloatGuess(valueInt, leftS.scalar, p, realR) then
        ValueSetScalar(outV, realR)
        return TRUE
      end if
    end if
  end if
  dim rootMag as Double = (-ar) ^ p
  if IsNonFiniteValue(rootMag) then return FALSE
  ValueSetScalar(outV, -rootMag)
  return TRUE
end function

private function TryApplyPowExactScalarsByKind(byval kind as ScalarExactKind, byval valueSigned as LongInt, byval valueUnsigned as ULongInt, byref leftS as ScalarValue, byref rightS as ScalarValue, byref outV as EvalValue) as Boolean
  if kind = SEK_SIGNED then
    if valueSigned = 1 then ValueSetInt64(outV, 1): return TRUE
  elseif valueUnsigned = 1ull then
    ValueSetInt64(outV, 1)
    return TRUE
  end if
  dim p as Double = rightS.scalar
  if IsNonFiniteValue(p) then return FALSE
  if p = 0.0 then ValueSetInt64(outV, 1): return TRUE
  dim r as Double
  if kind = SEK_SIGNED then
    if TryPowFloatGuess(valueSigned, leftS.scalar, p, r) = FALSE then return FALSE
  else
    r = leftS.scalar ^ p
    if IsNonFiniteValue(r) then return FALSE
  end if
  if p > 0.0 andalso p < 1.0 then
    dim nRoot as LongInt
    if FractionalPowerIsOddUnitRoot(p, nRoot) then
      if kind = SEK_SIGNED then
        dim rootCand as LongInt = CLngInt(round(r))
        if TryPowVerifyRootExact(valueSigned, rootCand, nRoot) then
          ValueSetInt64(outV, rootCand)
          return TRUE
        end if
      else
        dim n as ULongInt = CULngInt(round(r))
        dim sq as ULongInt
        if TryPowULong(n, CULngInt(nRoot), sq) andalso sq = valueUnsigned then
          if n <= FB_I64_MAX_U then
            ValueSetInt64(outV, CLngInt(n))
          else
            ValueSetUInt64(outV, n)
          end if
          return TRUE
        end if
      end if
    end if
    return FALSE
  end if
  if p >= 1.0 then
    dim nExp as LongInt = CLngInt(round(p))
    if nExp >= 0 andalso nExp <= 63 then
      if nExp = 0 then ValueSetInt64(outV, 1): return TRUE
      if kind = SEK_SIGNED then
        dim powResult as LongInt = CLngInt(round(r))
        if TryPowVerifyIntExponentExact(valueSigned, powResult, nExp) then
          ValueSetInt64(outV, powResult)
          return TRUE
        end if
      else
        dim powResultU as ULongInt = CULngInt(round(r))
        dim recon as ULongInt
        if TryPowULong(valueUnsigned, CULngInt(nExp), recon) andalso recon = powResultU then
          if powResultU <= FB_I64_MAX_U then
            ValueSetInt64(outV, CLngInt(powResultU))
          else
            ValueSetUInt64(outV, powResultU)
          end if
          return TRUE
        end if
      end if
    end if
  end if
  return FALSE
end function

private function TryApplyPowExactScalars(byref leftS as ScalarValue, byref rightS as ScalarValue, byref outV as EvalValue) as Boolean
  if Parser_SupportComplexNumbers andalso (ScalarHasNonzeroImaginaryPart(leftS) orelse ScalarHasNonzeroImaginaryPart(rightS)) then
    return FALSE
  end if
  dim valueInt as LongInt
  if ScalarExactIntFitsPowExactPolicy(leftS, valueInt) then
    return TryApplyPowExactScalarsByKind(SEK_SIGNED, valueInt, 0ull, leftS, rightS, outV)
  end if
  dim inpU as ULongInt
  if TryGetExactNonNegativeUInt64Scalar(leftS, inpU) then
    return TryApplyPowExactScalarsByKind(SEK_UNSIGNED, 0, inpU, leftS, rightS, outV)
  end if
  return FALSE
end function

'' Shared early paths for `**` and `pow`: exact-int verify, then real odd unit root (not principal complex).
private function TryApplyScalarPowSpecialPaths(byref leftS as ScalarValue, byref rightS as ScalarValue, byref outV as EvalValue) as Boolean
  if TryApplyPowExactScalars(leftS, rightS, outV) then return TRUE
  return TryApplyRealScalarPowNegFractional(leftS, rightS.scalar, outV)
end function

private function FormatSignedMagnitudeBase(byval iv as LongInt, byval baseN as Integer, byval asUnsigned as Boolean) as String
  dim prefix as String
  select case baseN
    case 16: prefix = FB_STR_PREFIX_HEX
    case 8: prefix = FB_STR_PREFIX_OCT
    case else: prefix = FB_STR_PREFIX_BIN
  end select

  if asUnsigned then
    select case baseN
      case 16: return prefix & Hex(CULngInt(iv))
      case 8: return prefix & Oct(CULngInt(iv))
      case else: return prefix & Bin(CULngInt(iv))
    end select
  end if

  if iv = FB_I64_MIN then
    select case baseN
      case 16: return "-" & prefix & Hex(FB_I64_MIN_MAG_U)
      case 8: return "-" & prefix & Oct(FB_I64_MIN_MAG_U)
      case else: return "-" & prefix & Bin(FB_I64_MIN_MAG_U)
    end select
  end if
  if iv < 0 then
    select case baseN
      case 16: return "-" & prefix & Hex(CULngInt(-iv))
      case 8: return "-" & prefix & Oct(CULngInt(-iv))
      case else: return "-" & prefix & Bin(CULngInt(-iv))
    end select
  end if

  select case baseN
    case 16: return prefix & Hex(CULngInt(iv))
    case 8: return prefix & Oct(CULngInt(iv))
    case else: return prefix & Bin(CULngInt(iv))
  end select
end function

private function FormatHexScalar(byval n as Double, byref outText as String, byval asUnsigned as Boolean = FALSE) as Boolean
  dim iv as LongInt
  if TryGetExactInt64FromDouble(n, iv) = FALSE then return FALSE
  outText = FormatSignedMagnitudeBase(iv, 16, asUnsigned)
  return TRUE
end function

private function FormatHexUInt64(byval u as ULongInt) as String
  return FB_STR_PREFIX_HEX & Hex(u)
end function

private function FormatBinScalar(byval n as Double, byref outText as String, byval asUnsigned as Boolean = FALSE) as Boolean
  dim iv as LongInt
  if TryGetExactInt64FromDouble(n, iv) = FALSE then return FALSE
  outText = FormatSignedMagnitudeBase(iv, 2, asUnsigned)
  return TRUE
end function

private function FormatBinUInt64(byval u as ULongInt) as String
  return FB_STR_PREFIX_BIN & Bin(u)
end function

private function FormatOctScalar(byval n as Double, byref outText as String, byval asUnsigned as Boolean = FALSE) as Boolean
  dim iv as LongInt
  if TryGetExactInt64FromDouble(n, iv) = FALSE then return FALSE
  outText = FormatSignedMagnitudeBase(iv, 8, asUnsigned)
  return TRUE
end function

private function FormatOctUInt64(byval u as ULongInt) as String
  return FB_STR_PREFIX_OCT & Oct(u)
end function

private function TryFormatScalarByRenderBase(byref sv as ScalarValue, byval renderBase as Integer, byval asUnsigned as Boolean, byref outText as String) as Boolean
  select case renderBase
    case 16
      if sv.exactUInt64Valid then
        outText = FormatHexUInt64(sv.exactUInt64)
        return TRUE
      end if
      if sv.exactInt64Valid then
        outText = FormatSignedMagnitudeBase(sv.exactInt64, 16, asUnsigned)
        return TRUE
      end if
      return FormatHexScalar(sv.scalar, outText, asUnsigned)
    case 8
      if sv.exactUInt64Valid then
        outText = FormatOctUInt64(sv.exactUInt64)
        return TRUE
      end if
      if sv.exactInt64Valid then
        outText = FormatSignedMagnitudeBase(sv.exactInt64, 8, asUnsigned)
        return TRUE
      end if
      return FormatOctScalar(sv.scalar, outText, asUnsigned)
    case 2
      if sv.exactUInt64Valid then
        outText = FormatBinUInt64(sv.exactUInt64)
        return TRUE
      end if
      if sv.exactInt64Valid then
        outText = FormatSignedMagnitudeBase(sv.exactInt64, 2, asUnsigned)
        return TRUE
      end if
      return FormatBinScalar(sv.scalar, outText, asUnsigned)
    case else
      return FALSE
  end select
end function

'' Integer real & integer imaginary (exact or float-equal int64).
private function TryFormatComplexScalarByRenderBase(byref sv as ScalarValue, byval renderBase as Integer, byval asUnsigned as Boolean, byref outText as String) as Boolean
  if Parser_SupportComplexNumbers = FALSE then return FALSE
  if ScalarHasNonzeroImaginaryPart(sv) = FALSE then return FALSE
  if renderBase <> 16 andalso renderBase <> 8 andalso renderBase <> 2 then return FALSE

  dim svRe as ScalarValue
  svRe = sv
  ScalarClearImag(svRe)

  dim imI as LongInt
  if ScalarImagExactInt64Valid(sv) then
    imI = sv.imagExactInt64
  elseif ScalarImagExactUInt64Valid(sv) then
    if sv.imagExactUInt64 <= FB_I64_MAX_U then
      imI = CLngInt(sv.imagExactUInt64)
    else
      return FALSE
    end if
  else
    dim ai as Double = sv.imag
    if TryGetExactInt64FromDouble(ai, imI) = FALSE then return FALSE
  end if

  dim reStr as String
  if TryFormatScalarByRenderBase(svRe, renderBase, asUnsigned, reStr) = FALSE then return FALSE

  dim absIm as LongInt
  dim negI as Boolean
  if imI >= 0 then
    absIm = imI
    negI = FALSE
  else
    if imI = FB_I64_MIN then return FALSE
    absIm = -imI
    negI = TRUE
  end if

  dim tail as String
  if absIm = 0 then '' Should not occur if ScalarHasNonzeroImaginaryPart
    tail = FB_STR_I
  elseif absIm = 1 then
    tail = FB_STR_I
  else
    dim evMag as EvalValue
    ValueSetInt64(evMag, absIm)
    if TryFormatScalarByRenderBase(evMag.scalarValue, renderBase, asUnsigned, tail) = FALSE then return FALSE
    tail = tail & FB_STR_I
  end if

  dim ar as Double = svRe.scalar
  if svRe.exactInt64Valid andalso svRe.exactInt64 = 0 then
    if negI then outText = "-" & tail else outText = tail
    return TRUE
  elseif svRe.exactInt64Valid = FALSE andalso ar = 0.0 then
    if negI then outText = "-" & tail else outText = tail
    return TRUE
  end if
  if negI then outText = reStr & "-" & tail else outText = reStr & "+" & tail
  return TRUE
end function

private function TryFormatScalarNonFiniteText(byval d as Double, byref outText as String) as Boolean
  if IsNaNValue(d) then
    outText = "nan"
    return TRUE
  end if
  if IsInfValue(d) then
    if d < 0 then
      outText = "-inf"
    else
      outText = "inf"
    end if
    return TRUE
  end if
  return FALSE
end function

private function FormatIntPowerParts(byval baseV as LongInt, byval expV as ULongInt) as String
  if expV <= 1ull then return ltrim(str(baseV))
  return ltrim(str(baseV)) & FB_STR_DOUBLE_ASTERISK & ltrim(str(expV))
end function

private function TryFormatIntPowerScalar(byref sv as ScalarValue, byref outText as String) as Boolean
  if (sv.flags and SVF_RENDER_INT_POWER) = 0 then return FALSE
  if sv.imagExactUInt64 <= 1ull then return FALSE
  outText = FormatIntPowerParts(sv.imagExactInt64, sv.imagExactUInt64)
  return TRUE
end function

private function FormatScalarExactOrFloatText(byref sv as ScalarValue) as String
  dim powText as String
  if TryFormatIntPowerScalar(sv, powText) then return powText
  if sv.exactInt64Valid then return ltrim(str(sv.exactInt64))
  if sv.exactUInt64Valid then return ltrim(ULongIntToString(sv.exactUInt64))
  return ltrim(str(sv.scalar))
end function

private function FormatScalarRealPartPlain(byref sv as ScalarValue) as String
  dim nf as String
  if TryFormatScalarNonFiniteText(sv.scalar, nf) then return nf
  return FormatScalarExactOrFloatText(sv)
end function

private function FormatRationalParts(byval num as LongInt, byval den as ULongInt) as String
  if num = 0 then return "0"
  if den = 1 then return ltrim(str(num))
  return ltrim(str(num)) & "/" & ltrim(str(den))
end function

private function TryFormatRationalScalar(byref sv as ScalarValue, byref outText as String) as Boolean
  if ScalarHasRenderRational(sv) = FALSE then return FALSE
  dim num as LongInt = sv.exactInt64
  dim den as ULongInt = sv.exactUInt64
  if den = 0 then return FALSE
  if num = 0 then
    outText = "0"
    return TRUE
  end if
  if den = 1 then
    outText = ltrim(str(num))
    return TRUE
  end if
  outText = ltrim(str(num)) & "/" & ltrim(str(den))
  return TRUE
end function

private function TryFormatComplexRationalScalar(byref sv as ScalarValue, byref outText as String) as Boolean
  if (sv.flags and (SVF_RENDER_RATIONAL or SVF_IMAG_RENDER_RATIONAL)) = 0 _
     andalso ScalarImagExactInt64Valid(sv) = FALSE then
    return FALSE
  end if
  dim rePart as String = ""
  if (sv.flags and SVF_RENDER_RATIONAL) <> 0 then
    rePart = FormatRationalParts(sv.exactInt64, sv.exactUInt64)
  elseif sv.exactInt64Valid then
    if sv.exactInt64 <> 0 then rePart = ltrim(str(sv.exactInt64))
  elseif abs(sv.scalar) >= RATIO_APPROX_EPS then
    return FALSE
  end if
  dim imTail as String = ""
  if (sv.flags and SVF_IMAG_RENDER_RATIONAL) <> 0 then
    dim rp as String = FormatRationalParts(sv.imagExactInt64, sv.imagExactUInt64)
    if sv.imagExactUInt64 > 1 then
      imTail = rp & "*i"
    elseif sv.imagExactInt64 = 1 then
      imTail = FB_STR_I
    elseif sv.imagExactInt64 = -1 then
      imTail = "-" & FB_STR_I
    else
      imTail = rp & FB_STR_I
    end if
  elseif ScalarImagExactInt64Valid(sv) then
    dim ni as LongInt = sv.imagExactInt64
    if ni = 1 then
      imTail = FB_STR_I
    elseif ni = -1 then
      imTail = "-" & FB_STR_I
    elseif ni <> 0 then
      imTail = ltrim(str(ni)) & FB_STR_I
    end if
  elseif ScalarHasNonzeroImaginaryPart(sv) then
    return FALSE
  end if
  if imTail = "" then
    if rePart = "" then rePart = "0"
    outText = rePart
    return TRUE
  end if
  if rePart = "" orelse rePart = "0" then
    outText = imTail
    return TRUE
  end if
  if left(imTail, 1) = "-" then
    outText = rePart & imTail
  else
    outText = rePart & "+" & imTail
  end if
  return TRUE
end function

private function FormatComplexImagCoeffTail(byval ai as Double, byref negUnit as Boolean) as String
  negUnit = FALSE
  if IsNaNValue(ai) then return "nan*" & FB_STR_I
  if IsInfValue(ai) then
    if ai < 0.0 then return "-" & FB_STR_INF & "*" & FB_STR_I
    return FB_STR_INF & "*" & FB_STR_I
  end if
  dim coeffAbs as Double = abs(ai)
  if coeffAbs = 1.0 then
    if ai < 0.0 then negUnit = TRUE
    return FB_STR_I
  end if
  if ai < 0.0 then return "-" & ltrim(str(coeffAbs)) & FB_STR_I
  return ltrim(str(coeffAbs)) & FB_STR_I
end function

private function FormatComplexImagCoeffTailFromScalar(byref sv as ScalarValue, byref negUnit as Boolean) as String
  negUnit = FALSE
  if ScalarImagExactInt64Valid(sv) then
    dim ni as LongInt = sv.imagExactInt64
    if ni = 1 then
      return FB_STR_I
    elseif ni = -1 then
      negUnit = TRUE
      return FB_STR_I
    elseif ni <> 0 then
      return ltrim(str(ni)) & FB_STR_I
    end if
  elseif ScalarImagExactUInt64Valid(sv) andalso sv.imagExactUInt64 <= FB_I64_MAX_U then
    dim ui as LongInt = CLngInt(sv.imagExactUInt64)
    if ui = 1 then return FB_STR_I
    if ui = -1 then negUnit = TRUE: return FB_STR_I
    return ltrim(str(ui)) & FB_STR_I
  end if
  dim ar as Double
  dim ai as Double
  ScalarLoadCartesian(sv, ar, ai)
  return FormatComplexImagCoeffTail(ai, negUnit)
end function

private function TryFormatComplexScalarForRender(byref sv as ScalarValue, byval renderBase as Integer, byval renderUnsigned as Boolean, byref outText as String) as Boolean
  if Parser_SupportComplexNumbers = FALSE orelse ScalarHasNonzeroImaginaryPart(sv) = FALSE then return FALSE
  if renderBase = 0 orelse renderBase = 10 then
    if TryFormatComplexRationalScalar(sv, outText) then return TRUE
    outText = FormatComplexScalarValue(sv)
    return TRUE
  end if
  return TryFormatComplexScalarByRenderBase(sv, renderBase, renderUnsigned, outText)
end function

private function AssembleComplexDecimalText(byref rePart as String, byref imagTail as String, byval negUnitImag as Boolean, byval reZero as Boolean) as String
  if reZero then
    if negUnitImag then return "-" & imagTail
    return imagTail
  end if
  if negUnitImag then return rePart & "-" & imagTail
  if left(imagTail, 1) = "-" then return rePart & imagTail
  return rePart & "+" & imagTail
end function

private function FormatComplexScalarValue(byref sv as ScalarValue) as String
  dim ratCx as String
  if TryFormatComplexRationalScalar(sv, ratCx) then return ratCx
  dim ar as Double, ai as Double
  ScalarLoadCartesian(sv, ar, ai)
  if IsNaNValue(ar) orelse IsNaNValue(ai) then return "nan"
  dim rePart as String = FormatScalarRealPartPlain(sv)

  dim negUnit as Boolean
  dim tail as String = FormatComplexImagCoeffTailFromScalar(sv, negUnit)

  dim reZero as Boolean = FALSE
  if sv.exactInt64Valid andalso sv.exactInt64 = 0 then
    reZero = TRUE
  elseif sv.exactInt64Valid = FALSE andalso ar = 0.0 then
    reZero = TRUE
  end if

  return AssembleComplexDecimalText(rePart, tail, negUnit, reZero)
end function

private function FormatScalarValueForText( _
  byref sv as ScalarValue, _
  byval renderBase as Integer, _
  byval renderUnsigned as Boolean, _
  byval exitOnComplexFallback as Boolean, _
  byval treatAsTime as Boolean _
) as String
  if Parser_SupportComplexNumbers andalso ScalarHasNonzeroImaginaryPart(sv) then
    dim fmtCx as String
    if TryFormatComplexScalarForRender(sv, renderBase, renderUnsigned, fmtCx) then return fmtCx
    if exitOnComplexFallback then return FormatComplexScalarValue(sv)
  end if
  if exitOnComplexFallback = FALSE then
    if (renderBase = 0 orelse renderBase = 10) then
      dim ratEarly as String
      if TryFormatRationalScalar(sv, ratEarly) then return ratEarly
      dim powEarly as String
      if TryFormatIntPowerScalar(sv, powEarly) then return powEarly
    end if
  end if
  dim nfScalar as String
  if TryFormatScalarNonFiniteText(sv.scalar, nfScalar) then return nfScalar
  if treatAsTime then
    return FormatTimeCanonicalFromMs(TimeTotalMsFromScalarValue(sv))
  end if
  if exitOnComplexFallback then
    dim ratText as String
    if TryFormatRationalScalar(sv, ratText) then return ratText
    dim powText as String
    if TryFormatIntPowerScalar(sv, powText) then return powText
  end if
  dim fmtText as String
  if TryFormatScalarByRenderBase(sv, renderBase, renderUnsigned, fmtText) then return fmtText
  if Parser_SupportComplexNumbers andalso ScalarHasNonzeroImaginaryPart(sv) then
    return FormatComplexScalarValue(sv)
  end if
  return FormatScalarExactOrFloatText(sv)
end function

private function ValueToString(byref v as EvalValue) as String
  if v.kind = VK_SCALAR then
    return FormatScalarValueForText( _
      v.scalarValue, v.renderBase, v.renderUnsigned, TRUE, (v.scalarStorageKind = SSK_TIME))
  end if
  if v.kind = VK_INLINE_LAMBDA orelse v.kind = VK_FUNCTION_REF then
    return ""
  end if

  dim s as String = "("
  dim i as Integer
  for i = lbound(v.arr) to ubound(v.arr)
    if i > lbound(v.arr) then s &= ", "
    s &= FormatScalarValueForText( _
      v.arr(i), v.renderBase, v.renderUnsigned, FALSE, ScalarIsTime(v.arr(i)))
  next i
  s &= ")"
  return s
end function

private sub SkipSpaces()
  while (pStream[0] = CHAR_SPACE) orelse (pStream[0] = CHAR_TAB) orelse (pStream[0] = CHAR_LF) orelse (pStream[0] = CHAR_CR)
    pStream += 1
  wend
end sub

private function IsIdentChar(byval ch as UByte) as Boolean
  return ((ch >= CHAR_A andalso ch <= CHAR_Z) orelse (ch >= CHAR_LC_A andalso ch <= CHAR_LC_Z) orelse (ch >= CHAR_DIGIT_0 andalso ch <= CHAR_DIGIT_9) orelse (ch = CHAR_UNDERSCORE))
end function

private function IsIdentStartChar(byval ch as Integer) as Boolean
  return ((ch >= CHAR_A andalso ch <= CHAR_Z) orelse (ch >= CHAR_LC_A andalso ch <= CHAR_LC_Z) orelse (ch = CHAR_UNDERSCORE))
end function

private function IsNumericLiteralStartChar(byval ch as Integer) as Boolean
  return ((ch >= CHAR_DIGIT_0 andalso ch <= CHAR_DIGIT_9) orelse (ch = CHAR_DOT))
end function

private function ToLowerCaseChar(byval c as UByte) as UByte
  if c >= CHAR_A andalso c <= CHAR_Z then return c + 32
  return c
end function

private function ConsumeIdentTokenFromStream() as String
  if IsIdentStartChar(asc(pStream[0])) = FALSE then return ""
  dim pStart as ZString ptr = pStream
  dim firstB as UByte = pStream[0]
  pStream += 1
  while IsIdentChar(asc(pStream[0]))
    pStream += 1
  wend
  dim buf as String = ""
  dim pu as UByte ptr = cast(UByte ptr, pStart)
  dim qu as UByte ptr = cast(UByte ptr, pStream)
  while pu < qu
    buf &= String(1, CInt(pu[0]))
    pu += 1
  wend
  if len(buf) = 0 andalso (firstB = CHAR_LC_I orelse firstB = CHAR_I) then
    return FB_STR_I
  end if
  return buf
end function

private function TryConsumeCommaArgSeparator(byref hasComma as Boolean) as Boolean
  hasComma = FALSE
  if pStream[0] <> CHAR_COMMA then return TRUE
  hasComma = TRUE
  pStream += 1
  SkipSpaces()
  if pStream[0] = CHAR_RPAREN orelse pStream[0] = CHAR_COMMA then
    SetParseErrorById(PARSE_ERR_UNEXPECTED_COMMA)
    return FALSE
  end if
  return TRUE
end function

private function MatchKeywordOperator(byref kw as String) as Boolean
  dim kwLen as Integer = Len(kw)
  if kwLen <= 0 then return FALSE
  dim kwPtr as UByte Ptr = cast(UByte Ptr, strptr(kw))
  dim p as UByte Ptr = cast(UByte Ptr, pStream)
  dim i as Integer
  for i = 0 to kwLen - 1
    dim c1 as UByte = ToLowerCaseChar(p[i])
    dim c2 as UByte = ToLowerCaseChar(kwPtr[i])
    if c1 <> c2 then return FALSE
  next i
  if IsIdentChar(p[kwLen]) then return FALSE
  pStream += kwLen
  return TRUE
end function

private function PeekMatchKeywordOperatorNoConsume(byref kw as String) as Boolean
  dim kwLen as Integer = Len(kw)
  if kwLen <= 0 then return FALSE
  dim kwPtr as UByte Ptr = cast(UByte Ptr, strptr(kw))
  dim p as UByte Ptr = cast(UByte Ptr, pStream)
  dim i as Integer
  for i = 0 to kwLen - 1
    if p[i] = 0 then return FALSE
    dim c1 as UByte = ToLowerCaseChar(p[i])
    dim c2 as UByte = ToLowerCaseChar(kwPtr[i])
    if c1 <> c2 then return FALSE
  next i
  return IsIdentChar(p[kwLen]) = FALSE
end function

private function StripLineComment(byref s as String) as String
  dim i as Integer
  for i = 1 to len(s)
    dim ch as String = mid(s, i, 1)
    if ch = "#" then
      return left(s, i - 1)
    end if
    if ch = "/" andalso i < len(s) then
      if mid(s, i + 1, 1) = "/" then
        return left(s, i - 1)
      end if
    end if
  next i
  return s
end function

private function IsBuiltinConstantName(byref n as String) as Boolean
  dim cid as Integer = TryFindBuiltinConstId(n)
  if cid < 0 then return FALSE
  if cid = CONST_I then return Parser_SupportComplexNumbers
  if cid = CONST_MILLISECOND orelse cid = CONST_SECOND orelse cid = CONST_MINUTE orelse cid = CONST_HOUR orelse cid = CONST_DAY then
    return Parser_SupportTimeValues
  end if
  return TRUE
end function

private function TryConsumeClosingParenOrSetError() as Boolean
  if pStream[0] = CHAR_RPAREN then
    pStream += 1
    return TRUE
  end if
  if pStream[0] = CHAR_RBRACKET then
    SetParseErrorById(PARSE_ERR_MISMATCHED_CLOSING_BRACKET)
  elseif pStream[0] = CHAR_RBRACE then
    SetParseErrorById(PARSE_ERR_MISMATCHED_CLOSING_BRACE)
  elseif IsIdentStartChar(asc(pStream[0])) orelse IsNumericLiteralStartChar(asc(pStream[0])) then
    '' e.g. ``(2+3x)``: ``x`` cannot close the group; treat as stray input (parity with C++ ``setMissingClosingParenLikeError``).
    SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
  else
    SetParseErrorById(PARSE_ERR_MISSING_CLOSING_PARENTHESIS)
  end if
  return FALSE
end function

private sub SetMismatchedBracketBraceOrUnexpectedToken(byval ch as Integer)
  if ch = CHAR_RBRACKET then
    SetParseErrorById(PARSE_ERR_MISMATCHED_CLOSING_BRACKET)
  elseif ch = CHAR_RBRACE then
    SetParseErrorById(PARSE_ERR_MISMATCHED_CLOSING_BRACE)
  else
    SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
  end if
end sub

private function TryValidateIdentifierIsNotReserved(byref ident as String, byref errText as String) as Boolean
  if IsReservedUserFunctionName(ident) then
    errText = FB_STR_RESERVED_FUNCTION_NAME_COLON & ident
    return FALSE
  end if
  if IsBuiltinConstantName(ident) then
    errText = FB_STR_RESERVED_CONSTANT_NAME_COLON & ident
    return FALSE
  end if
  return TRUE
end function

private function TryValidateUserFunctionDefinitionNames(byref fnName as String, fnParams() as String, byref errText as String) as Boolean
  if IsReservedBuiltinVariableNameForUserFunction(fnName) then
    errText = FB_STR_RESERVED_BUILTIN_VARIABLE_NAME_COLON & fnName
    return FALSE
  end if
  if TryValidateIdentifierIsNotReserved(fnName, errText) = FALSE then
    return FALSE
  end if
  if ubound(fnParams) >= lbound(fnParams) then
    for iParam as Integer = lbound(fnParams) to ubound(fnParams)
      if IsBuiltinConstantName(fnParams(iParam)) then
        errText = FB_STR_RESERVED_CONSTANT_NAME_COLON & fnParams(iParam)
        return FALSE
      end if
      for jParam as Integer = iParam + 1 to ubound(fnParams)
        if fnParams(iParam) = fnParams(jParam) then
          errText = FB_STR_DUPLICATE_PARAMETER_NAME_COLON & fnParams(iParam)
          return FALSE
        end if
      next jParam
    next iParam
  end if
  return TRUE
end function

private function TryGetConstant(byref n as String, byref v as EvalValue) as Boolean
  dim cid as Integer = TryFindBuiltinConstId(n)
  if cid < 0 then return FALSE
  select case cast(BuiltinConstId, cid)
    case CONST_PI
      ValueSetScalar(v, FB_PI_VAL)
    case CONST_E
      ValueSetScalar(v, exp(1.0))
    case CONST_INF
      ValueSetScalar(v, 1.0 / 0.0)
    case CONST_NAN
      ValueSetScalar(v, MakeNaN())
    case CONST_MILLISECOND, CONST_SECOND, CONST_MINUTE, CONST_HOUR, CONST_DAY
      if Parser_SupportTimeValues = FALSE then return FALSE
      select case cid
      case CONST_MILLISECOND
        ValueSetTimeMs(v, 1)
      case CONST_SECOND
        ValueSetTimeMs(v, 1000)
      case CONST_MINUTE
        ValueSetTimeMs(v, 60000)
      case CONST_HOUR
        ValueSetTimeMs(v, 3600000)
      case CONST_DAY
        ValueSetTimeMs(v, 86400000)
      end select
    case CONST_I
      if Parser_SupportComplexNumbers = FALSE then return FALSE
      ValueSetImagUnit(v)
    case else
      return FALSE
  end select
  return TRUE
end function

private function FindVariableIndex(byref n as String) as Integer
  dim i as Integer
  for i = lbound(variables) to ubound(variables)
    if variables(i).name = n then return i
  next i
  return -1
end function

#ifdef __FB_FUNC_VARS_OVERRIDE_GLOBALS__
private function TryGetFunctionVariableOverride(byref n as String, byref v as EvalValue) as Boolean
  dim i as Integer
  for i = 0 to functionVariableCount - 1
    if functionVariableNames(i) = n then
      dim idx as Integer = FindVariableIndex(FB_STR_FORMAL_VALIDATION_PROBE)
      if idx >= 0 andalso variables(idx).value.kind = VK_SCALAR then
        v = variables(idx).value
      else
        ValueSetInt64(v, 1)
      end if
      return TRUE
    end if
  next i
  return FALSE
end function
#endif

private function GetVariable(byref n as String, byref v as EvalValue) as Boolean
#ifdef __FB_FUNC_VARS_OVERRIDE_GLOBALS__
  if TryGetFunctionVariableOverride(n, v) then return TRUE
#endif
  if lcase(n) = FB_STR_ANS then
    dim j as Integer
    for j = lbound(variables) to ubound(variables)
      if variables(j).name = FB_STR_ANS then
        v = variables(j).value
        return TRUE
      end if
    next j
    return FALSE
  end if
  dim i as Integer
  for i = lbound(variables) to ubound(variables)
    if variables(i).name = n then
      v = variables(i).value
      return TRUE
    end if
  next i
  return FALSE
end function

private sub SetVariable(byref n as String, byref v as EvalValue)
  dim i as Integer
  for i = lbound(variables) to ubound(variables)
    if variables(i).name = n then
      variables(i).value = v
      exit sub
    end if
  next i
  if ubound(variables) = -1 then
    redim variables(0)
  else
    redim preserve variables(ubound(variables) + 1)
  end if
  variables(ubound(variables)).name = n
  variables(ubound(variables)).value = v
end sub

private sub RemoveVariableAtIndex(byval vIdx as Integer)
  if vIdx < lbound(variables) orelse vIdx > ubound(variables) then exit sub
  if ubound(variables) = lbound(variables) then
    erase variables
    exit sub
  end if
  dim j as Integer
  for j = vIdx to ubound(variables) - 1
    variables(j) = variables(j + 1)
  next j
  redim preserve variables(lbound(variables) to ubound(variables) - 1)
end sub

private sub RemoveVariableByName(byref n as String)
  dim idx as Integer = FindVariableIndex(n)
  if idx >= 0 then RemoveVariableAtIndex(idx)
end sub

private function FindFunctionIndex(byref n as String) as Integer
  dim i as Integer
  for i = lbound(userFunctions) to ubound(userFunctions)
    if userFunctions(i).name = n then return i
  next i
  return -1
end function

private function FormatUserFunctionSignature(byval fnIdx as Integer) as String
  dim sig as String = userFunctions(fnIdx).name & "("
  if ubound(userFunctions(fnIdx).params) >= lbound(userFunctions(fnIdx).params) then
    dim k as Integer
    for k = lbound(userFunctions(fnIdx).params) to ubound(userFunctions(fnIdx).params)
      if k > lbound(userFunctions(fnIdx).params) then sig &= FB_STR_COMMA
      sig &= userFunctions(fnIdx).params(k)
    next k
  end if
  sig &= ")"
  return sig
end function

private sub RemoveUserFunctionAtIndex(byval fnIdx as Integer)
  if fnIdx < lbound(userFunctions) orelse fnIdx > ubound(userFunctions) then exit sub
  if ubound(userFunctions) = lbound(userFunctions) then
    erase userFunctions
    exit sub
  end if
  dim j as Integer
  for j = fnIdx to ubound(userFunctions) - 1
    userFunctions(j) = userFunctions(j + 1)
  next j
  redim preserve userFunctions(lbound(userFunctions) to ubound(userFunctions) - 1)
end sub

private sub RemoveUserFunctionByName(byref n as String)
  dim idx as Integer = FindFunctionIndex(n)
  if idx >= 0 then RemoveUserFunctionAtIndex(idx)
end sub

private sub SetAnsValue(byref v as EvalValue)
  SetVariable(FB_STR_ANS, v)
end sub

'' True if body text contains a call to the same identifier as fnName (case-insensitive), e.g. y(a)=g(a)+y(a)+4.
private function UdfBodyCallsDefinedFunction(byref bodyText as String, byref fnName as String) as Boolean
  dim lowFn as String = lcase(trim(fnName))
  if len(lowFn) = 0 then return FALSE

  dim b as String = bodyText
  dim bn as Integer = len(b)
  dim ip as Integer = 1
  while ip <= bn
    dim ca as Integer = asc(mid(b, ip, 1))
    if (ca >= asc("a") andalso ca <= asc("z")) orelse (ca >= asc("A") andalso ca <= asc("Z")) orelse mid(b, ip, 1) = "_" then
      dim i0 as Integer = ip
      while ip <= bn
        ca = asc(mid(b, ip, 1))
        if (ca >= asc("a") andalso ca <= asc("z")) orelse (ca >= asc("A") andalso ca <= asc("Z")) orelse (ca >= asc("0") andalso ca <= asc("9")) orelse mid(b, ip, 1) = "_" then
          ip += 1
        else
          exit while
        end if
      wend
      if lcase(mid(b, i0, ip - i0)) = lowFn then
        dim jp as Integer = ip
        while jp <= bn
          ca = asc(mid(b, jp, 1))
          if ca = CHAR_SPACE orelse ca = CHAR_TAB then
            jp += 1
          else
            exit while
          end if
        wend
        if jp <= bn andalso mid(b, jp, 1) = "(" then return TRUE
      end if
    else
      ip += 1
    end if
  wend
  return FALSE
end function

declare function TryValidateUserFunctionBodyExpression(byref body as String, fnParams() as String, byref errText as String) as Boolean

private function UdfBodyIsEmptyTupleLiteral(byref body as string) as Boolean
  dim t as string = trim(body)
  if len(t) < 2 then return FALSE
  if left(t, 1) <> "(" orelse right(t, 1) <> ")" then return FALSE
  dim i as Integer
  for i = 2 to len(t) - 1
    dim ch as Integer = asc(mid(t, i, 1))
    if ch <> CHAR_SPACE andalso ch <> CHAR_TAB then return FALSE
  next i
  return TRUE
end function

private function TryValidateUserFunctionDefinition(byref fnName as String, fnParams() as String, byref body as String, byref errText as String) as Boolean
  if TryValidateUserFunctionDefinitionNames(fnName, fnParams(), errText) = FALSE then
    return FALSE
  end if
  if len(trim(body)) = 0 orelse UdfBodyIsEmptyTupleLiteral(body) then
    errText = FB_STR_FUNCTION_BODY_IS_EMPTY
    return FALSE
  end if
  if UdfBodyCallsDefinedFunction(body, fnName) then
    errText = FB_STR_RECURSIVE_USER_FUNCTION_CALL_COLON & fnName
    return FALSE
  end if
  validatingUserFunctionName = lcase(fnName)
  if TryValidateUserFunctionBodyExpression(body, fnParams(), errText) = FALSE then
    validatingUserFunctionName = ""
    return FALSE
  end if
  validatingUserFunctionName = ""
  return TRUE
end function

private sub SetUserFunction(byref n as String, params() as String, byref expr as String)
  RemoveVariableByName(n)
  dim idx as Integer = FindFunctionIndex(n)
  if idx < 0 then
    if ubound(userFunctions) = -1 then
      redim userFunctions(0)
    else
      redim preserve userFunctions(ubound(userFunctions) + 1)
    end if
    idx = ubound(userFunctions)
  end if

  userFunctions(idx).name = n
  userFunctions(idx).expr = expr
  if ubound(params) >= lbound(params) then
    with userFunctions(idx)
      redim .params(lbound(params) to ubound(params))
      for i as Integer = lbound(params) to ubound(params)
        .params(i) = params(i)
      next i
    end with
  else
    erase userFunctions(idx).params
  end if
end sub

declare function ParseExpression() as EvalValue
declare function ParseLogicalOr() as EvalValue
declare function ParseLogicalAnd() as EvalValue
declare function ParseLogicalNot() as EvalValue
declare function ParseComparison() as EvalValue
declare function ParseBitwiseOr() as EvalValue
declare function ParseBitwiseXor() as EvalValue
declare function ParseBitwiseAnd() as EvalValue
declare function ParseShift() as EvalValue
declare function ParseAdditive() as EvalValue
declare function ParseMultiplicative() as EvalValue
declare function ParseLeftAssocBinary(byval kind as Integer, byval int64LevelId as Integer) as EvalValue
declare function ParseUnary() as EvalValue
declare function ParsePower() as EvalValue
declare function ParseFactor() as EvalValue

private function BuildUnknownNameErrorText(byref unknownVars as String, byref unknownFuncs as String) as String
  dim errText as String = ""
  if unknownVars <> "" then
    errText = FB_STR_UNKNOWN_VARIABLE_COLON & unknownVars
    if unknownFuncs <> "" then
      errText &= FB_STR_SEMICOLON_UNKNOWN_FUNCTION_COLON & unknownFuncs
    end if
    return errText
  end if
  if unknownFuncs <> "" then
    errText = FB_STR_UNKNOWN_FUNCTION_COLON & unknownFuncs
  end if
  return errText
end function

private sub ApplyUnknownNameErrors()
  dim errText as String = BuildUnknownNameErrorText(unknownVarsText, unknownFuncsText)
  if errText <> "" then
    SetParseError(errText)
  end if
end sub

private function SkipAsciiSpacesPtr(byval p as ZString ptr) as ZString ptr
  while p[0] = CHAR_SPACE orelse p[0] = CHAR_TAB
    p += 1
  wend
  return p
end function

private function EndOfIdentTokenPtr(byval p as ZString ptr) as ZString ptr
  if IsIdentStartChar(asc(p[0])) = FALSE then return p
  p += 1
  while IsIdentChar(asc(p[0]))
    p += 1
  wend
  return p
end function

private function PeekIdentFollowedByChar(byval p as ZString ptr, byval ch as UByte) as Boolean
  p = SkipAsciiSpacesPtr(EndOfIdentTokenPtr(p))
  return (p[0] = ch)
end function

private function PeekIdentFollowedByAssignEquals(byval p as ZString ptr) as Boolean
  p = SkipAsciiSpacesPtr(EndOfIdentTokenPtr(p))
  return (p[0] = CHAR_EQUALS) andalso (p[1] <> CHAR_EQUALS)
end function

private function PeekUnwrappedLambdaParamsThenColon(byval p as ZString ptr) as Boolean
  p = SkipAsciiSpacesPtr(p)
  if IsIdentStartChar(asc(p[0])) = FALSE then return FALSE
  p = SkipAsciiSpacesPtr(EndOfIdentTokenPtr(p))
  while p[0] = CHAR_COMMA
    p = SkipAsciiSpacesPtr(p + 1)
    if IsIdentStartChar(asc(p[0])) = FALSE then return FALSE
    p = SkipAsciiSpacesPtr(EndOfIdentTokenPtr(p))
  wend
  return (p[0] = CHAR_COLON)
end function

private function PeekParenParamListThenColon(byval p as ZString ptr) as Boolean
  p = SkipAsciiSpacesPtr(p)
  if p[0] <> CHAR_LPAREN then return FALSE
  p = SkipAsciiSpacesPtr(p + 1)
  if p[0] = CHAR_RPAREN then
    p = SkipAsciiSpacesPtr(p + 1)
    return (p[0] = CHAR_COLON)
  end if
  if IsIdentStartChar(asc(p[0])) = FALSE then return FALSE
  do
    p = SkipAsciiSpacesPtr(EndOfIdentTokenPtr(p))
    if p[0] = CHAR_COMMA then
      p = SkipAsciiSpacesPtr(p + 1)
      if IsIdentStartChar(asc(p[0])) = FALSE then return FALSE
    elseif p[0] = CHAR_RPAREN then
      p = SkipAsciiSpacesPtr(p + 1)
      return (p[0] = CHAR_COLON)
    else
      return FALSE
    end if
  loop
end function

private function PeekRhsMayBeLambdaSyntaxAt(byval p as ZString ptr) as Boolean
  p = SkipAsciiSpacesPtr(p)
  if p[0] = CHAR_LPAREN then
    if PeekParenParamListThenColon(p) then return TRUE
    return PeekRhsMayBeLambdaSyntaxAt(p + 1)
  end if
  return PeekUnwrappedLambdaParamsThenColon(p)
end function

private function IdentMayBeBareBuiltinName(byref nam as String) as Boolean
  dim i as Integer
  dim hasDigitOrUnderscore as Boolean = FALSE
  for i = 1 to len(nam)
    dim ch as Integer = asc(mid(nam, i, 1))
    if (ch >= CHAR_DIGIT_0 andalso ch <= CHAR_DIGIT_9) orelse ch = CHAR_UNDERSCORE then
      hasDigitOrUnderscore = TRUE
      exit for
    end if
  next i
  if hasDigitOrUnderscore = FALSE then return TRUE
  return (TryFindBuiltinFunctionId(nam) >= 0)
end function

private function TrimmedStmtIsBareBuiltinOrUdfName(byref stmt as String) as Boolean
  dim t as String = trim(stmt)
  dim lenT as Integer = len(t)
  if lenT = 0 then return FALSE
  if IsIdentStartChar(asc(left(t, 1))) = FALSE then return FALSE
  dim identEnd as Integer = 2
  while identEnd <= lenT
    if IsIdentChar(asc(mid(t, identEnd, 1))) = FALSE then exit while
    identEnd += 1
  wend
  if identEnd <= lenT then return FALSE
  dim nam as String = left(t, identEnd - 1)
  dim fnHint as String
  if IdentMayBeBareBuiltinName(nam) andalso TryGetBuiltinSignatureHint(nam, fnHint) then return TRUE
  if FindFunctionIndex(nam) >= 0 then return TRUE
  return FALSE
end function

private sub NormalizeTrailingStatementSemicolons(byref s as string, byref outStrippedSuppressTailHint as Boolean)
  outStrippedSuppressTailHint = FALSE
  dim progressing as Boolean = TRUE
  while progressing <> FALSE
    progressing = FALSE
    while Len(s) > 0
      dim lastCp as Integer = Asc(Mid(s, Len(s), 1))
      if lastCp = CHAR_SPACE orelse lastCp = CHAR_TAB orelse lastCp = CHAR_LF orelse lastCp = CHAR_CR then
        s = Left(s, Len(s) - 1)
        progressing = TRUE
      else
        exit while
      end if
    wend
    if Len(s) > 0 andalso Asc(Mid(s, Len(s), 1)) = CHAR_SEMICOLON then
      dim beforeSemi as String = trim(left(s, Len(s) - 1))
      if TrimmedStmtIsBareBuiltinOrUdfName(beforeSemi) then
        exit sub
      end if
      ' Keep trailing ';' on multi-statement input so the last segment stays semicolon-terminated.
      if instr(beforeSemi, ";") > 0 then
        exit sub
      end if
      ' Path C: stripped trailing ';' hides semicolon from the parse buffer.
      outStrippedSuppressTailHint = TRUE
      s = Left(s, Len(s) - 1)
      progressing = TRUE
    end if
  wend
end sub

private function IsBareFunctionNameAtExpressionTail() as Boolean
  SkipSpaces()
  return (pStream[0] = CHAR_NUL)
end function

private function TrySetBareFunctionImmediateCloserError(byval identStart as ZString ptr) as Boolean
  if identStart <> exprStart then return FALSE
  dim cu as UByte = pStream[0]
  if cu = CHAR_RPAREN then
    SetParseErrorById(PARSE_ERR_MISMATCHED_CLOSING_PARENTHESIS)
    return TRUE
  elseif cu = CHAR_RBRACKET then
    SetParseErrorById(PARSE_ERR_MISMATCHED_CLOSING_BRACKET)
    return TRUE
  elseif cu = CHAR_RBRACE then
    SetParseErrorById(PARSE_ERR_MISMATCHED_CLOSING_BRACE)
    return TRUE
  end if
  return FALSE
end function

private function TryEmitBareBuiltinOrUdfTailHint(byref fnHint as String, byval isBuiltin as Boolean, byval udfIdx as Integer, byval suppressUdfTailHint as Boolean) as Boolean
  if suppressBareFunctionTailHint then return FALSE
  if IsBareFunctionNameAtExpressionTail() = FALSE then return FALSE
  if isBuiltin = FALSE andalso suppressUdfTailHint then return FALSE
  if isBuiltin then
    SetParseError(FB_STR_HINT_PREFIX & fnHint)
  else
    SetParseError(FB_STR_USER_DEFINED_FUNCTION_COLON & FormatUserFunctionSignature(udfIdx))
  end if
  return TRUE
end function

private function TryHandleBareBuiltinOrUdfIdent(byref nam as String, byref fnHint as String, byval isBuiltin as Boolean, byval udfIdx as Integer, byval identStart as ZString ptr, byval suppressUdfTailHint as Boolean) as Boolean
  SkipSpaces()
  ' Path B: ';' still visible in the active parse buffer.
  if pStream[0] = CHAR_SEMICOLON then
    SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
    return TRUE
  end if
  if TryEmitBareBuiltinOrUdfTailHint(fnHint, isBuiltin, udfIdx, suppressUdfTailHint) then return TRUE
  if TrySetBareFunctionImmediateCloserError(identStart) then return TRUE
  SetParseError(FB_STR_UNKNOWN_VARIABLE_COLON & nam)
  return TRUE
end function

private function TrySetIncompleteOpenedFunctionCallHint(byref fnName as String) as Boolean
  dim fnHint as String
  if IdentMayBeBareBuiltinName(fnName) andalso TryGetBuiltinSignatureHint(fnName, fnHint) then
    return TryEmitBareBuiltinOrUdfTailHint(fnHint, TRUE, -1, FALSE)
  end if
  dim udfIdx as Integer = -1
  if lbound(userFunctions) <= ubound(userFunctions) then udfIdx = FindFunctionIndex(fnName)
  if udfIdx >= 0 then
    return TryEmitBareBuiltinOrUdfTailHint(fnHint, FALSE, udfIdx, FALSE)
  end if
  return FALSE
end function

private function TryHandleUnknownIdentifier(byref nam as String, byref outV as EvalValue, byref canIndex as Boolean, byval identStart as ZString ptr) as Boolean
  dim lowNam as String = lcase(nam)
  if IsLogicalBinaryOperatorKeyword(lowNam) then
    SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
    return FALSE
  end if
  dim fnHint as String
  if IdentMayBeBareBuiltinName(nam) andalso TryGetBuiltinSignatureHint(nam, fnHint) then
    if TryHandleBareBuiltinOrUdfIdent(nam, fnHint, TRUE, -1, identStart, FALSE) then return FALSE
    return FALSE
  end if
  dim udfIdx as Integer = -1
  if lbound(userFunctions) <= ubound(userFunctions) then udfIdx = FindFunctionIndex(nam)
  if udfIdx >= 0 then
    dim suppressUdfTailHint as Boolean = FALSE
    if (udfCallStackSp > 0 andalso udfCallStack(udfCallStackSp - 1) = lowNam) _
        orelse (len(validatingUserFunctionName) > 0 andalso lowNam = validatingUserFunctionName) then
      suppressUdfTailHint = TRUE
    end if
    if TryHandleBareBuiltinOrUdfIdent(nam, fnHint, FALSE, udfIdx, identStart, suppressUdfTailHint) then return FALSE
    return FALSE
  end if
  AppendUniqueName(unknownVarsText, nam)
  ValueSetInt64(outV, 0)
  canIndex = FALSE
  return TRUE
end function

private sub SetNumericErrorInFunction(byref fnName as String)
  SetParseError(FB_STR_NUMERIC_ERROR_IN & fnName & FB_STR_PAR)
end sub

private sub SetAtLeastNArgsError(byref fnName as String, byval minArgs as Integer)
  dim suffix as String
  if minArgs = 1 then
    suffix = FB_STR_ARGUMENT
  else
    suffix = FB_STR_ARGUMENTS
  end if
  SetParseError(fnName & FB_STR_PAR_EXPECTS_AT_LEAST & ltrim(str(minArgs)) & suffix)
end sub

private sub SetAtLeastOneArgError(byref fnName as String)
  SetAtLeastNArgsError(fnName, 1)
end sub

private sub SetExactArgCountError(byref fnName as String, byval expectedCount as Integer, byval actualCount as Integer)
  SetParseError(fnName & FB_STR_PAR_EXPECTS & ltrim(str(expectedCount)) & FB_STR_ARGUMENT_PAR_S_COMMA & ltrim(str(actualCount)) & FB_STR_GIVEN)
end sub

private sub GetBuiltinArity(byval id as Integer, byref minArgs as Integer, byref maxArgs as Integer)
  if id < 0 orelse id >= FUNC__COUNT then
    minArgs = -1
    maxArgs = -1
    exit sub
  end if
  if HasBuiltinFlag(id, BUILTIN_FLAG_UNARY) then
    minArgs = 1
    maxArgs = 1
    exit sub
  end if
  if K_BUILTIN_META_ROWS(id).minArgs = BUILTIN_META_ARITY_UNSET then
    minArgs = -1
    maxArgs = -1
    exit sub
  end if
  minArgs = K_BUILTIN_META_ROWS(id).minArgs
  maxArgs = K_BUILTIN_META_ROWS(id).maxArgs
end sub

private function ValidateCallArity(byval minArgs as Integer, byval maxArgs as Integer, byval argc as Integer, byref fnName as String) as Boolean
  if minArgs = maxArgs then
    if argc <> minArgs then
      SetExactArgCountError(fnName, minArgs, argc)
      return FALSE
    end if
    return TRUE
  end if
  if argc < minArgs then
    SetAtLeastNArgsError(fnName, minArgs)
    return FALSE
  end if
  if (maxArgs <> BUILTIN_ARITY_UNBOUNDED) andalso (argc > maxArgs) then
    SetExactArgCountError(fnName, maxArgs, argc)
    return FALSE
  end if
  return TRUE
end function

private function ValidateBuiltinCallArity(byval fnId as Integer, byref fnName as String, args() as EvalValue) as Boolean
  dim minArgs as Integer = 0
  dim maxArgs as Integer = 0
  GetBuiltinArity(fnId, minArgs, maxArgs)
  if minArgs < 0 then return TRUE
  return ValidateCallArity(minArgs, maxArgs, ubound(args) + 1, fnName)
end function

private sub SetScalarValuesError(byref fnName as String)
  SetParseError(fnName & FB_STR_PAR_EXPECTS_SCALAR_VALUES)
end sub

private sub SetIntegerValuesError(byref fnName as String)
  SetParseError(fnName & FB_STR_PAR_EXPECTS_INTEGER_VALUES)
end sub

private sub SetScalarMinMaxError(byref fnName as String)
  SetParseError(fnName & FB_STR_PAR_EXPECTS_SCALAR_MIN_SLASH)
end sub

private sub SetNonNegativeIntegerError(byref fnName as String)
  SetParseError(fnName & FB_STR_PAR_EXPECTS_A_NON_DASH)
end sub

private sub SetPositiveIntegerError(byref fnName as String)
  SetParseError(fnName & FB_STR_PAR_EXPECTS_A_POSITIVE_INTEGER)
end sub

private sub SetRangeStepZeroError(byref fnName as String)
  SetParseError(fnName & FB_STR_PAR_STEP_MUST_NOT_BE_ZERO)
end sub

private sub SetRangeEmptyError(byref fnName as String)
  SetParseError(fnName & FB_STR_PAR_PRODUCES_NO_VALUES)
end sub

private sub SetTooManyValuesError(byref fnName as String)
  SetParseError(fnName & FB_STR_PAR_PRODUCES_TOO_MANY_VALUES)
end sub

' CPython-style length of range(start, stop, step) using unsigned wraparound arithmetic.
private function EstimateRangeItemCount(byval startV as LongInt, byval stopV as LongInt, byval stepV as LongInt) as ULongInt
  dim uLo as ULongInt, uHi as ULongInt, uStep as ULongInt
  if stepV > 0 then
    if startV >= stopV then return 0ull
    uLo = CULngInt(startV)
    uHi = CULngInt(stopV)
    uStep = CULngInt(stepV)
  else
    if startV <= stopV then return 0ull
    uLo = CULngInt(stopV)
    uHi = CULngInt(startV)
    uStep = 0ull - CULngInt(stepV)
  end if
  return (uHi - uLo - 1ull) \ uStep + 1ull
end function

' Returns TRUE when count is within limit; FALSE sets too-many-values error.
private function AcceptProducedItemCount(byref fnName as String, byval count as ULongInt) as Boolean
  if count > CULngInt(BUILTIN_MAX_PRODUCED_ITEMS) then
    SetTooManyValuesError(fnName)
    return FALSE
  end if
  return TRUE
end function

private function EvalValuesHaveMismatchedArrayLengths(byref leftV as EvalValue, byref rightV as EvalValue) as Boolean
  return (leftV.kind = VK_ARRAY) andalso (rightV.kind = VK_ARRAY) andalso (ValueArrayLen(leftV) <> ValueArrayLen(rightV))
end function

'' pairStatus: 0 ok, 1 integer operands, 2 numeric/domain, 3 broadcast shape mismatch.
private sub SetBinaryBuiltinBroadcastFailure(byref fnName as String, byref leftV as EvalValue, byref rightV as EvalValue, byval pairStatus as Integer)
  if pairStatus = 1 then
    SetIntegerValuesError(fnName)
  elseif (pairStatus = 3) orelse EvalValuesHaveMismatchedArrayLengths(leftV, rightV) then
    SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
  elseif parseError = 0 then
    SetNumericErrorInFunction(fnName)
  end if
end sub

private sub SetTimeLiteralEmptySegmentError()
  SetParseError(FB_STR_TIME_EMPTY_SEGMENT)
end sub

private sub SetTimeLiteralInvalidSegmentError()
  SetParseError(FB_STR_TIME_INVALID_SEGMENT)
end sub

private sub SetTimeNonFiniteError()
  SetParseError(FB_STR_TIME_NON_FINITE)
end sub

private sub SetTimeArrayMixedError(byref fnName as String)
  SetParseError(fnName & ": " & FB_STR_TIME_ARRAY_MIXED)
end sub

private function EvalValueInvolvesTime(byref v as EvalValue) as Boolean
  if Parser_SupportTimeValues = FALSE then return FALSE
  if v.kind <> VK_SCALAR then
    if ValueArrayLen(v) <= 0 then return FALSE
    dim i as Integer
    for i = lbound(v.arr) to ubound(v.arr)
      if ScalarIsTime(v.arr(i)) then return TRUE
    next i
    return FALSE
  end if
  return ScalarIsTime(v.scalarValue)
end function

private function SecondsFieldToMsRounded(byval wholeSec as LongInt, byref fracDigits as String) as LongInt
  dim d as Double = CDbl(wholeSec)
  if len(fracDigits) > 0 then
    dim fd as Double = val("0." & fracDigits)
    if IsNonFiniteValue(fd) then return 0
    d += fd
  end if
  return RoundHalfUpDoubleToLongInt(d * 1000.0)
end function

private function ParseTimeLiteralStringToMs(byref lit as String, byref outMs as LongInt) as Boolean
  dim n as Integer = len(lit)
  if n <= 0 then return FALSE
  dim colonPos() as Integer
  redim colonPos(0 to 7)
  dim colonCount as Integer = 0
  dim i as Integer
  for i = 1 to n
    if mid(lit, i, 1) = ":" then
      if colonCount > 6 then
        SetTimeLiteralInvalidSegmentError()
        return FALSE
      end if
      colonCount += 1
      colonPos(colonCount) = i
    end if
  next i
  dim segCount as Integer = colonCount + 1
  if segCount < 2 orelse segCount > 4 then
    SetTimeLiteralInvalidSegmentError()
    return FALSE
  end if

  dim getSegStart as Integer = 1
  dim si as Integer
  dim d as LongInt, h as LongInt, m as LongInt
  dim lastWhole as LongInt
  dim fracPart as String = ""
  dim dotPos as Integer = 0
  dim segStr as String

  for si = 1 to segCount
    dim segEnd as Integer
    if si <= colonCount then
      segEnd = colonPos(si) - 1
    else
      segEnd = n
    end if
    if segEnd < getSegStart then
      SetTimeLiteralEmptySegmentError()
      return FALSE
    end if
    segStr = mid(lit, getSegStart, segEnd - getSegStart + 1)
    if len(segStr) <= 0 then
      SetTimeLiteralEmptySegmentError()
      return FALSE
    end if
    if si = segCount then
      dotPos = instr(1, segStr, ".")
      if dotPos > 0 then
        fracPart = mid(segStr, dotPos + 1)
        segStr = left(segStr, dotPos - 1)
        if len(segStr) <= 0 then
          SetTimeLiteralEmptySegmentError()
          return FALSE
        end if
      else
        fracPart = ""
      end if
    end if
    dim j as Integer
    for j = 1 to len(segStr)
      dim ch as Integer = asc(mid(segStr, j, 1))
      if ch < CHAR_DIGIT_0 orelse ch > CHAR_DIGIT_9 then
        SetTimeLiteralInvalidSegmentError()
        return FALSE
      end if
    next j
    dim uv as ULongInt = 0
    for j = 1 to len(segStr)
      dim dig as Integer = asc(mid(segStr, j, 1)) - CHAR_DIGIT_0
      if TryMult10OnceChecked(uv, uv) = FALSE then
        SetTimeLiteralInvalidSegmentError()
        return FALSE
      end if
      if TryAddULongChecked(uv, CULngInt(dig), uv) = FALSE then
        SetTimeLiteralInvalidSegmentError()
        return FALSE
      end if
    next j
    if uv > 9223372036854775807ull then
      SetTimeLiteralInvalidSegmentError()
      return FALSE
    end if
    lastWhole = CLngInt(uv)
    if si < segCount then
      select case segCount
        case 2
          if si = 1 then m = lastWhole
        case 3
          if si = 1 then h = lastWhole
          if si = 2 then m = lastWhole
        case 4
          if si = 1 then d = lastWhole
          if si = 2 then h = lastWhole
          if si = 3 then m = lastWhole
      end select
    end if
    getSegStart = segEnd + 2
  next si

  if len(fracPart) > 0 then
    for i = 1 to len(fracPart)
      dim ch2 as Integer = asc(mid(fracPart, i, 1))
      if ch2 < CHAR_DIGIT_0 orelse ch2 > CHAR_DIGIT_9 then
        SetTimeLiteralInvalidSegmentError()
        return FALSE
      end if
    next i
  end if

  dim secMs as LongInt = SecondsFieldToMsRounded(lastWhole, fracPart)
  dim t as Double
  select case segCount
    case 2
      t = CDbl(m) * 60000.0 + CDbl(secMs)
    case 3
      t = (CDbl(h) * 3600.0 + CDbl(m) * 60.0) * 1000.0 + CDbl(secMs)
    case 4
      t = ((CDbl(d) * 24.0 + CDbl(h)) * 3600.0 + CDbl(m) * 60.0) * 1000.0 + CDbl(secMs)
    case else
      SetTimeLiteralInvalidSegmentError()
      return FALSE
  end select
  if IsNonFiniteValue(t) then
    SetTimeLiteralInvalidSegmentError()
    return FALSE
  end if
  if t < CDbl(FB_I64_MIN) orelse t > CDbl(FB_I64_MAX) then
    SetTimeLiteralInvalidSegmentError()
    return FALSE
  end if
  outMs = RoundHalfUpDoubleToLongInt(t)
  return TRUE
end function

private function TryProductCoeffUnitMs(byval coeff as LongInt, byval factor as LongInt, byref outDelta as LongInt) as Boolean
  if coeff = 0 orelse factor = 0 then
    outDelta = 0
    return TRUE
  end if
  if coeff > (FB_I64_MAX \ factor) then return FALSE
  outDelta = coeff * factor
  return TRUE
end function

const NLK_PLAIN as Integer = 0
const NLK_COLON_TIME as Integer = 1
const NLK_COMPACT_TIME as Integer = 2

private function IsDecimalRadixPrefixedAt(byval p as ZString ptr) as Boolean
  if p[0] <> CHAR_DIGIT_0 then return FALSE
  dim c as UByte = p[1]
  if c = CHAR_LC_X orelse c = CHAR_X orelse c = CHAR_LC_B orelse c = CHAR_B orelse c = CHAR_LC_O orelse c = CHAR_O then return TRUE
  return FALSE
end function

private function ScanColonTimeLiteralEnd(byval p0 as ZString ptr, byref outEnd as ZString ptr) as Boolean
  if p0[0] < CHAR_DIGIT_0 orelse p0[0] > CHAR_DIGIT_9 then return FALSE
  if IsDecimalRadixPrefixedAt(p0) then return FALSE
  dim q as ZString ptr = p0
  dim hasColon as Boolean = FALSE
  while (q[0] >= CHAR_DIGIT_0 andalso q[0] <= CHAR_DIGIT_9) orelse q[0] = CHAR_COLON orelse q[0] = CHAR_DOT
    if q[0] = CHAR_COLON then hasColon = TRUE
    q += 1
  wend
  if hasColon = FALSE then return FALSE
  outEnd = q
  return TRUE
end function

private function PeekCompactTimeSuffixAfterDigitRun(byval digitEnd as ZString ptr) as Boolean
  dim r as ZString ptr = digitEnd
  while r[0] = CHAR_SPACE orelse r[0] = CHAR_TAB
    r += 1
  wend
  if r[0] = CHAR_LC_M andalso r[1] = CHAR_LC_S then return TRUE
  if r[0] = CHAR_LC_D orelse r[0] = CHAR_LC_H orelse r[0] = CHAR_LC_S then return TRUE
  if r[0] = CHAR_LC_M then return TRUE
  return FALSE
end function

' Peek-only: route decimal digit runs to numeric vs colon-time vs compact-suffix-time parsers.
private function ClassifyNumericLiteralAtCursor() as Integer
  if pStream[0] < CHAR_DIGIT_0 orelse pStream[0] > CHAR_DIGIT_9 then return NLK_PLAIN
  if IsDecimalRadixPrefixedAt(pStream) then return NLK_PLAIN
  dim q as ZString ptr = pStream
  while q[0] >= CHAR_DIGIT_0 andalso q[0] <= CHAR_DIGIT_9
    q += 1
  wend
  if q[0] = CHAR_DOT then
    q += 1
    while q[0] >= CHAR_DIGIT_0 andalso q[0] <= CHAR_DIGIT_9
      q += 1
    wend
  end if
  if q[0] = CHAR_LC_E orelse q[0] = CHAR_E then
    q += 1
    if q[0] = CHAR_PLUS orelse q[0] = CHAR_MINUS then q += 1
    while q[0] >= CHAR_DIGIT_0 andalso q[0] <= CHAR_DIGIT_9
      q += 1
    wend
  end if
  if q[0] <> CHAR_COLON then
    dim digitEnd as ZString ptr = pStream
    while digitEnd[0] >= CHAR_DIGIT_0 andalso digitEnd[0] <= CHAR_DIGIT_9
      digitEnd += 1
    wend
    if digitEnd[0] = CHAR_LC_E orelse digitEnd[0] = CHAR_E then return NLK_PLAIN
    if PeekCompactTimeSuffixAfterDigitRun(digitEnd) then return NLK_COMPACT_TIME
    return NLK_PLAIN
  end if
  '' Inside ``[...]``, top-level ``:`` is slice syntax, not a time literal (``a[1:30]``).
  if arrayIndexBracketDepth > 0 then return NLK_PLAIN
  dim colonEnd as ZString ptr = 0
  if ScanColonTimeLiteralEnd(pStream, colonEnd) then return NLK_COLON_TIME
  return NLK_PLAIN
end function

private function TryParseCompactSuffixTimeLiteral(byref outV as EvalValue) as Boolean
  if Parser_SupportTimeValues = FALSE then return FALSE
  dim pSave as ZString ptr = pStream
  if pStream[0] < CHAR_DIGIT_0 orelse pStream[0] > CHAR_DIGIT_9 then return FALSE
  if IsDecimalRadixPrefixedAt(pStream) then return FALSE
  dim totalMs as LongInt = 0
  dim lastUnitRank as Integer = -1
  dim comps as Integer = 0
  do
    if pStream[0] < CHAR_DIGIT_0 orelse pStream[0] > CHAR_DIGIT_9 then exit do
    dim uv as ULongInt = 0
    while pStream[0] >= CHAR_DIGIT_0 andalso pStream[0] <= CHAR_DIGIT_9
      dim dg as Integer = pStream[0] - CHAR_DIGIT_0
      if TryMult10OnceChecked(uv, uv) = FALSE then
        pStream = pSave
        if comps > 0 then SetTimeLiteralInvalidSegmentError()
        return FALSE
      end if
      if TryAddULongChecked(uv, CULngInt(dg), uv) = FALSE then
        pStream = pSave
        if comps > 0 then SetTimeLiteralInvalidSegmentError()
        return FALSE
      end if
      pStream += 1
    wend
    SkipSpaces()
    dim ur as Integer = -1
    dim fac as LongInt = 0
    if pStream[0] = CHAR_LC_M andalso pStream[1] = CHAR_LC_S then
      ur = 4
      fac = 1
      pStream += 2
    elseif pStream[0] = CHAR_LC_D then
      ur = 0
      fac = 86400000
      pStream += 1
    elseif pStream[0] = CHAR_LC_H then
      ur = 1
      fac = 3600000
      pStream += 1
    elseif pStream[0] = CHAR_LC_M then
      ur = 2
      fac = 60000
      pStream += 1
    elseif pStream[0] = CHAR_LC_S then
      ur = 3
      fac = 1000
      pStream += 1
    else
      if comps = 0 then
        pStream = pSave
        return FALSE
      end if
      pStream = pSave
      SetParseError(FB_STR_TIME_COMPACT_EXPECTED_UNIT)
      return FALSE
    end if
    if ur <= lastUnitRank then
      pStream = pSave
      SetParseError(FB_STR_TIME_COMPACT_UNIT_ORDER)
      return FALSE
    end if
    lastUnitRank = ur
    if uv > FB_I64_MAX_U then
      pStream = pSave
      SetTimeLiteralInvalidSegmentError()
      return FALSE
    end if
    dim cf as LongInt = CLngInt(uv)
    dim dlt as LongInt
    if TryProductCoeffUnitMs(cf, fac, dlt) = FALSE then
      pStream = pSave
      SetTimeLiteralInvalidSegmentError()
      return FALSE
    end if
    if TryAddTimeMsChecked(totalMs, dlt, totalMs) = FALSE then
      pStream = pSave
      SetTimeLiteralInvalidSegmentError()
      return FALSE
    end if
    comps += 1
    SkipSpaces()
  loop while (pStream[0] >= CHAR_DIGIT_0 andalso pStream[0] <= CHAR_DIGIT_9)
  if comps <= 0 then
    pStream = pSave
    return FALSE
  end if
  SkipSpaces()
  dim c2 as UByte = pStream[0]
  if c2 >= CHAR_LC_A andalso c2 <= CHAR_LC_Z then
    dim kwOk as Boolean = PeekMatchKeywordOperatorNoConsume(OpName(OP_AND)) orelse _
      PeekMatchKeywordOperatorNoConsume(OpName(OP_OR)) orelse _
      PeekMatchKeywordOperatorNoConsume(OpName(OP_NOT))
    if kwOk = FALSE then
      pStream = pSave
      SetParseError(FB_STR_TIME_COMPACT_INVALID_SUFFIX)
      return FALSE
    end if
  end if
  ValueSetTimeMs(outV, totalMs)
  return TRUE
end function

private function TryParseScalarTimeLiteral(byref outV as EvalValue) as Boolean
  if Parser_SupportTimeValues = FALSE then return FALSE
  if arrayIndexBracketDepth > 0 then return FALSE
  dim p0 as ZString ptr = pStream
  dim q as ZString ptr = 0
  if ScanColonTimeLiteralEnd(p0, q) = FALSE then return FALSE
  dim litLen as Integer = CInt(q - p0)
  if litLen <= 0 then return FALSE
  dim lit as String = left(*p0, litLen)
  dim ms as LongInt = 0
  if ParseTimeLiteralStringToMs(lit, ms) = FALSE then
    return FALSE
  end if
  pStream = q
  ValueSetTimeMs(outV, ms)
  return TRUE
end function

private function ScalarToSecondsMsForTimeOp(byref sv as ScalarValue, byref outMs as LongInt) as Boolean
  if ScalarIsTime(sv) then
    outMs = TimeTotalMsFromScalarValue(sv)
    return TRUE
  end if
  if IsNonFiniteValue(sv.scalar) then return FALSE
  outMs = RoundHalfUpDoubleToLongInt(sv.scalar * 1000.0)
  return TRUE
end function

private sub SetRecursiveUserFunctionCallError(byref fnName as String)
  SetParseError(FB_STR_RECURSIVE_USER_FUNCTION_CALL_COLON & fnName)
end sub

private sub SetArrayElementMustBeScalarError()
  SetParseError(FB_STR_ARRAY_ELEMENT_MUST_BE_SCALAR)
end sub

private sub SetInvalidPrefixedLiteralError(byval prefixChar as UByte)
  select case prefixChar
    case CHAR_LC_X, CHAR_X
      SetParseErrorById(PARSE_ERR_INVALID_HEX_LITERAL)
    case CHAR_LC_B, CHAR_B
      SetParseErrorById(PARSE_ERR_INVALID_BINARY_LITERAL)
    case CHAR_LC_O, CHAR_O
      SetParseErrorById(PARSE_ERR_INVALID_OCTAL_LITERAL)
  end select
end sub

private sub SetMissingOpeningBracketError()
  SetParseError(FB_STR_MISSING_OPENING_BRACKET)
end sub

private sub SetExpressionTooLongError()
  SetParseError(FB_STR_EXPRESSION_IS_TOO_LONG)
end sub

private sub SetEmptyStatementError()
  SetParseError(FB_STR_EMPTY_STATEMENT)
end sub

private sub SetFunctionBodyIsEmptyError()
  SetParseError(FB_STR_FUNCTION_BODY_IS_EMPTY)
end sub

private function InlineLambdaBodyIsEffectivelyEmpty(byref body as string) as Boolean
  return (len(trim(body)) = 0) orelse UdfBodyIsEmptyTupleLiteral(body)
end function

private sub SetValidationError(byref errText as String)
  SetParseError(errText)
end sub

private function TryValidateAssignmentTargetName(byref varName as String, byref errText as String) as Boolean
  return TryValidateIdentifierIsNotReserved(varName, errText)
end function

private function TryGetArrayIndexIntFromEvalValue(byref idxValue as EvalValue, byref outIdx as LongInt) as Boolean
  if idxValue.kind <> VK_SCALAR then
    SetParseErrorById(PARSE_ERR_ARRAY_INDEX_MUST_BE_SCALAR)
    return FALSE
  end if
  dim sv as ScalarValue = idxValue.scalarValue
  ScalarRepairExactMetadata(sv)
  if ScalarHasNonzeroImaginaryPart(sv) then
    SetParseErrorById(PARSE_ERR_ARRAY_INDEX_MUST_BE_INTEGER)
    return FALSE
  end if
  select case sv.scalarStorageKind
  case SSK_INT64
    outIdx = sv.exactInt64
    return TRUE
  case SSK_UINT64
    if sv.exactUInt64 > FB_I64_MAX_U then
      SetParseErrorById(PARSE_ERR_ARRAY_INDEX_MUST_BE_INTEGER)
      return FALSE
    end if
    outIdx = CLngInt(sv.exactUInt64)
    return TRUE
  case else
    SetParseErrorById(PARSE_ERR_ARRAY_INDEX_MUST_BE_INTEGER)
    return FALSE
  end select
end function

private sub SetMissingClosingBracketAfterIndexError()
  if pStream[0] = CHAR_RPAREN then
    SetParseErrorById(PARSE_ERR_MISMATCHED_CLOSING_PARENTHESIS)
  elseif pStream[0] = CHAR_RBRACE then
    SetParseErrorById(PARSE_ERR_MISMATCHED_CLOSING_BRACE)
  else
    SetParseErrorById(PARSE_ERR_MISSING_CLOSING_BRACKET)
  end if
end sub

' CPython slice.indices(length) normalization for start/stop/step.
private sub NormalizePythonSliceBounds( _
  byval length as LongInt, _
  byval hasStart as Boolean, byval startIn as LongInt, _
  byval hasStop as Boolean, byval stopIn as LongInt, _
  byval stepIn as LongInt, _
  byref outStart as LongInt, byref outStop as LongInt _
)
  dim stepNeg as Boolean = (stepIn < 0)
  dim startIdx as LongInt
  dim stopIdx as LongInt
  if hasStart = FALSE then
    if stepNeg then startIdx = length - 1 else startIdx = 0
  else
    startIdx = startIn
    if startIdx < 0 then startIdx += length
    if startIdx < 0 then
      if stepNeg then startIdx = -1 else startIdx = 0
    elseif startIdx >= length then
      if stepNeg then startIdx = length - 1 else startIdx = length
    end if
  end if
  if hasStop = FALSE then
    if stepNeg then stopIdx = -1 else stopIdx = length
  else
    stopIdx = stopIn
    if stopIdx < 0 then stopIdx += length
    if stopIdx < 0 then
      if stepNeg then stopIdx = -1 else stopIdx = 0
    elseif stopIdx >= length then
      if stepNeg then stopIdx = length - 1 else stopIdx = length
    end if
  end if
  outStart = startIdx
  outStop = stopIdx
end sub

private function EstimateSliceItemCount(byval startV as LongInt, byval stopV as LongInt, byval stepV as LongInt) as LongInt
  if stepV > 0 then
    if startV >= stopV then return 0
    return (stopV - startV + stepV - 1) \ stepV
  end if
  if startV <= stopV then return 0
  return (startV - stopV - stepV - 1) \ (-stepV)
end function

private function TryApplyArrayIndex(byref baseValue as EvalValue, byref idxValue as EvalValue, byref outValue as EvalValue) as Boolean
#ifdef __FB_FUNC_VARS_OVERRIDE_GLOBALS__
  if functionVariableCount > 0 andalso baseValue.kind = VK_SCALAR then
    '' UDF body syntax validation: formal parameters are scalar probes; bounds checked at call time.
    dim probeIdx as Integer = FindVariableIndex(FB_STR_FORMAL_VALIDATION_PROBE)
    if probeIdx >= 0 andalso variables(probeIdx).value.kind = VK_SCALAR then
      outValue = variables(probeIdx).value
    else
      ValueSetInt64(outValue, 1)
    end if
    return TRUE
  end if
#endif

  dim idxInt as LongInt
  if TryGetArrayIndexIntFromEvalValue(idxValue, idxInt) = FALSE then return FALSE

  if baseValue.kind <> VK_ARRAY then
    SetParseErrorById(PARSE_ERR_INDEXING_REQUIRES_ARRAY)
    return FALSE
  end if

  dim arrLen as Integer = ValueArrayLen(baseValue)
  dim resolved as LongInt = idxInt
  if resolved < 0 then resolved = CLngInt(arrLen) + resolved
  if resolved < 0 orelse resolved >= arrLen then
    SetParseErrorById(PARSE_ERR_ARRAY_INDEX_OUT_OF_RANGE)
    return FALSE
  end if

  dim rawIdx as Integer = lbound(baseValue.arr) + CInt(resolved)
  ValueGetArrayElemAsScalar(baseValue, rawIdx, outValue)
  return TRUE
end function

private function TryApplyArraySlice( _
  byref baseValue as EvalValue, _
  byval hasStart as Boolean, byref startValue as EvalValue, _
  byval hasStop as Boolean, byref stopValue as EvalValue, _
  byval hasStep as Boolean, byref stepValue as EvalValue, _
  byref outValue as EvalValue _
) as Boolean
#ifdef __FB_FUNC_VARS_OVERRIDE_GLOBALS__
  if functionVariableCount > 0 andalso baseValue.kind = VK_SCALAR then
    '' UDF body validation: return a 1-element probe array so chained indexing still parses.
    dim probe as EvalValue
    dim probeIdx as Integer = FindVariableIndex(FB_STR_FORMAL_VALIDATION_PROBE)
    if probeIdx >= 0 andalso variables(probeIdx).value.kind = VK_SCALAR then
      probe = variables(probeIdx).value
    else
      ValueSetInt64(probe, 1)
    end if
    dim probeVals(0 to 0) as ScalarValue
    probeVals(0) = ScalarValueFromEvalScalar(probe)
    ValueSetArrayFromScalarValues(outValue, probeVals())
    return TRUE
  end if
#endif

  dim startIdx as LongInt = 0
  dim stopIdx as LongInt = 0
  dim stepIdx as LongInt = 1
  if hasStart then
    if TryGetArrayIndexIntFromEvalValue(startValue, startIdx) = FALSE then return FALSE
  end if
  if hasStop then
    if TryGetArrayIndexIntFromEvalValue(stopValue, stopIdx) = FALSE then return FALSE
  end if
  if hasStep then
    if TryGetArrayIndexIntFromEvalValue(stepValue, stepIdx) = FALSE then return FALSE
  end if
  if stepIdx = 0 then
    SetParseError(FB_STR_SLICE_STEP_MUST_NOT_BE_ZERO)
    return FALSE
  end if

  if baseValue.kind <> VK_ARRAY then
    SetParseErrorById(PARSE_ERR_INDEXING_REQUIRES_ARRAY)
    return FALSE
  end if

  dim arrLen as LongInt = CLngInt(ValueArrayLen(baseValue))
  dim normStart as LongInt
  dim normStop as LongInt
  NormalizePythonSliceBounds(arrLen, hasStart, startIdx, hasStop, stopIdx, stepIdx, normStart, normStop)
  dim outCount as LongInt = EstimateSliceItemCount(normStart, normStop, stepIdx)
  if outCount <= 0 then
    ValueInitArrayLike(outValue, 0, -1)
    return TRUE
  end if

  dim vals() as ScalarValue
  redim vals(0 to CInt(outCount) - 1)
  dim i as Integer
  dim curIdx as LongInt = normStart
  dim lb as Integer = lbound(baseValue.arr)
  for i = 0 to CInt(outCount) - 1
    vals(i) = baseValue.arr(lb + CInt(curIdx))
    curIdx += stepIdx
  next i
  ValueSetArrayFromScalarValues(outValue, vals())
  return TRUE
end function

private function TryParseArrayIndex(byref baseValue as EvalValue, byref outValue as EvalValue) as Boolean
  outValue = baseValue
  SkipSpaces()
  if pStream[0] <> CHAR_LBRACKET then return TRUE

  pStream += 1
  arrayIndexBracketDepth += 1
  SkipSpaces()
  if pStream[0] = CHAR_RBRACKET then
    arrayIndexBracketDepth -= 1
    SetParseErrorById(PARSE_ERR_MISSING_INDEX)
    return FALSE
  end if

  dim hasStart as Boolean = FALSE
  dim hasStop as Boolean = FALSE
  dim hasStep as Boolean = FALSE
  dim startValue as EvalValue
  dim stopValue as EvalValue
  dim stepValue as EvalValue

  if pStream[0] = CHAR_COLON then
    hasStart = FALSE
    pStream += 1
  else
    startValue = ParseExpression()
    if parseError then
      arrayIndexBracketDepth -= 1
      return FALSE
    end if
    hasStart = TRUE
    SkipSpaces()
    if pStream[0] = CHAR_COLON then
      pStream += 1
    elseif pStream[0] = CHAR_RBRACKET then
      pStream += 1
      arrayIndexBracketDepth -= 1
      return TryApplyArrayIndex(baseValue, startValue, outValue)
    else
      arrayIndexBracketDepth -= 1
      SetMissingClosingBracketAfterIndexError()
      return FALSE
    end if
  end if

  '' Slice form: ``[start:stop:step]`` with any bound omitted (Python-compatible).
  SkipSpaces()
  if pStream[0] = CHAR_RBRACKET then
    hasStop = FALSE
    hasStep = FALSE
  elseif pStream[0] = CHAR_COLON then
    hasStop = FALSE
    pStream += 1
    SkipSpaces()
    if pStream[0] = CHAR_RBRACKET then
      hasStep = FALSE
    else
      stepValue = ParseExpression()
      if parseError then
        arrayIndexBracketDepth -= 1
        return FALSE
      end if
      hasStep = TRUE
      SkipSpaces()
      if pStream[0] <> CHAR_RBRACKET then
        arrayIndexBracketDepth -= 1
        SetMissingClosingBracketAfterIndexError()
        return FALSE
      end if
    end if
  else
    stopValue = ParseExpression()
    if parseError then
      arrayIndexBracketDepth -= 1
      return FALSE
    end if
    hasStop = TRUE
    SkipSpaces()
    if pStream[0] = CHAR_COLON then
      pStream += 1
      SkipSpaces()
      if pStream[0] = CHAR_RBRACKET then
        hasStep = FALSE
      else
        stepValue = ParseExpression()
        if parseError then
          arrayIndexBracketDepth -= 1
          return FALSE
        end if
        hasStep = TRUE
        SkipSpaces()
        if pStream[0] <> CHAR_RBRACKET then
          arrayIndexBracketDepth -= 1
          SetMissingClosingBracketAfterIndexError()
          return FALSE
        end if
      end if
    elseif pStream[0] = CHAR_RBRACKET then
      hasStep = FALSE
    else
      arrayIndexBracketDepth -= 1
      SetMissingClosingBracketAfterIndexError()
      return FALSE
    end if
  end if

  pStream += 1
  arrayIndexBracketDepth -= 1
  return TryApplyArraySlice(baseValue, hasStart, startValue, hasStop, stopValue, hasStep, stepValue, outValue)
end function

private function EvaluateUserFunction(byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  dim idx as Integer = FindFunctionIndex(fnName)
  if idx < 0 then return FALSE

  dim pCount as Integer = 0
  if ubound(userFunctions(idx).params) >= lbound(userFunctions(idx).params) then
    pCount = ubound(userFunctions(idx).params) - lbound(userFunctions(idx).params) + 1
  end if
  dim aCount as Integer = 0
  if ubound(args) >= lbound(args) then
    aCount = ubound(args) - lbound(args) + 1
  end if
  if pCount <> aCount then
    SetExactArgCountError(fnName, pCount, aCount)
    return TRUE
  end if

  dim lowNm as String = lcase(fnName)
  dim si as Integer
  for si = 0 to udfCallStackSp - 1
    if udfCallStack(si) = lowNm then
      SetRecursiveUserFunctionCallError(fnName)
      return TRUE
    end if
  next si
  if udfCallStackSp >= UDF_CALL_STACK_MAX then
    SetParseErrorById(PARSE_ERR_USER_FUNCTION_CALL_STACK_OVERFLOW)
    return TRUE
  end if
  udfCallStack(udfCallStackSp) = lowNm
  udfCallStackSp += 1

  dim oldExists() as Integer
  dim oldValues() as EvalValue
  if pCount > 0 then
    redim oldExists(0 to pCount - 1)
    redim oldValues(0 to pCount - 1)
  end if

  dim i as Integer
  for i = 0 to pCount - 1
    dim pName as String = userFunctions(idx).params(i)
    dim vIdx as Integer = FindVariableIndex(pName)
    if vIdx >= 0 then
      oldExists(i) = 1
      oldValues(i) = variables(vIdx).value
    else
      oldExists(i) = 0
    end if
    SetVariable(pName, args(i))
  next i

  dim savedStream as ZString ptr = pStream
  dim savedParseError as Integer = parseError
  dim savedWasPercentage as Boolean = wasPercentage
  dim savedExprStart as ZString ptr = exprStart
  dim savedBaseCol as Integer = errorBaseCol
  dim body as String = userFunctions(idx).expr
  pStream = strptr(body)
  exprStart = pStream
  errorBaseCol = 1
  parseError = 0
  outV = ParseExpression()
  SkipSpaces()
  if pStream[0] <> CHAR_NUL then SetParseErrorById(PARSE_ERR_UNEXPECTED_INPUT)
  dim evalError as Integer = parseError

  pStream = savedStream
  exprStart = savedExprStart
  errorBaseCol = savedBaseCol
  parseError = savedParseError
  wasPercentage = savedWasPercentage

  for i = 0 to pCount - 1
    dim pName as String = userFunctions(idx).params(i)
    if oldExists(i) = 1 then
      SetVariable(pName, oldValues(i))
    else
      dim vIdx as Integer = FindVariableIndex(pName)
      if vIdx >= 0 then RemoveVariableAtIndex(vIdx)
    end if
  next i

  udfCallStackSp -= 1

  if evalError <> 0 then parseError = 1
  return TRUE
end function

private function EvaluateInlineLambda(fnParams() as string, byref lambdaBodyTxt as string, args() as EvalValue, byref outV as EvalValue) as Boolean
  dim pCount as Integer = 0
  if ubound(fnParams) >= lbound(fnParams) then pCount = ubound(fnParams) - lbound(fnParams) + 1
  dim aCount as Integer = 0
  if ubound(args) >= lbound(args) then aCount = ubound(args) - lbound(args) + 1
  dim lamErrName as string = "lambda"
  if pCount <> aCount then
    SetExactArgCountError(lamErrName, pCount, aCount)
    return TRUE
  end if
  if InlineLambdaBodyIsEffectivelyEmpty(lambdaBodyTxt) then
    SetFunctionBodyIsEmptyError()
    return TRUE
  end if

  dim oldExists() as Integer
  dim oldValues() as EvalValue
  if pCount > 0 then
    redim oldExists(0 to pCount - 1)
    redim oldValues(0 to pCount - 1)
  end if

  dim i as Integer
  for i = 0 to pCount - 1
    dim pName as String = fnParams(lbound(fnParams) + i)
    dim vIdx as Integer = FindVariableIndex(pName)
    if vIdx >= 0 then
      oldExists(i) = 1
      oldValues(i) = variables(vIdx).value
    else
      oldExists(i) = 0
    end if
    SetVariable(pName, args(lbound(args) + i))
  next i

  dim savedStream as ZString ptr = pStream
  dim savedParseError as Integer = parseError
  dim savedWasPercentage as Boolean = wasPercentage
  dim savedExprStart as ZString ptr = exprStart
  dim savedBaseCol as Integer = errorBaseCol
  dim body as String = lambdaBodyTxt
  pStream = StrPtr(body)
  exprStart = pStream
  errorBaseCol = 1
  parseError = 0
  suppressBareFunctionTailHint = TRUE
  outV = ParseExpression()
  suppressBareFunctionTailHint = FALSE
  SkipSpaces()
  if pStream[0] <> CHAR_NUL then SetParseErrorById(PARSE_ERR_UNEXPECTED_INPUT)
  dim evalError as Integer = parseError
  if evalError <> 0 then
    sortbyLambdaEvalBodyErrorCol = CurrentParseErrorColumn()
  else
    sortbyLambdaEvalBodyErrorCol = 0
  end if

  pStream = savedStream
  exprStart = savedExprStart
  errorBaseCol = savedBaseCol
  parseError = savedParseError
  wasPercentage = savedWasPercentage

  for i = 0 to pCount - 1
    dim pNameRestore as String = fnParams(lbound(fnParams) + i)
    if oldExists(i) = 1 then
      SetVariable(pNameRestore, oldValues(i))
    else
      dim vx as Integer = FindVariableIndex(pNameRestore)
      if vx >= 0 then RemoveVariableAtIndex(vx)
    end if
  next i

  if evalError <> 0 then parseError = 1
  return TRUE
end function

private function ClampScalarValue(byref sv as ScalarValue, byref minSv as ScalarValue, byref maxSv as ScalarValue) as ScalarValue
  dim v as Double = ScalarNumericReal(sv)
  dim minS as Double = minSv.scalar
  dim maxS as Double = maxSv.scalar

  if IsNaNValue(v) then
    if IsNaNValue(minS) = FALSE then return minSv
    return sv
  end if

  if (IsNaNValue(minS) = FALSE) andalso v <= minS then return minSv
  if (IsNaNValue(maxS) = FALSE) andalso v > maxS then return maxSv
  if IsNaNValue(maxS) andalso (IsNaNValue(minS) = FALSE) andalso v > minS then
    dim nanOut as EvalValue
    ValueSetScalar(nanOut, MakeNaN())
    return nanOut.scalarValue
  end if
  return sv
end function

private function ApplyClampScalar(byref sv as ScalarValue, byref minSv as ScalarValue, byref maxSv as ScalarValue, byref outV as EvalValue) as Boolean
  dim resultSv as ScalarValue = ClampScalarValue(sv, minSv, maxSv)
  EvalScalarFromScalarValue(resultSv, outV)
  return TRUE
end function

private function MapClampOverValue(byref valueV as EvalValue, byref minSv as ScalarValue, byref maxSv as ScalarValue, byref outV as EvalValue) as Boolean
  if valueV.kind = VK_SCALAR then
    return ApplyClampScalar(valueV.scalarValue, minSv, maxSv, outV)
  end if
  if ubound(valueV.arr) < lbound(valueV.arr) then
    parseError = 1
    return FALSE
  end if
  ValueInitArrayLike(outV, lbound(valueV.arr), ubound(valueV.arr))
  dim i as Integer
  for i = lbound(valueV.arr) to ubound(valueV.arr)
    dim r as EvalValue
    if ApplyClampScalar(valueV.arr(i), minSv, maxSv, r) = FALSE then return FALSE
    ValueSetArrayElemFromScalar(outV, i, r)
  next i
  return TRUE
end function

private function ApplyClamp(byref valueV as EvalValue, byref minV as EvalValue, byref maxV as EvalValue, byref outV as EvalValue) as Boolean
  if Parser_SupportComplexNumbers then
    if EvalValueHasNonzeroImaginary(valueV) orelse EvalValueHasNonzeroImaginary(minV) orelse EvalValueHasNonzeroImaginary(maxV) then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return FALSE
    end if
  end if
  if minV.kind <> VK_SCALAR orelse maxV.kind <> VK_SCALAR then return FALSE
  return MapClampOverValue(valueV, minV.scalarValue, maxV.scalarValue, outV)
end function

private function GcdULong(byval a as ULongInt, byval b as ULongInt) as ULongInt
  dim x as ULongInt = a
  dim y as ULongInt = b
  while y <> 0ull
    dim t as ULongInt = x mod y
    x = y
    y = t
  wend
  return x
end function

private function GcdInt64(byval a as LongInt, byval b as LongInt) as LongInt
  return CLngInt(GcdULong(CULngInt(abs(a)), CULngInt(abs(b))))
end function

private sub ScalarClearCartesianRenderExact(byref sv as ScalarValue)
  sv.flags = sv.flags and not (SVF_RENDER_RATIONAL or SVF_IMAG_RENDER_RATIONAL)
  ScalarSetExactUInt64Valid(sv, FALSE)
  ScalarSetImagExactUInt64Valid(sv, FALSE)
end sub

private sub ScalarApplyExactInt64Part(byref sv as ScalarValue, byval imagPart as Boolean, byval n as LongInt)
  if imagPart then
    sv.imagExactInt64 = n
    ScalarSetImagExactInt64Valid(sv, TRUE)
    ScalarSetImagExactUInt64Valid(sv, FALSE)
    sv.flags = sv.flags and not SVF_IMAG_RENDER_RATIONAL
  else
    sv.exactInt64 = n
    ScalarSetExactInt64Valid(sv, TRUE)
    ScalarSetExactUInt64Valid(sv, FALSE)
    sv.flags = sv.flags and not SVF_RENDER_RATIONAL
  end if
end sub

private sub ScalarApplyReducedRationalPart(byref sv as ScalarValue, byval imagPart as Boolean, byval num as LongInt, byval den as ULongInt)
  dim n as LongInt = num
  dim d as ULongInt = den
  dim g as LongInt = GcdInt64(abs(n), CLngInt(d))
  if g > 0 then
    n = n \ g
    d = CULngInt(CLngInt(d) \ g)
  end if
  if imagPart then
    sv.imagExactInt64 = n
    ScalarSetImagExactInt64Valid(sv, TRUE)
    if d = 1ull then
      ScalarSetImagExactUInt64Valid(sv, FALSE)
      sv.flags = sv.flags and not SVF_IMAG_RENDER_RATIONAL
    else
      sv.imagExactUInt64 = d
      ScalarSetImagExactUInt64Valid(sv, TRUE)
      sv.flags = sv.flags or SVF_IMAG_RENDER_RATIONAL
    end if
  else
    sv.exactInt64 = n
    ScalarSetExactInt64Valid(sv, TRUE)
    if d = 1ull then
      ScalarSetExactUInt64Valid(sv, FALSE)
      sv.flags = sv.flags and not SVF_RENDER_RATIONAL
    else
      sv.exactUInt64 = d
      ScalarSetExactUInt64Valid(sv, TRUE)
      sv.flags = sv.flags or SVF_RENDER_RATIONAL
    end if
  end if
end sub

private sub RawCartesianAssignReducedRational(byval num as LongInt, byval den as ULongInt, byref outC as RawCartesianScalar)
  dim n as LongInt = num
  dim d as ULongInt = den
  dim g as LongInt = GcdInt64(abs(n), CLngInt(d))
  if g > 0 then
    n = n \ g
    d = CULngInt(CLngInt(d) \ g)
  end if
  if d = 1ull then
    outC.kind = RSK_INT64
    outC.intValue = n
  else
    outC.kind = RSK_RATIONAL
    outC.ratNum = n
    outC.ratDen = d
  end if
end sub


private function TryLcmULong(byval a as ULongInt, byval b as ULongInt, byref outL as ULongInt) as Boolean
  if a = 0ull orelse b = 0ull then
    outL = 0ull
    return TRUE
  end if
  dim g as ULongInt = GcdULong(a, b)
  dim a1 as ULongInt = a \ g
  if a1 > (FB_U64_MAX \ b) then return FALSE
  outL = a1 * b
  return TRUE
end function

private function TryGetExactNonNegativeUInt64Pair(byref aV as EvalValue, byref bV as EvalValue, byref aU as ULongInt, byref bU as ULongInt) as Boolean
  if aV.kind <> VK_SCALAR orelse bV.kind <> VK_SCALAR then return FALSE
  return TryGetExactNonNegativeUInt64Scalar(aV.scalarValue, aU) andalso TryGetExactNonNegativeUInt64Scalar(bV.scalarValue, bU)
end function

private function TryGetScalarInt64Pair(byref aV as EvalValue, byref bV as EvalValue, byref a as LongInt, byref b as LongInt) as Boolean
  if aV.kind <> VK_SCALAR orelse bV.kind <> VK_SCALAR then return FALSE
  if TryGetExactInt64(aV, a) = FALSE then return FALSE
  if TryGetExactInt64(bV, b) = FALSE then return FALSE
  return TRUE
end function

'' Returns 0 = ok, 1 = operands not exact integers, 2 = lcm overflow (uint64)
private function TryApplyGcdLcmScalarPair(byref aV as EvalValue, byref bV as EvalValue, byval doLcm as Boolean, byref outV as EvalValue) as Integer
  dim aU as ULongInt, bU as ULongInt
  if TryGetExactNonNegativeUInt64Pair(aV, bV, aU, bU) then
    dim gU as ULongInt = GcdULong(aU, bU)
    if doLcm = FALSE then
      ValueSetUInt64(outV, gU)
      return 0
    end if
    dim lU as ULongInt
    if TryLcmULong(aU, bU, lU) = FALSE then return 2
    ValueSetUInt64(outV, lU)
    return 0
  end if
  dim a as LongInt, b as LongInt
  if TryGetScalarInt64Pair(aV, bV, a, b) = FALSE then return 1
  dim g as LongInt = GcdInt64(a, b)
  if doLcm = FALSE then
    ValueSetInt64(outV, g)
    return 0
  end if
  if g = 0 then
    ValueSetInt64(outV, 0)
    return 0
  end if
  dim q as LongInt = a \ g
  dim l as LongInt
  if TryMulInt64(q, b, l) = FALSE then return 2
  if l < 0 then
    if l = FB_I64_MIN then return 2
    l = -l
  end if
  ValueSetInt64(outV, l)
  return 0
end function

private function TryApplyNcrNpr(byref nV as EvalValue, byref rV as EvalValue, byval doPerm as Boolean, byref outV as EvalValue) as Boolean
  dim n as LongInt, r as LongInt
  if TryGetScalarInt64Pair(nV, rV, n, r) = FALSE then return FALSE
  if n < 0 orelse r < 0 orelse r > n then return FALSE
  if r = 0 then
    ValueSetInt64(outV, 1)
    return TRUE
  end if

  if doPerm then
    dim permAcc as LongInt = 1
    for i as LongInt = 0 to r - 1
      dim term as LongInt = n - i
      if TryMulInt64(permAcc, term, permAcc) = FALSE then return FALSE
    next i
    ValueSetInt64(outV, permAcc)
    return TRUE
  end if

  dim rEff as LongInt = r
  if (n - rEff) < rEff then rEff = (n - rEff)
  dim combAcc as LongInt = 1
  for i as LongInt = 1 to rEff
    dim num as LongInt = (n - rEff) + i
    dim den as LongInt = i
    dim g1 as LongInt = GcdInt64(num, den)
    if g1 > 1 then
      num \= g1
      den \= g1
    end if
    dim g2 as LongInt = GcdInt64(combAcc, den)
    if g2 > 1 then
      combAcc \= g2
      den \= g2
    end if
    if den <> 1 then return FALSE
    if TryMulInt64(combAcc, num, combAcc) = FALSE then return FALSE
  next i
  ValueSetInt64(outV, combAcc)
  return TRUE
end function

'' Per-pair status for gcd/lcm/ncr/npr broadcast: 0 ok, 1 integer operands, 2 numeric/domain, 3 shape mismatch.
private function ApplyIntegerBuiltinPair(byval fnId as Integer, byref aV as EvalValue, byref bV as EvalValue, byref outV as EvalValue) as Integer
  if (fnId = FUNC_GCD) orelse (fnId = FUNC_LCM) then
    return TryApplyGcdLcmScalarPair(aV, bV, (fnId = FUNC_LCM), outV)
  end if
  if TryApplyNcrNpr(aV, bV, (fnId = FUNC_NPR), outV) then return 0
  return 2
end function

private function MapBinaryEvalValueIntegerBuiltinArrayScalar(byval fnId as Integer, byref arrV as EvalValue, byref scalarV as EvalValue, byval scalarOnLeft as Boolean, byref outV as EvalValue, byref status as Integer) as Boolean
  dim i as Integer
  ValueInitArrayLike(outV, lbound(arrV.arr), ubound(arrV.arr))
  for i = lbound(arrV.arr) to ubound(arrV.arr)
    dim elem as EvalValue, r as EvalValue
    ValueGetArrayElemAsScalar(arrV, i, elem)
    if scalarOnLeft then
      status = ApplyIntegerBuiltinPair(fnId, scalarV, elem, r)
    else
      status = ApplyIntegerBuiltinPair(fnId, elem, scalarV, r)
    end if
    if status <> 0 then return FALSE
    ValueSetArrayElemFromScalar(outV, i, r)
  next i
  return TRUE
end function

private function MapBinaryEvalValueIntegerBuiltin(byval fnId as Integer, byref leftV as EvalValue, byref rightV as EvalValue, byref outV as EvalValue, byref status as Integer) as Boolean
  status = 0
  if leftV.kind = VK_SCALAR andalso rightV.kind = VK_SCALAR then
    status = ApplyIntegerBuiltinPair(fnId, leftV, rightV, outV)
    return (status = 0)
  end if
  if leftV.kind = VK_ARRAY andalso rightV.kind = VK_ARRAY then
    if ValueArrayLen(leftV) <> ValueArrayLen(rightV) then
      status = 3
      return FALSE
    end if
    dim i as Integer
    ValueInitArrayLike(outV, lbound(leftV.arr), ubound(leftV.arr))
    for i = lbound(leftV.arr) to ubound(leftV.arr)
      dim aElem as EvalValue, bElem as EvalValue, r as EvalValue
      ValueGetArrayElemAsScalar(leftV, i, aElem)
      ValueGetArrayElemAsScalar(rightV, i, bElem)
      status = ApplyIntegerBuiltinPair(fnId, aElem, bElem, r)
      if status <> 0 then return FALSE
      ValueSetArrayElemFromScalar(outV, i, r)
    next i
    return TRUE
  end if
  if leftV.kind = VK_ARRAY then
    return MapBinaryEvalValueIntegerBuiltinArrayScalar(fnId, leftV, rightV, FALSE, outV, status)
  end if
  return MapBinaryEvalValueIntegerBuiltinArrayScalar(fnId, rightV, leftV, TRUE, outV, status)
end function

private function TryApplyScalarBinaryIntegerBuiltin(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  if (fnId <> FUNC_GCD) andalso (fnId <> FUNC_LCM) andalso (fnId <> FUNC_NCR) andalso (fnId <> FUNC_NPR) then return FALSE
  if Parser_SupportComplexNumbers then
    if CallArgsInvolveComplex(args()) then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return TRUE
    end if
  end if
  dim pairStatus as Integer = 0
  if MapBinaryEvalValueIntegerBuiltin(fnId, args(0), args(1), outV, pairStatus) = FALSE then
    SetBinaryBuiltinBroadcastFailure(fnName, args(0), args(1), pairStatus)
  end if
  return TRUE
end function

'' True when x is within tolerance of N*x_mult for integer N (quotient test; avoids x-n*m cancellation on large |x|).
private function IsMultipleOf(byval x as Double, byval x_mult as Double) as Boolean
  if x_mult = 0.0 then return FALSE
  dim q as Double = x / x_mult
  if IsNonFiniteValue(q) then return FALSE
  dim n as Double = round(q)
  if abs(q - n) > 1e-9 then return FALSE
  return TRUE
end function

'' k = round(x / (pi/2)) when x is a multiple of pi/2; FALSE if not or |k| is out of trig range.
private function TryTrigHalfPiQuotient(byval x as Double, byref outK as LongInt) as Boolean
  if IsMultipleOf(x, FB_PI_VAL/2) = FALSE then return FALSE
  dim q as Double = round(x / (FB_PI_VAL/2))
  if IsNonFiniteValue(q) then return FALSE
  if abs(q) >= FB_MAX_EXACT_INT_FROM_DOUBLE then return FALSE
  outK = CLngInt(q)
  return TRUE
end function

'' k = round(x / (pi/4)) when x is a multiple of pi/4; FALSE if not or |k| is out of trig range.
private function TryTrigQuarterPiQuotient(byval x as Double, byref outK as LongInt) as Boolean
  if IsMultipleOf(x, FB_PI_VAL/4) = FALSE then return FALSE
  dim q as Double = round(x / (FB_PI_VAL/4))
  if IsNonFiniteValue(q) then return FALSE
  if abs(q) >= FB_MAX_EXACT_INT_FROM_DOUBLE then return FALSE
  outK = CLngInt(q)
  return TRUE
end function

private function CalcSin(byval x as Double) as Double
  if x = 0.0 then return 0.0
  if IsNonFiniteValue(x) then return LibSin(x)
  if IsMultipleOf(x, FB_PI_VAL) then return 0.0
  dim k as LongInt
  if TryTrigHalfPiQuotient(x, k) then
    dim r as LongInt = k mod 4
    if r < 0 then r += 4
    if r = 1 then return 1.0
    if r = 3 then return -1.0
    return 0.0
  end if
  return LibSin(x)
end function

private function CalcCos(byval x as Double) as Double
  if IsNonFiniteValue(x) then return LibCos(x)
  if IsMultipleOf(x, FB_PI_VAL) = FALSE then
    dim k as LongInt
    if TryTrigHalfPiQuotient(x, k) andalso (k mod 2) <> 0 then return 0.0
  end if
  return LibCos(x)
end function

private function CalcTan(byval x as Double) as Double
  if x = 0.0 then return 0.0
  if IsNonFiniteValue(x) then return LibTan(x)
  if IsMultipleOf(x, FB_PI_VAL) then return 0.0
  dim k as LongInt
  if TryTrigHalfPiQuotient(x, k) andalso (k mod 2) <> 0 then
    if k > 0 then return 1.0/0.0
    return -1.0/0.0
  end if
  if TryTrigQuarterPiQuotient(x, k) andalso (k mod 2) <> 0 then
    dim r as LongInt = k mod 4
    if r < 0 then r += 4
    if r = 1 then return 1.0
    if r = 3 then return -1.0
  end if
  return LibTan(x)
end function

private function CalcAtan2(byval y as Double, byval x as Double) as Double
  if x > 0 then return atn(y / x)
  if x < 0 then
    if y >= 0 then
      return atn(y / x) + FB_PI_VAL
    else
      return atn(y / x) - FB_PI_VAL
    end if
  end if
  if y > 0 then return FB_PI_VAL / 2.0
  if y < 0 then return -FB_PI_VAL / 2.0
  return 0
end function

private function CalcHypot(byval x as Double, byval y as Double) as Double
  return sqr((x * x) + (y * y))
end function

private sub CalcRoundingFnHugeAsFloat(byval fnId as Integer, byval x as Double, byref outV as EvalValue)
  '' Fix/Int are not reliable past exact LongInt range; use C floor for full double domain.
  select case fnId
  case FUNC_INT, FUNC_TRUNC
    if x >= 0 then
      ValueSetScalar(outV, floor(x))
    else
      ValueSetScalar(outV, -floor(-x))
    end if
  case FUNC_FLOOR
    ValueSetScalar(outV, floor(x))
  case FUNC_CEIL
    ValueSetScalar(outV, -floor(-x))
  case FUNC_ROUND
    if x >= 0 then
      ValueSetScalar(outV, floor(x + 0.5))
    else
      ValueSetScalar(outV, -floor(-x + 0.5))
    end if
  case else
    ValueSetScalar(outV, x)
  end select
end sub

private sub calcRoundingFn(byval fnId as Integer, byref scalarV as ScalarValue, byref outV as EvalValue)
  dim x as Double = scalarV.scalar

  if IsNonFiniteValue(x) then
    ValueSetScalar(outV, x)
  elseif scalarV.exactUInt64Valid then
    ValueSetUInt64(outV, scalarV.exactUInt64)
  elseif scalarV.exactInt64Valid then
    ValueSetInt64(outV, scalarV.exactInt64)
  elseif (x > FB_MAX_EXACT_INT_FROM_DOUBLE) orelse (x < -FB_MAX_EXACT_INT_FROM_DOUBLE) then
    dim hugeInt as LongInt
    if TryGetExactInt64FromDouble(x, hugeInt) then
      ValueSetInt64(outV, hugeInt)
    elseif (x >= 0) andalso (x < FB_2_POW_64_D) andalso (x = floor(x)) then
      dim u as ULongInt = CULngInt(floor(x))
      if CDbl(u) = x then
        ValueSetUInt64(outV, u)
      else
        CalcRoundingFnHugeAsFloat(fnId, x, outV)
      end if
    else
      CalcRoundingFnHugeAsFloat(fnId, x, outV)
    end if
  else
    dim rounded as LongInt = 0
    select case fnId
      case FUNC_INT, FUNC_TRUNC
        rounded = CLngInt(Fix(x))
      case FUNC_FLOOR
        rounded = CLngInt(Int(x))
      case FUNC_CEIL
        rounded = CLngInt(-Int(-x))
      case FUNC_ROUND
        if x >= 0 then
          rounded = CLngInt(Int(x + 0.5))
        else
          rounded = CLngInt(-Int(-x + 0.5))
        end if
    end select
    ValueSetInt64(outV, rounded)
  end if
end sub

declare sub ScalarSnapComplexNearZeroAxis(byref zr as Double, byref zi as Double)
declare sub ScalarPrincipalLnCartesian(byval ar as Double, byval ai as Double, byref outR as Double, byref outI as Double)

private function ApplyAbsScalarValue(byref scalarV as ScalarValue, byref outV as EvalValue) as Boolean
  dim x as Double = scalarV.scalar
  if IsNaNValue(x) then
    ValueSetScalar(outV, MakeNaN())
    return TRUE
  end if
  if scalarV.exactUInt64Valid andalso scalarV.exactInt64Valid = FALSE then
    ValueSetUInt64(outV, scalarV.exactUInt64)
    return TRUE
  end if
  if scalarV.exactInt64Valid then
    if scalarV.exactInt64 >= 0 then
      ValueSetInt64(outV, scalarV.exactInt64)
    elseif scalarV.exactInt64 = FB_I64_MIN then
      ValueSetUInt64(outV, FB_I64_MIN_MAG_U)
    else
      ValueSetInt64(outV, -scalarV.exactInt64)
    end if
    return TRUE
  end if
  if scalarV.exactUInt64Valid then
    ValueSetUInt64(outV, scalarV.exactUInt64)
    return TRUE
  end if
  ValueSetScalar(outV, abs(x))
  return TRUE
end function

declare sub ApplySqrtNegativeRealAsPureImagComplex(byref scalarV as ScalarValue, byref outV as EvalValue)
declare sub ApplySqrtComplexPrincipalUnary(byref inSv as ScalarValue, byref outV as EvalValue)
declare sub ApplyUnarySqrtEval(byref scalarV as ScalarValue, byref outV as EvalValue)
declare sub ApplyComplexCaretPrincipalEval(byref leftS as ScalarValue, byref rightS as ScalarValue, byref outV as EvalValue)

private function TryApplyUnaryComplexMathOverlay(byval fnId as Integer, byref scalarV as ScalarValue, byref outV as EvalValue) as Boolean
  if Parser_SupportComplexNumbers = FALSE then return FALSE
  dim arU as Double = 0.0
  dim aiU as Double = 0.0
  ScalarLoadCartesian(scalarV, arU, aiU)
  dim x as Double = arU
  if ScalarHasNonzeroImaginaryPart(scalarV) then
      if fnId = FUNC_SQRT orelse fnId = FUNC_SQR then
        if IsNaNValue(arU) orelse IsNaNValue(aiU) then
          ValueSetScalarComplexFromDoubles(outV, MakeNaN(), MakeNaN())
          return TRUE
        end if
        if fnId = FUNC_SQR then
          ValueSetScalarComplexFromDoubles(outV, arU * arU - aiU * aiU, 2.0 * arU * aiU)
          return TRUE
        end if
        if fnId = FUNC_SQRT then
          ApplySqrtComplexPrincipalUnary(scalarV, outV)
          return TRUE
        end if
      elseif fnId = FUNC_EXP then
        if IsNaNValue(arU) orelse IsNaNValue(aiU) then
          ValueSetScalarComplexFromDoubles(outV, MakeNaN(), MakeNaN())
          return TRUE
        end if
        if IsTrigRadiansInRange(aiU) = FALSE then return FALSE
        dim ea as Double = exp(arU)
        dim prE as Double = ea * CalcCos(aiU)
        dim piE as Double = ea * CalcSin(aiU)
        ScalarSnapComplexNearZeroAxis(prE, piE)
        ValueSetScalarComplexFromDoubles(outV, prE, piE)
        return TRUE
      elseif fnId = FUNC_LN orelse fnId = FUNC_LOG10 then
        dim lr as Double, li as Double
        ScalarPrincipalLnCartesian(arU, aiU, lr, li)
        if fnId = FUNC_LN then
          ValueSetScalarComplexFromDoubles(outV, lr, li)
        else
          dim invL10 as Double = 1.0 / log(10.0)
          ValueSetScalarComplexFromDoubles(outV, lr * invL10, li * invL10)
        end if
        return TRUE
      elseif (fnId = FUNC_SIN) orelse (fnId = FUNC_COS) orelse (fnId = FUNC_TAN) orelse _
             (fnId = FUNC_ASIN) orelse (fnId = FUNC_ACOS) orelse (fnId = FUNC_ATAN) orelse _
             (fnId = FUNC_SINH) orelse (fnId = FUNC_COSH) orelse (fnId = FUNC_TANH) orelse _
             (fnId = FUNC_ACOSH) orelse (fnId = FUNC_ASINH) orelse (fnId = FUNC_ATANH) then
        dim crT as Double, ciT as Double
        if ApplyUnaryComplexTrigById(fnId, arU, aiU, crT, ciT) then
          ValueSetScalarComplexFromDoubles(outV, crT, ciT)
          return TRUE
        end if
      end if
    return FALSE
  end if
  if (fnId = FUNC_LN orelse fnId = FUNC_LOG10) then
    if IsNonFiniteValue(x) = FALSE then
      if x < 0.0 then
        dim lr0 as Double
        dim li0 as Double
        if fnId = FUNC_LN then
          lr0 = log(-x)
          li0 = FB_PI_VAL
        else
          lr0 = log(-x) / log(10.0)
          li0 = FB_PI_VAL / log(10.0)
        end if
        ScalarSnapComplexNearZeroAxis(lr0, li0)
        ValueSetScalarComplexFromDoubles(outV, lr0, li0)
        return TRUE
      elseif x = 0.0 then
        dim lrZ as Double, liZ as Double
        ScalarPrincipalLnCartesian(0.0, 0.0, lrZ, liZ)
        if fnId = FUNC_LN then
          ValueSetScalarComplexFromDoubles(outV, lrZ, liZ)
        else
          dim invL10z as Double = 1.0 / log(10.0)
          ValueSetScalarComplexFromDoubles(outV, lrZ * invL10z, liZ * invL10z)
        end if
        return TRUE
      end if
    end if
  end if
  return FALSE
end function

private function TryApplyUnaryRealByKind(byval fnId as Integer, byref scalarV as ScalarValue, byref outV as EvalValue) as Boolean
  dim x as Double = scalarV.scalar
  select case K_BUILTIN_META_ROWS(fnId).unaryScalarKind
    case USK_PRIMARY_TRIG
      if IsTrigRadiansInRange(x) = FALSE then return FALSE
      if fnId = FUNC_SIN then
        ValueSetScalar(outV, CalcSin(x))
      elseif fnId = FUNC_COS then
        ValueSetScalar(outV, CalcCos(x))
      else
        ValueSetScalar(outV, CalcTan(x))
      end if
    case USK_INVERSE_TRIG
      if fnId = FUNC_ASIN then
        ValueSetScalar(outV, asin(x))
      elseif fnId = FUNC_ACOS then
        ValueSetScalar(outV, acos(x))
      else
        ValueSetScalar(outV, atn(x))
      end if
    case USK_HYPERBOLIC_TRIG
      if fnId = FUNC_SINH then
        ValueSetScalar(outV, sinh(x))
      elseif fnId = FUNC_COSH then
        ValueSetScalar(outV, cosh(x))
      else
        ValueSetScalar(outV, tanh(x))
      end if
    case USK_INVERSE_HYPERBOLIC_TRIG
      if fnId = FUNC_ACOSH then
        ValueSetScalar(outV, acosh(x))
      elseif fnId = FUNC_ASINH then
        ValueSetScalar(outV, asinh(x))
      else
        ValueSetScalar(outV, atanh(x))
      end if
    case USK_EXP
      ValueSetScalar(outV, exp(x))
    case USK_LN
      ValueSetScalar(outV, log(x))
    case USK_LOG10
      ValueSetScalar(outV, log(x) / log(10.0))
    case USK_SQRT
      ApplyUnarySqrtEval(scalarV, outV)
    case USK_SQR
      if TryApplySqrExactScalar(scalarV, outV) = FALSE then
        ValueSetScalar(outV, x * x)
      end if
    case USK_ROUNDING
      calcRoundingFn(fnId, scalarV, outV)
    case USK_FRAC
      ValueSetScalar(outV, x - Fix(x))
    case USK_ABS
      return ApplyAbsScalarValue(scalarV, outV)
    case USK_SIGN
      if IsNaNValue(x) then
        ValueSetInt64(outV, 0)
      elseif scalarV.exactInt64Valid then
        if scalarV.exactInt64 > 0 then
          ValueSetInt64(outV, 1)
        elseif scalarV.exactInt64 < 0 then
          ValueSetInt64(outV, -1)
        else
          ValueSetInt64(outV, 0)
        end if
      elseif scalarV.exactUInt64Valid then
        if scalarV.exactUInt64 = 0 then
          ValueSetInt64(outV, 0)
        else
          ValueSetInt64(outV, 1)
        end if
      elseif x > 0 then
        ValueSetInt64(outV, 1)
      elseif x < 0 then
        ValueSetInt64(outV, -1)
      else
        ValueSetInt64(outV, 0)
      end if
    case USK_DEG
      ValueSetScalar(outV, x * 180.0 / FB_PI_VAL)
    case USK_RAD
      ValueSetScalar(outV, x * FB_PI_VAL / 180.0)
    case else
      return FALSE
  end select
  return TRUE
end function

private function MapUnaryEvalValueById(byval fnId as Integer, byref inV as EvalValue, byref outV as EvalValue) as Boolean
  if inV.kind = VK_SCALAR then
    return ApplyUnaryBuiltin(fnId, inV.scalarValue, outV)
  end if
  if ubound(inV.arr) < lbound(inV.arr) then
    parseError = 1
    return FALSE
  end if
  ValueInitArrayLike(outV, lbound(inV.arr), ubound(inV.arr))
  dim i as Integer
  for i = lbound(inV.arr) to ubound(inV.arr)
    dim tmpOut as EvalValue
    if ApplyUnaryBuiltin(fnId, inV.arr(i), tmpOut) = FALSE then return FALSE
    ValueSetArrayElemFromScalar(outV, i, tmpOut)
  next i
  return TRUE
end function

private sub ValueFromTimeMs(byval ms as LongInt, byval fnId as Integer, byref outV as EvalValue)
  select case fnId
    case FUNC_MILLISECONDS
      ValueSetInt64(outV, ms)
    case FUNC_SECONDS
      ValueSetScalar(outV, CDbl(ms) / 1000.0)
    case FUNC_MINUTES
      ValueSetScalar(outV, CDbl(ms) / 60000.0)
    case FUNC_HOURS
      ValueSetScalar(outV, CDbl(ms) / 3600000.0)
    case else
      ValueSetScalar(outV, CDbl(ms) / 86400000.0)
  end select
end sub

private function MapTimeUnitOverArray(byref fnName as String, byref arrV as EvalValue, byval fnId as Integer, byref outV as EvalValue) as Boolean
  dim lbA as Integer = lbound(arrV.arr)
  dim ubA as Integer = ubound(arrV.arr)
  ValueInitArrayLike(outV, lbA, ubA)
  dim iA as Integer
  for iA = lbA to ubA
    if ScalarIsTime(arrV.arr(iA)) = FALSE then
      SetParseError(fnName & FB_STR_TIME_EXPECTS_TIME_ARG)
      return TRUE
    end if
    dim rConv as EvalValue
    ValueFromTimeMs(TimeTotalMsFromScalarValue(arrV.arr(iA)), fnId, rConv)
    ValueSetArrayElemFromScalar(outV, iA, rConv)
  next iA
  return TRUE
end function

private function TryNormalizeUnaryScalarInput(byref inV as EvalValue, byref outScalarV as EvalValue) as Boolean
  if inV.kind = VK_SCALAR then
    outScalarV = inV
    return TRUE
  end if
  if inV.kind = VK_ARRAY then
    dim nIn as Integer = ValueArrayLen(inV)
    if nIn = 1 then
      EvalScalarFromScalarValue(inV.arr(lbound(inV.arr)), outScalarV)
      return TRUE
    end if
  end if
  SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
  return FALSE
end function

private function TryCartFromPolarScalars(byval rMag as Double, byval rAng as Double, byref outV as EvalValue) as Boolean
  if Parser_SupportComplexNumbers = FALSE then
    if abs(rAng) > 1e-14 then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return FALSE
    end if
  end if
  dim cr as Double = rMag * CalcCos(rAng)
  dim ci as Double = rMag * CalcSin(rAng)
  ValueSetScalarComplexFromDoubles(outV, cr, ci)
  return TRUE
end function

private function TryBuiltinPolarCart(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  if fnId = FUNC_POLAR then
    dim polarIn as EvalValue
    if TryNormalizeUnaryScalarInput(args(0), polarIn) = FALSE then return TRUE
    if MapUnaryEvalValueById(FUNC_POLAR, polarIn, outV) = FALSE then SetNumericErrorInFunction(fnName)
    return TRUE
  end if
  if fnId <> FUNC_CART then return FALSE

  if ubound(args) = 0 then
    dim cartIn as EvalValue = args(0)
    if cartIn.kind = VK_SCALAR then
      if ApplyUnaryBuiltin(FUNC_CART, cartIn.scalarValue, outV) = FALSE then SetNumericErrorInFunction(fnName)
      return TRUE
    end if
    if cartIn.kind = VK_ARRAY then
      dim nCart as Integer = ValueArrayLen(cartIn)
      if nCart = 1 then
        dim rOnly as Double = cartIn.arr(lbound(cartIn.arr)).scalar
        if TryCartFromPolarScalars(rOnly, 0.0, outV) = FALSE andalso parseError = 0 then SetNumericErrorInFunction(fnName)
        return TRUE
      elseif nCart = 2 then
        dim rMagA as Double = cartIn.arr(lbound(cartIn.arr)).scalar
        dim rAngA as Double = cartIn.arr(lbound(cartIn.arr) + 1).scalar
        if TryCartFromPolarScalars(rMagA, rAngA, outV) = FALSE andalso parseError = 0 then SetNumericErrorInFunction(fnName)
        return TRUE
      end if
    end if
    SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
    return TRUE
  elseif ubound(args) = 1 then
    if args(0).kind <> VK_SCALAR orelse args(1).kind <> VK_SCALAR then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return TRUE
    end if
    if ScalarHasNonzeroImaginaryPart(args(0).scalarValue) orelse ScalarHasNonzeroImaginaryPart(args(1).scalarValue) then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return TRUE
    end if
    if TryCartFromPolarScalars(args(0).scalar, args(1).scalar, outV) = FALSE andalso parseError = 0 then SetNumericErrorInFunction(fnName)
    return TRUE
  end if
  return FALSE
end function

private function ApplyUnaryFunction(byref fn as String, byref v as EvalValue, byref outV as EvalValue) as Boolean
  dim fnId as Integer = TryFindBuiltinFunctionId(fn)
  return MapUnaryEvalValueById(fnId, v, outV)
end function

private sub ScalarComplexPowIntegerNonneg(byval ar as Double, byval ai as Double, byval n as LongInt, byref outR as Double, byref outI as Double)
  if n <= 0 then
    outR = 1.0
    outI = 0.0
    exit sub
  end if
  dim cr as Double = 1.0
  dim ci as Double = 0.0
  dim k as LongInt
  for k = 1 to n
    dim nr as Double = cr * ar - ci * ai
    dim ni as Double = cr * ai + ci * ar
    cr = nr
    ci = ni
    if IsNonFiniteValue(cr) andalso IsNonFiniteValue(ci) then exit for
  next k
  outR = cr
  outI = ci
end sub

private sub ScalarSnapComplexNearZeroAxis(byref zr as Double, byref zi as Double)
  if IsNaNValue(zr) orelse IsNaNValue(zi) then exit sub
  const relEps as Double = 1e-13
  dim scaleI as Double = abs(zi)
  if scaleI < 1.0 then scaleI = 1.0
  if abs(zr) <= relEps * scaleI then zr = 0.0
  dim scaleR as Double = abs(zr)
  if scaleR < 1.0 then scaleR = 1.0
  if abs(zi) <= relEps * scaleR then zi = 0.0
end sub

'' Principal branch: ln(z) = ln|z| + i*arg(z); ln(0) -> (-inf, 0).
private sub ScalarPrincipalLnCartesian(byval ar as Double, byval ai as Double, byref outR as Double, byref outI as Double)
  if IsNaNValue(ar) orelse IsNaNValue(ai) then
    outR = MakeNaN()
    outI = MakeNaN()
    exit sub
  end if
  dim mag as Double = CalcHypot(ar, ai)
  if mag = 0.0 then
    outR = -1.0 / 0.0
    outI = 0.0
    exit sub
  end if
  const axisEps as Double = 1e-15
  dim axScale as Double = abs(ar)
  if axScale < 1.0 then axScale = 1.0
  if abs(ai) <= axisEps * axScale andalso ar < 0.0 then
    outR = log(-ar)
    outI = FB_PI_VAL
    ScalarSnapComplexNearZeroAxis(outR, outI)
    exit sub
  end if
  outR = log(mag)
  outI = CalcAtan2(ai, ar)
  ScalarSnapComplexNearZeroAxis(outR, outI)
end sub

private sub ScalarComplexDivide(byval numR as Double, byval numI as Double, byval denR as Double, byval denI as Double, byref outR as Double, byref outI as Double)
  dim den as Double = denR * denR + denI * denI
  if den = 0.0 then
    outR = MakeNaN()
    outI = MakeNaN()
  else
    outR = (numR * denR + numI * denI) / den
    outI = (numI * denR - numR * denI) / den
  end if
end sub

'' Cartesian product; avoid spurious NaN from 0*inf when a factor is purely real or imaginary.
private sub ScalarComplexCartesianMul(byval ar as Double, byval ai as Double, byval br as Double, byval bi as Double, byref outR as Double, byref outI as Double)
  if (ai = 0.0 andalso not IsNaNValue(ai)) andalso br = 0.0 then
    outR = 0.0
  elseif bi = 0.0 then
    outR = ar * br
    if ar = 0.0 andalso IsNaNValue(outR) then outR = 0.0
  elseif (ai = 0.0 andalso not IsNaNValue(ai)) then
    outR = ar * br
  elseif br = 0.0 then
    outR = -ai * bi
  else
    outR = ar * br - ai * bi
  end if
  if (ai = 0.0 andalso not IsNaNValue(ai)) then
    outI = ar * bi
  elseif bi = 0.0 then
    outI = ai * br
  else
    outI = ar * bi + ai * br
  end if
end sub

private function ScalarComplexExpCartesian(byval ar as Double, byval ai as Double, byref outR as Double, byref outI as Double) as Boolean
  if IsTrigRadiansInRange(ai) = FALSE then return FALSE
  dim ea as Double = exp(ar)
  outR = ea * CalcCos(ai)
  outI = ea * CalcSin(ai)
  return TRUE
end function

'' Principal root: (ar + ai*i)^(invN) via polar form (invN = 1/2 for sqrt, 1/n for odd unit root).
private sub ScalarComplexCartesianPrincipalNthRoot(byval ar as Double, byval ai as Double, byval invN as Double, byref outR as Double, byref outI as Double)
  if IsNaNValue(ar) orelse IsNaNValue(ai) then
    outR = MakeNaN()
    outI = MakeNaN()
    exit sub
  end if
  dim mag as Double = CalcHypot(ar, ai)
  if mag = 0.0 then
    outR = 0.0
    outI = 0.0
    exit sub
  end if
  dim angN as Double = CalcAtan2(ai, ar) * invN
  dim rmN as Double
  if abs(invN - 0.5) < 1e-12 then
    rmN = sqr(mag)
  else
    rmN = exp(log(mag) * invN)
  end if
  outR = rmN * CalcCos(angN)
  outI = rmN * CalcSin(angN)
  ScalarSnapComplexNearZeroAxis(outR, outI)
end sub

private sub ScalarComplexPrincipalSqrt(byval ar as Double, byval ai as Double, byref outR as Double, byref outI as Double)
  ScalarComplexCartesianPrincipalNthRoot(ar, ai, 0.5, outR, outI)
end sub

private function ApplyUnaryComplexTrigById(byval fnId as Integer, byval ar as Double, byval ai as Double, byref outR as Double, byref outI as Double) as Boolean
  if IsUnaryTrigFnId(fnId) then
    if IsTrigCartesianInRange(ar, ai) = FALSE then return FALSE
  elseif IsNaNValue(ar) orelse IsNaNValue(ai) then
    outR = MakeNaN()
    outI = MakeNaN()
    return TRUE
  end if

  select case fnId
    case FUNC_SIN
      outR = CalcSin(ar) * cosh(ai)
      outI = CalcCos(ar) * sinh(ai)
    case FUNC_COS
      outR = CalcCos(ar) * cosh(ai)
      outI = -CalcSin(ar) * sinh(ai)
    case FUNC_SINH
      outR = sinh(ar) * CalcCos(ai)
      outI = cosh(ar) * CalcSin(ai)
    case FUNC_COSH
      outR = cosh(ar) * CalcCos(ai)
      outI = sinh(ar) * CalcSin(ai)
    case FUNC_TAN, FUNC_TANH
      dim numR as Double
      dim numI as Double
      dim denR as Double
      dim denI as Double
      if fnId = FUNC_TAN then
        numR = CalcSin(ar) * cosh(ai)
        numI = CalcCos(ar) * sinh(ai)
        denR = CalcCos(ar) * cosh(ai)
        denI = -CalcSin(ar) * sinh(ai)
      else
        numR = sinh(ar) * CalcCos(ai)
        numI = cosh(ar) * CalcSin(ai)
        denR = cosh(ar) * CalcCos(ai)
        denI = sinh(ar) * CalcSin(ai)
      end if
      ScalarComplexDivide(numR, numI, denR, denI, outR, outI)
    case FUNC_ASINH
      dim z2r as Double = ar * ar - ai * ai
      dim z2i as Double = 2.0 * ar * ai
      dim sqrR as Double
      dim sqrI as Double
      ScalarComplexPrincipalSqrt(z2r + 1.0, z2i, sqrR, sqrI)
      dim sumR as Double = ar + sqrR
      dim sumI as Double = ai + sqrI
      ScalarPrincipalLnCartesian(sumR, sumI, outR, outI)
    case FUNC_ACOSH
      dim z2rC as Double = ar * ar - ai * ai
      dim z2iC as Double = 2.0 * ar * ai
      dim sqrRc as Double
      dim sqrIc as Double
      ScalarComplexPrincipalSqrt(z2rC - 1.0, z2iC, sqrRc, sqrIc)
      dim sumRc as Double = ar + sqrRc
      dim sumIc as Double = ai + sqrIc
      ScalarPrincipalLnCartesian(sumRc, sumIc, outR, outI)
    case FUNC_ATANH
      dim numTr as Double = 1.0 + ar
      dim numTi as Double = ai
      dim denTr as Double = 1.0 - ar
      dim denTi as Double = -ai
      dim quotR as Double
      dim quotI as Double
      ScalarComplexDivide(numTr, numTi, denTr, denTi, quotR, quotI)
      dim lnR as Double
      dim lnI as Double
      ScalarPrincipalLnCartesian(quotR, quotI, lnR, lnI)
      outR = lnR * 0.5
      outI = lnI * 0.5
    case FUNC_ASIN
      dim izR as Double = -ai
      dim izI as Double = ar
      dim z2rA as Double = ar * ar - ai * ai
      dim z2iA as Double = 2.0 * ar * ai
      dim oneMz2r as Double = 1.0 - z2rA
      dim oneMz2i as Double = -z2iA
      dim sqrRa as Double
      dim sqrIa as Double
      ScalarComplexPrincipalSqrt(oneMz2r, oneMz2i, sqrRa, sqrIa)
      dim wR as Double = izR + sqrRa
      dim wI as Double = izI + sqrIa
      dim lnRa as Double
      dim lnIa as Double
      ScalarPrincipalLnCartesian(wR, wI, lnRa, lnIa)
      outR = lnIa
      outI = -lnRa
    case FUNC_ACOS
      dim asR as Double
      dim asI as Double
      if ApplyUnaryComplexTrigById(FUNC_ASIN, ar, ai, asR, asI) = FALSE then return FALSE
      outR = FB_PI_VAL / 2.0 - asR
      outI = -asI
    case FUNC_ATAN
      dim izr as Double = -ai
      dim izi as Double = ar
      dim oneMizr as Double = 1.0 - izr
      dim oneMizi as Double = -izi
      dim onePizr as Double = 1.0 + izr
      dim onePizi as Double = izi
      dim ln1mR as Double
      dim ln1mI as Double
      dim ln1pR as Double
      dim ln1pI as Double
      ScalarPrincipalLnCartesian(oneMizr, oneMizi, ln1mR, ln1mI)
      ScalarPrincipalLnCartesian(onePizr, onePizi, ln1pR, ln1pI)
      dim dR as Double = ln1mR - ln1pR
      dim dI as Double = ln1mI - ln1pI
      outR = -dI * 0.5
      outI = dR * 0.5
    case else
      return FALSE
  end select
  ScalarSnapComplexNearZeroAxis(outR, outI)
  return TRUE
end function

'' Gamma(z) via Lanczos (complex); factorial(n) uses Gamma(n+1).
private function ScalarComplexGamma(byval zr as Double, byval zi as Double, byref outR as Double, byref outI as Double) as Boolean
  if IsNaNValue(zr) orelse IsNaNValue(zi) then
    outR = MakeNaN()
    outI = MakeNaN()
    return TRUE
  end if
  static lanczosC(0 to 8) as Double = { _
    0.99999999999980993, 676.5203681218851, -1259.1392167224028, 771.32342877765313, _
    -176.61502916214059, 12.507343278686905, -0.13857109526572012, 9.9843695780195716e-6, 1.5056327351493116e-7 }
  const lanczosG as Double = 7.0
  dim zmr as Double = zr - 1.0
  dim zmi as Double = zi
  dim xRe as Double = lanczosC(0)
  dim xIm as Double = 0.0
  dim i as Integer
  for i = 1 to 8
    dim dr as Double = zmr + CDbl(i)
    dim di as Double = zmi
    dim quotR as Double
    dim quotI as Double
    ScalarComplexDivide(lanczosC(i), 0.0, dr, di, quotR, quotI)
    xRe += quotR
    xIm += quotI
  next i
  dim tRe as Double = zmr + lanczosG + 0.5
  dim tIm as Double = zmi
  dim lnRe as Double
  dim lnIm as Double
  ScalarPrincipalLnCartesian(tRe, tIm, lnRe, lnIm)
  dim pwRe as Double = zmr + 0.5
  dim pwIm as Double = zmi
  dim lnPowRe as Double
  dim lnPowIm as Double
  ScalarComplexCartesianMul(pwRe, pwIm, lnRe, lnIm, lnPowRe, lnPowIm)
  dim powRe as Double
  dim powIm as Double
  if ScalarComplexExpCartesian(lnPowRe, lnPowIm, powRe, powIm) = FALSE then return FALSE
  dim expNegPrR as Double
  dim expNegPrI as Double
  if ScalarComplexExpCartesian(-tRe, -tIm, expNegPrR, expNegPrI) = FALSE then return FALSE
  dim scale as Double = sqr(2.0 * FB_PI_VAL)
  dim prodRe as Double
  dim prodIm as Double
  ScalarComplexCartesianMul(scale * powRe, scale * powIm, expNegPrR, expNegPrI, prodRe, prodIm)
  ScalarComplexCartesianMul(prodRe, prodIm, xRe, xIm, outR, outI)
  ScalarSnapComplexNearZeroAxis(outR, outI)
  return TRUE
end function

'' intV/uintV before flag fields: avoids x86_64 UDT padding bugs with leading Boolean/Integer sentinels.
private type ExactCartesianComponent
  intV as LongInt
  uintV as ULongInt
  hasInt as Integer
  hasUInt as Integer
end type

private sub ExactCartesianComponentClear(byref c as ExactCartesianComponent)
  c.hasInt = 0
  c.intV = 0
  c.hasUInt = 0
  c.uintV = 0
end sub

'' Signed int64 with two's-complement uint companion (negative values included).
private sub ExactCartesianComponentAssignFromSignedInt64(byref c as ExactCartesianComponent, byval n as LongInt)
  ExactCartesianComponentClear(c)
  c.hasInt = 1
  c.intV = n
  c.hasUInt = 1
  c.uintV = CULngInt(n)
end sub

private sub ExactCartesianComponentAssignFromInt64(byref c as ExactCartesianComponent, byval n as LongInt)
  ExactCartesianComponentAssignFromSignedInt64(c, n)
end sub

private sub ExactCartesianComponentAssignFromUInt64(byref c as ExactCartesianComponent, byval u as ULongInt)
  ExactCartesianComponentClear(c)
  c.hasUInt = 1
  c.uintV = u
  if u <= FB_I64_MAX_U then
    c.hasInt = 1
    c.intV = CLngInt(u)
  end if
end sub

private function TryExactCartesianComponentToInt64(byref c as ExactCartesianComponent, byref outI as LongInt) as Boolean
  if c.hasInt <> 0 then
    outI = c.intV
    return TRUE
  end if
  if c.hasUInt <> 0 andalso c.uintV <= FB_I64_MAX_U then
    outI = CLngInt(c.uintV)
    return TRUE
  end if
  if c.hasInt = 0 andalso c.hasUInt = 0 then
    outI = 0
    return TRUE
  end if
  return FALSE
end function

private function TryExtractExactCartesianComponent(byval isImag as Boolean, byref sv as ScalarValue, byref c as ExactCartesianComponent) as Boolean
  ScalarRepairExactMetadata(sv)
  if isImag = FALSE then
    if ScalarHasRenderRational(sv) then return FALSE
    if ScalarExactInt64Valid(sv) then
      ExactCartesianComponentAssignFromInt64(c, sv.exactInt64)
      if sv.exactInt64 < 0 andalso ScalarExactUInt64Valid(sv) then
        c.hasUInt = 1
        c.uintV = sv.exactUInt64
      end if
      return TRUE
    end if
    if sv.scalarStorageKind = SSK_INT64 then
      ExactCartesianComponentAssignFromInt64(c, sv.exactInt64)
      if sv.exactInt64 < 0 andalso sv.exactUInt64 <> 0 then
        c.hasUInt = 1
        c.uintV = sv.exactUInt64
      end if
      return TRUE
    end if
    if ScalarExactUInt64Valid(sv) then
      ExactCartesianComponentAssignFromUInt64(c, sv.exactUInt64)
      return TRUE
    end if
    if sv.scalarStorageKind = SSK_UINT64 then
      ExactCartesianComponentAssignFromUInt64(c, sv.exactUInt64)
      return TRUE
    end if
    dim tRe as LongInt
    if TryGetExactInt64FromDouble(sv.scalar, tRe) then
      ExactCartesianComponentAssignFromInt64(c, tRe)
      return TRUE
    end if
    return FALSE
  end if

  if ScalarHasImagRenderRational(sv) then return FALSE
  if ScalarImagExactInt64Valid(sv) then
    if sv.imagExactInt64 = 0 andalso sv.imag <> 0.0 then return FALSE
    ExactCartesianComponentAssignFromInt64(c, sv.imagExactInt64)
    if sv.imagExactInt64 < 0 andalso ScalarImagExactUInt64Valid(sv) then
      c.hasUInt = 1
      c.uintV = sv.imagExactUInt64
    end if
    return TRUE
  end if
  if ScalarImagExactUInt64Valid(sv) then
    ExactCartesianComponentAssignFromUInt64(c, sv.imagExactUInt64)
    return TRUE
  end if
  if ScalarImagExactMetadataMatchesFloat(sv) then
    if ScalarImagExactInt64MetadataValid(sv) then
      ExactCartesianComponentAssignFromInt64(c, sv.imagExactInt64)
      if sv.imagExactInt64 < 0 andalso ScalarImagExactUInt64MetadataValid(sv) then
        c.hasUInt = 1
        c.uintV = sv.imagExactUInt64
      end if
      return TRUE
    end if
    if ScalarImagExactUInt64MetadataValid(sv) then
      ExactCartesianComponentAssignFromUInt64(c, sv.imagExactUInt64)
      return TRUE
    end if
  end if
  if ScalarHasNonzeroImaginaryPart(sv) = FALSE then
    ExactCartesianComponentClear(c)
    return TRUE
  end if
  dim tIm as LongInt
  if TryGetExactInt64FromDouble(sv.imag, tIm) then
    if tIm = 0 andalso sv.imag <> 0.0 then return FALSE
    ExactCartesianComponentAssignFromInt64(c, tIm)
    return TRUE
  end if
  return FALSE
end function

private function TryExtractExactRealComponent(byref sv as ScalarValue, byref c as ExactCartesianComponent) as Boolean
  return TryExtractExactCartesianComponent(FALSE, sv, c)
end function

private function TryExtractExactImagComponent(byref sv as ScalarValue, byref c as ExactCartesianComponent) as Boolean
  return TryExtractExactCartesianComponent(TRUE, sv, c)
end function

private sub ValueSetScalarFromExactCartesianComponent(byref v as EvalValue, byref c as ExactCartesianComponent)
  if c.hasInt <> 0 then
    ValueSetInt64(v, c.intV)
    if c.intV < 0 andalso c.hasUInt <> 0 then
      ScalarSetExactUInt64Valid(v.scalarValue, TRUE)
      v.scalarValue.exactUInt64 = c.uintV
    end if
  elseif c.hasUInt <> 0 then
    ValueSetUInt64(v, c.uintV)
  else
    ValueSetScalar(v, 0.0)
  end if
  ScalarClearImag(v.scalarValue)
end sub

private sub ScalarApplyExactImagFromCartesianComponent(byref sv as ScalarValue, byref c as ExactCartesianComponent)
  ScalarSetImagExactInt64Valid(sv, FALSE)
  ScalarSetImagExactUInt64Valid(sv, FALSE)
  sv.imagExactInt64 = 0
  sv.imagExactUInt64 = 0
  sv.imag = 0.0
  if c.hasInt = 0 andalso c.hasUInt = 0 then exit sub
  if c.hasInt <> 0 then
    ScalarSetImagExactInt64Valid(sv, TRUE)
    sv.imagExactInt64 = c.intV
    sv.imag = CDbl(c.intV)
    if c.hasUInt <> 0 then
      ScalarSetImagExactUInt64Valid(sv, TRUE)
      sv.imagExactUInt64 = c.uintV
    else
      ScalarSetImagExactUInt64Valid(sv, TRUE)
      sv.imagExactUInt64 = CULngInt(c.intV)
    end if
  else
    ScalarSetImagExactUInt64Valid(sv, TRUE)
    sv.imagExactUInt64 = c.uintV
    sv.imag = CDbl(c.uintV)
    if c.uintV <= FB_I64_MAX_U then
      ScalarSetImagExactInt64Valid(sv, TRUE)
      sv.imagExactInt64 = CLngInt(c.uintV)
    end if
  end if
  ScalarRepairExactMetadata(sv)
end sub

private sub ValueSetScalarComplexFromExactCartesian(byref v as EvalValue, byref re as ExactCartesianComponent, byref im as ExactCartesianComponent)
  ValueSetScalarFromExactCartesianComponent(v, re)
  v.scalarValue.imag = 0.0
  ScalarApplyExactImagFromCartesianComponent(v.scalarValue, im)
  ScalarRepairExactMetadata(v.scalarValue)
  ScalarNormalizeIfPureReal(v.scalarValue)
end sub

private function TryApplyExactCartesianBinaryOp(byval isAdd as Boolean, byref a as ExactCartesianComponent, byref b as ExactCartesianComponent, byref result as ExactCartesianComponent) as Boolean
  ExactCartesianComponentClear(result)
  dim ai as LongInt, bi as LongInt, oi as LongInt
  if TryExactCartesianComponentToInt64(a, ai) andalso TryExactCartesianComponentToInt64(b, bi) then
    if isAdd then
      if TryAddInt64(ai, bi, oi) = FALSE then return FALSE
    else
      if TrySubInt64(ai, bi, oi) = FALSE then return FALSE
    end if
    ExactCartesianComponentAssignFromInt64(result, oi)
    return TRUE
  end if
  if isAdd andalso a.hasUInt <> 0 andalso b.hasUInt <> 0 then
    dim ou as ULongInt
    if TryAddULongChecked(a.uintV, b.uintV, ou) = FALSE then return FALSE
    ExactCartesianComponentAssignFromUInt64(result, ou)
    return TRUE
  end if
  return FALSE
end function

private function TryAddExactCartesianComponents(byref a as ExactCartesianComponent, byref b as ExactCartesianComponent, byref result as ExactCartesianComponent) as Boolean
  return TryApplyExactCartesianBinaryOp(TRUE, a, b, result)
end function

private function TryQuotExactInt64(byval num as LongInt, byval den as LongInt, byref quo as LongInt) as Boolean
  if den = 0 then return FALSE
  quo = num \ den
  if quo * den = num then return TRUE
  return FALSE
end function

private function TryQuotExactULong(byval num as ULongInt, byval den as ULongInt, byref quo as ULongInt) as Boolean
  if den = 0ull then return FALSE
  quo = num \ den
  dim prod as ULongInt
  if TryMulULongChecked(quo, den, prod) = FALSE then return FALSE
  return (prod = num)
end function

private function RelCloseDouble(byval a as Double, byval b as Double) as Boolean
  const EPS as Double = 1e-12
  dim scale as Double = abs(b)
  if scale < 1.0 then scale = 1.0
  return abs(a - b) <= EPS * scale
end function

private function TryRecoverReducedRationalFromFloatAbs(byval absFVal as Double, byref outNum as LongInt, byref outDen as LongInt) as Boolean
  const EPS as Double = 1e-12
  const MAX_B as LongInt = 4096
  dim bestErr as Double = 1e300
  dim bestA as LongInt = 0
  dim bestB as LongInt = 0
  dim denIter as LongInt
  for denIter = 1 to MAX_B
    dim numV as LongInt = CLngInt(round(absFVal * CDbl(denIter)))
    if numV < 1 then continue for
    dim denV as LongInt = denIter
    dim g as LongInt = GcdInt64(numV, denV)
    numV \= g
    denV \= g
    dim approx as Double = CDbl(numV) / CDbl(denV)
    dim ratErr as Double = abs(absFVal - approx)
    if ratErr < bestErr then
      bestErr = ratErr
      bestA = numV
      bestB = denV
    end if
  next denIter
  if bestA < 1 orelse bestB < 1 then return FALSE
  dim scale as Double = absFVal
  if scale < 1.0 then scale = 1.0
  if bestErr > EPS * scale then return FALSE
  outNum = bestA
  outDen = bestB
  return TRUE
end function

private function TryPassExactAbsFloatFactorGates(byval floatV as Double, byval strictAbsFAboveOne as Boolean) as Boolean
  if IsNonFiniteValue(floatV) orelse floatV = 0 then return FALSE
  if strictAbsFAboveOne then
    if abs(floatV) <= 1.0 then return FALSE
  else
    if abs(floatV) < 1.0 then return FALSE
  end if
  dim tmpI as LongInt
  if TryGetExactInt64FromDouble(floatV, tmpI) then return FALSE
  return TRUE
end function

private function TryGetExactRoundedIntFromFloatResult(byval r as Double, byval boundAbsResultTo2_53 as Boolean, byref outI as LongInt) as Boolean
  dim roundedI as LongInt = CLngInt(round(r))
  if CDbl(roundedI) <> r orelse roundedI = 0 then return FALSE
  if boundAbsResultTo2_53 andalso abs(CDbl(roundedI)) > FB_MAX_EXACT_INT_FROM_DOUBLE then return FALSE
  outI = roundedI
  return TRUE
end function

private function TryVerifyExactIntFloatOpResidue(byval kind as ScalarExactKind, byval intSigned as LongInt, byval intUnsigned as ULongInt, byval floatV as Double, byval resultSigned as LongInt, byval resultUnsigned as ULongInt, byval isMultiply as Boolean) as Boolean
  if kind = SEK_SIGNED then
    if isMultiply then
      return RelCloseDouble(CDbl(resultSigned) - CDbl(intSigned) * floatV, 0.0)
    end if
    return RelCloseDouble(CDbl(intSigned) - CDbl(resultSigned) * floatV, 0.0)
  end if
  if isMultiply then
    return RelCloseDouble(CDbl(resultUnsigned) - CDbl(intUnsigned) * floatV, 0.0)
  end if
  return RelCloseDouble(CDbl(intUnsigned) - CDbl(resultUnsigned) * floatV, 0.0)
end function

private function TryVerifyExactIntFloatOpCrossMultiply(byval kind as ScalarExactKind, byval intSigned as LongInt, byval intUnsigned as ULongInt, byval floatV as Double, byval resultSigned as LongInt, byval resultUnsigned as ULongInt, byval ratA as LongInt, byval ratB as LongInt, byval isMultiply as Boolean) as Boolean
  if kind = SEK_SIGNED then
    dim signF as LongInt = 1
    if floatV < 0 then signF = -1
    dim resultSignedScaled as LongInt
    dim lhs as LongInt
    dim rhs as LongInt
    if TryMulInt64(resultSigned, signF, resultSignedScaled) = FALSE then return FALSE
    if isMultiply then
      if TryMulInt64(resultSignedScaled, ratB, lhs) = FALSE then return FALSE
      if TryMulInt64(intSigned, ratA, rhs) = FALSE then return FALSE
    else
      if TryMulInt64(resultSignedScaled, ratA, lhs) = FALSE then return FALSE
      if TryMulInt64(intSigned, ratB, rhs) = FALSE then return FALSE
    end if
    return (lhs = rhs)
  end if
  dim lhsU as ULongInt
  dim rhsU as ULongInt
  if isMultiply then
    if TryMulULongChecked(resultUnsigned, CULngInt(ratB), lhsU) = FALSE then return FALSE
    if TryMulULongChecked(intUnsigned, CULngInt(ratA), rhsU) = FALSE then return FALSE
  else
    if TryMulULongChecked(resultUnsigned, CULngInt(ratA), lhsU) = FALSE then return FALSE
    if TryMulULongChecked(intUnsigned, CULngInt(ratB), rhsU) = FALSE then return FALSE
  end if
  return (lhsU = rhsU)
end function

private function TryPromoteExactIntFromFloatOp(byval kind as ScalarExactKind, byval intSigned as LongInt, byval intUnsigned as ULongInt, byval floatV as Double, byval r as Double, byval isMultiply as Boolean, byref outV as EvalValue) as Boolean
  if TryPassExactAbsFloatFactorGates(floatV, isMultiply) = FALSE then return FALSE
  if kind = SEK_SIGNED then
    if abs(CDbl(intSigned)) > FB_MAX_EXACT_INT_FROM_DOUBLE then return FALSE
  elseif floatV < 0 orelse CDbl(intUnsigned) > FB_MAX_EXACT_INT_FROM_DOUBLE then
    return FALSE
  end if
  dim resultSigned as LongInt
  if TryGetExactRoundedIntFromFloatResult(r, isMultiply, resultSigned) = FALSE then return FALSE
  dim resultUnsigned as ULongInt = 0
  if kind = SEK_UNSIGNED then
    if resultSigned < 0 then return FALSE
    resultUnsigned = CULngInt(resultSigned)
    if isMultiply andalso CDbl(resultUnsigned) > FB_MAX_EXACT_INT_FROM_DOUBLE then return FALSE
  end if
  if TryVerifyExactIntFloatOpResidue(kind, intSigned, intUnsigned, floatV, resultSigned, resultUnsigned, isMultiply) = FALSE then return FALSE
  dim ratA as LongInt
  dim ratB as LongInt
  if TryRecoverReducedRationalFromFloatAbs(abs(floatV), ratA, ratB) = FALSE then return FALSE
  if TryVerifyExactIntFloatOpCrossMultiply(kind, intSigned, intUnsigned, floatV, resultSigned, resultUnsigned, ratA, ratB, isMultiply) = FALSE then return FALSE
  if kind = SEK_SIGNED then
    ValueSetInt64(outV, resultSigned)
  else
    ValueSetUInt64(outV, resultUnsigned)
  end if
  return TRUE
end function

private function TryPromoteExactDivisionByFloatDivisorSigned(byval intI as LongInt, byval floatV as Double, byval r as Double, byref outV as EvalValue) as Boolean
  return TryPromoteExactIntFromFloatOp(SEK_SIGNED, intI, 0ull, floatV, r, FALSE, outV)
end function

private function TryPromoteExactDivisionByFloatDivisorUnsigned(byval intU as ULongInt, byval floatV as Double, byval r as Double, byref outV as EvalValue) as Boolean
  return TryPromoteExactIntFromFloatOp(SEK_UNSIGNED, 0, intU, floatV, r, FALSE, outV)
end function

private function TryPromoteExactMultiplicationByFloatFactorSigned(byval intI as LongInt, byval floatV as Double, byval r as Double, byref outV as EvalValue) as Boolean
  return TryPromoteExactIntFromFloatOp(SEK_SIGNED, intI, 0ull, floatV, r, TRUE, outV)
end function

private function TryPromoteExactMultiplicationByFloatFactorUnsigned(byval intU as ULongInt, byval floatV as Double, byval r as Double, byref outV as EvalValue) as Boolean
  return TryPromoteExactIntFromFloatOp(SEK_UNSIGNED, 0, intU, floatV, r, TRUE, outV)
end function

private function TryApplyExactIntFloatOpFromFloatSide(byval kind as ScalarExactKind, byval isMultiply as Boolean, byval intSigned as LongInt, byval intUnsigned as ULongInt, byval floatV as Double, byval r as Double, byref outV as EvalValue) as Boolean
  if IsNonFiniteValue(floatV) orelse floatV = 0 then return FALSE
  const EPS as Double = 1e-12
  dim tmpI as LongInt
  dim inv as Double
  dim invAbs as Double
  dim invRounded as Double
  dim nU as ULongInt
  dim nI as LongInt
  dim qI as LongInt
  dim qU as ULongInt

  if kind = SEK_UNSIGNED then
    if isMultiply then
      if floatV <= 0 then return FALSE
      if floatV < 1 then
        if TryGetExactInt64FromDouble(floatV, tmpI) = FALSE then
          inv = 1.0 / floatV
          invRounded = round(inv)
          if invRounded > 1.0 andalso invRounded <= CDbl(FB_U64_MAX) then
            if abs(inv - invRounded) <= EPS * IIf(abs(inv) > 1.0, abs(inv), 1.0) then
              nU = CULngInt(invRounded)
              if nU <> 0ull andalso (intUnsigned mod nU) = 0ull then
                ValueSetUInt64(outV, intUnsigned \ nU)
                return TRUE
              end if
            end if
          end if
        end if
      end if
      return TryPromoteExactMultiplicationByFloatFactorUnsigned(intUnsigned, floatV, r, outV)
    end if
    if abs(floatV) < 1 then
      if TryGetExactInt64FromDouble(floatV, tmpI) = FALSE then
        inv = 1.0 / floatV
        invRounded = round(inv)
        if abs(invRounded) > 1.0 andalso abs(invRounded) <= CDbl(FB_U64_MAX) then
          if abs(inv - invRounded) <= EPS * IIf(abs(inv) > 1.0, abs(inv), 1.0) then
            if invRounded > 0 then
              nU = CULngInt(invRounded)
              if TryMulULongChecked(intUnsigned, nU, qU) then
                ValueSetUInt64(outV, qU)
                return TRUE
              end if
            elseif invRounded < 0 then
              nU = CULngInt(-invRounded)
              if TryMulULongChecked(intUnsigned, nU, qU) andalso qU <= FB_I64_MAX_U then
                qI = -CLngInt(qU)
                ValueSetInt64(outV, qI)
                return TRUE
              end if
            end if
          end if
        end if
      end if
    end if
    return TryPromoteExactDivisionByFloatDivisorUnsigned(intUnsigned, floatV, r, outV)
  end if

  if isMultiply then
    if abs(floatV) < 1.0 then
      if TryGetExactInt64FromDouble(floatV, tmpI) then return FALSE
      inv = 1.0 / floatV
      invAbs = abs(inv)
      invRounded = round(invAbs)
      if invRounded <= 1.0 then return FALSE
      if abs(invAbs - invRounded) > EPS * IIf(invAbs > 1.0, invAbs, 1.0) then return FALSE
      if invRounded > CDbl(FB_I64_MAX) then return FALSE
      nI = CLngInt(invRounded)
      if nI <= 1 then return FALSE
      if (intSigned mod nI) <> 0 then return FALSE
      qI = intSigned \ nI
      if floatV < 0 then
        if qI = FB_I64_MIN then return FALSE
        qI = -qI
      end if
      ValueSetInt64(outV, qI)
      return TRUE
    end if
    return TryPromoteExactMultiplicationByFloatFactorSigned(intSigned, floatV, r, outV)
  end if

  if abs(floatV) < 1 then
    if TryGetExactInt64FromDouble(floatV, tmpI) = FALSE then
      inv = 1.0 / floatV
      invRounded = round(inv)
      if abs(invRounded) > 1.0 andalso abs(invRounded) <= CDbl(FB_I64_MAX) then
        if abs(inv - invRounded) <= EPS * IIf(abs(inv) > 1.0, abs(inv), 1.0) then
          nI = CLngInt(invRounded)
          if TryMulInt64(intSigned, nI, qI) then
            ValueSetInt64(outV, qI)
            return TRUE
          elseif intSigned >= 0 andalso nI > 0 then
            nU = CULngInt(nI)
            if TryMulULongChecked(CULngInt(intSigned), nU, qU) then
              ValueSetUInt64(outV, qU)
              return TRUE
            end if
          end if
        end if
      end if
    end if
  end if
  return TryPromoteExactDivisionByFloatDivisorSigned(intSigned, floatV, r, outV)
end function

private function TryApplyExactIntegerDivisionFromQuotient(byref leftS as ScalarValue, byref rightS as ScalarValue, byval r as Double, byref outV as EvalValue) as Boolean
  if IsNonFiniteValue(r) then return FALSE
  dim aU as ULongInt, bU as ULongInt
  if TryGetExactNonNegativeUInt64Scalar(leftS, aU) andalso TryGetExactNonNegativeUInt64Scalar(rightS, bU) then
    if bU = 0ull then return FALSE
    dim qU as ULongInt = CULngInt(round(r))
    dim prodU as ULongInt
    if TryMulULongChecked(qU, bU, prodU) = FALSE then return FALSE
    if prodU <> aU then return FALSE
    ValueSetUInt64(outV, qU)
    return TRUE
  end if
  dim aI as LongInt, bI as LongInt
  if TryGetExactSignedInt64NoUIntWrapScalar(leftS, aI) andalso TryGetExactSignedInt64NoUIntWrapScalar(rightS, bI) then
    if bI = 0 then return FALSE
    dim qI as LongInt = CLngInt(round(r))
    dim prodI as LongInt
    if TryMulInt64(qI, bI, prodI) = FALSE then return FALSE
    if prodI <> aI then return FALSE
    ValueSetInt64(outV, qI)
    return TRUE
  end if

  dim intU as ULongInt
  dim intI as LongInt

  if TryGetExactNonNegativeUInt64Scalar(leftS, intU) andalso ScalarHasExactIntegerPayload(rightS) = FALSE then
    if TryApplyExactIntFloatOpFromFloatSide(SEK_UNSIGNED, FALSE, 0, intU, rightS.scalar, r, outV) then return TRUE
  end if

  if TryGetExactSignedInt64NoUIntWrapScalar(leftS, intI) andalso ScalarHasExactIntegerPayload(rightS) = FALSE then
    if TryApplyExactIntFloatOpFromFloatSide(SEK_SIGNED, FALSE, intI, 0ull, rightS.scalar, r, outV) then return TRUE
  end if

  return FALSE
end function

private function TryApplyExactIntegerMultiplicationFromProduct(byref leftS as ScalarValue, byref rightS as ScalarValue, byval r as Double, byref outV as EvalValue) as Boolean
  if IsNonFiniteValue(r) then return FALSE

  dim intU as ULongInt
  dim intI as LongInt

  if TryGetExactNonNegativeUInt64Scalar(leftS, intU) andalso ScalarHasExactIntegerPayload(rightS) = FALSE then
    if TryApplyExactIntFloatOpFromFloatSide(SEK_UNSIGNED, TRUE, 0, intU, rightS.scalar, r, outV) then return TRUE
  elseif TryGetExactNonNegativeUInt64Scalar(rightS, intU) andalso ScalarHasExactIntegerPayload(leftS) = FALSE then
    if TryApplyExactIntFloatOpFromFloatSide(SEK_UNSIGNED, TRUE, 0, intU, leftS.scalar, r, outV) then return TRUE
  end if

  if TryGetExactSignedInt64NoUIntWrapScalar(leftS, intI) andalso ScalarHasExactIntegerPayload(rightS) = FALSE then
    if TryApplyExactIntFloatOpFromFloatSide(SEK_SIGNED, TRUE, intI, 0ull, rightS.scalar, r, outV) then return TRUE
  elseif TryGetExactSignedInt64NoUIntWrapScalar(rightS, intI) andalso ScalarHasExactIntegerPayload(leftS) = FALSE then
    if TryApplyExactIntFloatOpFromFloatSide(SEK_SIGNED, TRUE, intI, 0ull, leftS.scalar, r, outV) then return TRUE
  end if

  return FALSE
end function

private function TrySubExactCartesianComponents(byref a as ExactCartesianComponent, byref b as ExactCartesianComponent, byref result as ExactCartesianComponent) as Boolean
  return TryApplyExactCartesianBinaryOp(FALSE, a, b, result)
end function

private function TryApplyExactComplexCartesianBinary(byref leftS as ScalarValue, byref rightS as ScalarValue, byval op as UByte, byref outV as EvalValue) as Boolean
  if ScalarHasRenderRational(leftS) orelse ScalarHasImagRenderRational(leftS) _
    orelse ScalarHasRenderRational(rightS) orelse ScalarHasImagRenderRational(rightS) then
    return FALSE
  end if
  dim lRe as ExactCartesianComponent
  dim lIm as ExactCartesianComponent
  dim rRe as ExactCartesianComponent
  dim rIm as ExactCartesianComponent
  dim oRe as ExactCartesianComponent
  dim oIm as ExactCartesianComponent
  if TryExtractExactCartesianComponent(FALSE, leftS, lRe) = FALSE then return FALSE
  if TryExtractExactCartesianComponent(TRUE, leftS, lIm) = FALSE then return FALSE
  if TryExtractExactCartesianComponent(FALSE, rightS, rRe) = FALSE then return FALSE
  if TryExtractExactCartesianComponent(TRUE, rightS, rIm) = FALSE then return FALSE

  if op = CHAR_PLUS then
    if TryApplyExactCartesianBinaryOp(TRUE, lRe, rRe, oRe) = FALSE then return FALSE
    if TryApplyExactCartesianBinaryOp(TRUE, lIm, rIm, oIm) = FALSE then return FALSE
    ValueSetScalarComplexFromExactCartesian(outV, oRe, oIm)
    return TRUE
  end if

  if op = CHAR_MINUS then
    if TryApplyExactCartesianBinaryOp(FALSE, lRe, rRe, oRe) = FALSE then return FALSE
    if TryApplyExactCartesianBinaryOp(FALSE, lIm, rIm, oIm) = FALSE then return FALSE
    ValueSetScalarComplexFromExactCartesian(outV, oRe, oIm)
    return TRUE
  end if

  if op = CHAR_ASTERISK then
    dim lar as LongInt, lai as LongInt, lbr as LongInt, lbi as LongInt
    dim p1 as LongInt, p2 as LongInt, p3 as LongInt, p4 as LongInt
    dim oreI as LongInt, oimI as LongInt
    if TryExactCartesianComponentToInt64(lRe, lar) = FALSE then return FALSE
    if TryExactCartesianComponentToInt64(lIm, lai) = FALSE then return FALSE
    if TryExactCartesianComponentToInt64(rRe, lbr) = FALSE then return FALSE
    if TryExactCartesianComponentToInt64(rIm, lbi) = FALSE then return FALSE
    if TryMulInt64(lar, lbr, p1) = FALSE then return FALSE
    if TryMulInt64(lai, lbi, p2) = FALSE then return FALSE
    if TryMulInt64(lar, lbi, p3) = FALSE then return FALSE
    if TryMulInt64(lai, lbr, p4) = FALSE then return FALSE
    if TrySubInt64(p1, p2, oreI) = FALSE then return FALSE
    if TryAddInt64(p3, p4, oimI) = FALSE then return FALSE
    ExactCartesianComponentAssignFromInt64(oRe, oreI)
    ExactCartesianComponentAssignFromInt64(oIm, oimI)
    ValueSetScalarComplexFromExactCartesian(outV, oRe, oIm)
    return TRUE
  end if

  if op = CHAR_DIVIDE then
    dim lar as LongInt, lai as LongInt, lbr as LongInt, lbi as LongInt
    dim p1 as LongInt, p2 as LongInt, p3 as LongInt, p4 as LongInt, p5 as LongInt, p6 as LongInt
    dim numRe as LongInt, numIm as LongInt, denom as LongInt, qRe as LongInt, qIm as LongInt
    if TryExactCartesianComponentToInt64(lRe, lar) = FALSE then return FALSE
    if TryExactCartesianComponentToInt64(lIm, lai) = FALSE then return FALSE
    if TryExactCartesianComponentToInt64(rRe, lbr) = FALSE then return FALSE
    if TryExactCartesianComponentToInt64(rIm, lbi) = FALSE then return FALSE
    if TryMulInt64(lar, lbr, p1) = FALSE then return FALSE
    if TryMulInt64(lai, lbi, p2) = FALSE then return FALSE
    if TryAddInt64(p1, p2, numRe) = FALSE then return FALSE
    if TryMulInt64(lbr, lbr, p3) = FALSE then return FALSE
    if TryMulInt64(lbi, lbi, p4) = FALSE then return FALSE
    if TryAddInt64(p3, p4, denom) = FALSE then return FALSE
    if denom = 0 then return FALSE
    if TryMulInt64(lai, lbr, p5) = FALSE then return FALSE
    if TryMulInt64(lar, lbi, p6) = FALSE then return FALSE
    if TrySubInt64(p5, p6, numIm) = FALSE then return FALSE
    if TryQuotExactInt64(numRe, denom, qRe) = FALSE then return FALSE
    if TryQuotExactInt64(numIm, denom, qIm) = FALSE then return FALSE
    ExactCartesianComponentAssignFromInt64(oRe, qRe)
    ExactCartesianComponentAssignFromInt64(oIm, qIm)
    ValueSetScalarComplexFromExactCartesian(outV, oRe, oIm)
    return TRUE
  end if

  return FALSE
end function

private sub ValueSetScalarComplexFromEvalRealImagParts(byref outV as EvalValue, byref rePart as EvalValue, byref imPart as EvalValue)
  dim reC as ExactCartesianComponent
  dim imC as ExactCartesianComponent
  if TryExtractExactRealComponent(rePart.scalarValue, reC) andalso TryExtractExactRealComponent(imPart.scalarValue, imC) then
    ValueSetScalarComplexFromExactCartesian(outV, reC, imC)
  else
    ValueSetScalarComplexFromDoubles(outV, rePart.scalar, imPart.scalar)
  end if
end sub

'' Negative real sqrt (complex mode): |x| via same sqrt policy as sqrt(|x|), then pure imaginary.
private sub ValueSetPureImaginaryFromMagnitudeScalar(byref outV as EvalValue, byref magSv as ScalarValue)
  ValueSetInt64(outV, 0)
  if ScalarHasExactIntegerPayload(magSv) then
    if ScalarExactInt64Valid(magSv) then
      ScalarSetImagExactInt64Valid(outV.scalarValue, TRUE)
      outV.scalarValue.imagExactInt64 = magSv.exactInt64
      if magSv.exactInt64 >= 0 then
        ScalarSetImagExactUInt64Valid(outV.scalarValue, TRUE)
        outV.scalarValue.imagExactUInt64 = CULngInt(magSv.exactInt64)
      else
        ScalarSetImagExactUInt64Valid(outV.scalarValue, FALSE)
        outV.scalarValue.imagExactUInt64 = 0
      end if
      outV.scalarValue.imag = CDbl(magSv.exactInt64)
    elseif ScalarExactUInt64Valid(magSv) then
      ScalarSetImagExactUInt64Valid(outV.scalarValue, TRUE)
      outV.scalarValue.imagExactUInt64 = magSv.exactUInt64
      outV.scalarValue.imag = CDbl(magSv.exactUInt64)
      if magSv.exactUInt64 <= FB_I64_MAX_U then
        ScalarSetImagExactInt64Valid(outV.scalarValue, TRUE)
        outV.scalarValue.imagExactInt64 = CLngInt(magSv.exactUInt64)
      else
        ScalarSetImagExactInt64Valid(outV.scalarValue, FALSE)
        outV.scalarValue.imagExactInt64 = 0
      end if
    else
      outV.scalarValue.imag = magSv.scalar
      ScalarSetImagExactInt64Valid(outV.scalarValue, FALSE)
      ScalarSetImagExactUInt64Valid(outV.scalarValue, FALSE)
    end if
  else
    outV.scalarValue.imag = magSv.scalar
    ScalarSetImagExactInt64Valid(outV.scalarValue, FALSE)
    ScalarSetImagExactUInt64Valid(outV.scalarValue, FALSE)
    outV.scalarValue.imagExactInt64 = 0
    outV.scalarValue.imagExactUInt64 = 0
  end if
  ScalarRepairExactMetadata(outV.scalarValue)
end sub

private sub SetEvalPureImaginaryFromRootMagnitude(byval rootCand as LongInt, byref outV as EvalValue)
  dim magV as EvalValue
  ValueSetInt64(magV, rootCand)
  ValueSetPureImaginaryFromMagnitudeScalar(outV, magV.scalarValue)
end sub

private sub ApplySqrtNegativeRealAsPureImagComplex(byref scalarV as ScalarValue, byref outV as EvalValue)
  dim absV as EvalValue
  ApplyAbsScalarValue(scalarV, absV)
  dim magV as EvalValue
  ApplySqrtScalarValue(absV.scalarValue, magV)
  ValueSetPureImaginaryFromMagnitudeScalar(outV, magV.scalarValue)
end sub

'' Principal complex sqrt; promote to exact int complex when square verifies against exact input.
private function TryRefineSqrtPrincipalToExactComplex(byref inSv as ScalarValue, byval sqrtR as Double, byval sqrtI as Double, byref outV as EvalValue) as Boolean
  if IsNonFiniteValue(sqrtR) orelse IsNonFiniteValue(sqrtI) then return FALSE
  dim reC as ExactCartesianComponent
  dim imC as ExactCartesianComponent
  if TryExtractExactRealComponent(inSv, reC) = FALSE then return FALSE
  if TryExtractExactImagComponent(inSv, imC) = FALSE then return FALSE
  dim arI as LongInt
  dim aiI as LongInt
  if TryExactCartesianComponentToInt64(reC, arI) = FALSE then return FALSE
  if TryExactCartesianComponentToInt64(imC, aiI) = FALSE then return FALSE
  dim rootRi as LongInt = CLngInt(round(sqrtR))
  dim rootIi as LongInt = CLngInt(round(sqrtI))
  if TryVerifyComplexCartesianSquareExact(rootRi, rootIi, arI, aiI) = FALSE then return FALSE
  dim rePart as EvalValue
  dim imPart as EvalValue
  ValueSetInt64(rePart, rootRi)
  ValueSetInt64(imPart, rootIi)
  ValueSetScalarComplexFromEvalRealImagParts(outV, rePart, imPart)
  return TRUE
end function

private sub ApplyUnarySqrtEval(byref scalarV as ScalarValue, byref outV as EvalValue)
  if Parser_SupportComplexNumbers then
    dim arU as Double
    dim aiU as Double
    ScalarLoadCartesian(scalarV, arU, aiU)
    if ScalarHasNonzeroImaginaryPart(scalarV) then
      ApplySqrtComplexPrincipalUnary(scalarV, outV)
      exit sub
    end if
    if IsNonFiniteValue(arU) = FALSE andalso arU < 0.0 andalso aiU = 0.0 then
      ApplySqrtNegativeRealAsPureImagComplex(scalarV, outV)
      exit sub
    end if
  end if
  ApplySqrtScalarValue(scalarV, outV)
end sub

private sub ApplySqrtComplexPrincipalUnary(byref inSv as ScalarValue, byref outV as EvalValue)
  dim cr as Double
  dim ci as Double
  ScalarLoadCartesian(inSv, cr, ci)
  if IsNaNValue(cr) orelse IsNaNValue(ci) then
    ValueSetScalarComplexFromDoubles(outV, MakeNaN(), MakeNaN())
    exit sub
  end if
  dim mag as Double = CalcHypot(cr, ci)
  if mag = 0.0 then
    ValueSetScalarComplexFromDoubles(outV, 0.0, 0.0)
    exit sub
  end if
  dim sqrtR as Double
  dim sqrtI as Double
  ScalarComplexPrincipalSqrt(cr, ci, sqrtR, sqrtI)
  if TryRefineSqrtPrincipalToExactComplex(inSv, sqrtR, sqrtI, outV) then exit sub
  ValueSetScalarComplexFromDoubles(outV, sqrtR, sqrtI)
end sub

'' After principal complex **, promote to exact scalar/complex when real ** verification applies (pure real operands).
private function TryRefinePowPrincipalToExactScalarResult(byref leftS as ScalarValue, byref rightS as ScalarValue, byval powR as Double, byval powI as Double, byref outV as EvalValue) as Boolean
  const eps as Double = 1e-12
  dim ar as Double, ai as Double, br as Double, bi as Double
  ScalarLoadCartesian(leftS, ar, ai)
  ScalarLoadCartesian(rightS, br, bi)
  if abs(ai) > eps orelse abs(bi) > eps then return FALSE

  dim p as Double = br
  if IsNonFiniteValue(p) orelse IsNonFiniteValue(powR) orelse IsNonFiniteValue(powI) then return FALSE

  dim valueInt as LongInt
  dim hasSigned as Boolean = TryGetExactSignedInt64NoUIntWrapScalarStrict(leftS, valueInt)
  dim inpU as ULongInt
  dim hasUInt as Boolean = TryGetExactNonNegativeUInt64Scalar(leftS, inpU)

  if p > 0.0 andalso p < 1.0 then
    dim nRoot as LongInt
    if FractionalPowerResolveRootDegree(p, nRoot) = FALSE then return FALSE
    if hasSigned andalso valueInt < 0 then
      if abs(powR) > eps then return FALSE
      dim rootCand as LongInt = CLngInt(round(powI))
      dim verifyBase as LongInt = valueInt
      if nRoot = 2 andalso valueInt <> FB_I64_MIN then verifyBase = -valueInt
      if TryPowVerifyRootExact(verifyBase, rootCand, nRoot) = FALSE then
        if nRoot <> 2 orelse TryPowVerifyRootExact(valueInt, rootCand, nRoot) = FALSE then return FALSE
      end if
      SetEvalPureImaginaryFromRootMagnitude(rootCand, outV)
      return TRUE
    elseif hasSigned andalso valueInt >= 0 then
      if abs(powI) > eps then return FALSE
      dim rootCand as LongInt = CLngInt(round(powR))
      if TryPowVerifyRootExact(valueInt, rootCand, nRoot) = FALSE then return FALSE
      ValueSetInt64(outV, rootCand)
      return TRUE
    elseif hasUInt then
      if abs(powI) > eps then return FALSE
      dim rootCand as ULongInt = CULngInt(round(powR))
      dim sq as ULongInt
      if TryPowULong(rootCand, CULngInt(nRoot), sq) = FALSE orelse sq <> inpU then return FALSE
      if rootCand <= FB_I64_MAX_U then
        ValueSetInt64(outV, CLngInt(rootCand))
      else
        ValueSetUInt64(outV, rootCand)
      end if
      return TRUE
    end if
    return FALSE
  end if

  if p >= 1.0 then
    dim nExp as LongInt = CLngInt(round(p))
    if nExp < 0 orelse nExp > 63 orelse abs(p - CDbl(nExp)) > 1e-6 then return FALSE
    if abs(powI) > eps then return FALSE
    dim powResult as LongInt = CLngInt(round(powR))
    if hasSigned then
      if TryPowVerifyIntExponentExact(valueInt, powResult, nExp) = FALSE then return FALSE
      ValueSetInt64(outV, powResult)
      return TRUE
    elseif hasUInt then
      dim recon as ULongInt
      if TryPowULong(inpU, CULngInt(nExp), recon) = FALSE orelse recon <> CULngInt(powResult) then return FALSE
      if CULngInt(powResult) <= FB_I64_MAX_U then
        ValueSetInt64(outV, powResult)
      else
        ValueSetUInt64(outV, CULngInt(powResult))
      end if
      return TRUE
    end if
  end if
  return FALSE
end function

private function TryNegateExactCartesianComponent(byref c as ExactCartesianComponent, byref outC as ExactCartesianComponent) as Boolean
  dim i as LongInt
  if TryExactCartesianComponentToInt64(c, i) then
    if i = FB_I64_MIN then return FALSE
    ExactCartesianComponentAssignFromSignedInt64(outC, -i)
    return TRUE
  end if
  if c.hasUInt <> 0 then return FALSE
  ExactCartesianComponentAssignFromSignedInt64(outC, 0)
  return TRUE
end function

private function TryNegateExactComplexScalar(byref sv as ScalarValue, byref outV as EvalValue) as Boolean
  if ScalarHasNonzeroImaginaryPart(sv) = FALSE then return FALSE
  dim lRe as ExactCartesianComponent
  dim lIm as ExactCartesianComponent
  dim oRe as ExactCartesianComponent
  dim oIm as ExactCartesianComponent
  if TryExtractExactRealComponent(sv, lRe) = FALSE then return FALSE
  if TryExtractExactImagComponent(sv, lIm) = FALSE then return FALSE
  if TryNegateExactCartesianComponent(lRe, oRe) = FALSE then return FALSE
  if TryNegateExactCartesianComponent(lIm, oIm) = FALSE then return FALSE
  ValueSetScalarComplexFromExactCartesian(outV, oRe, oIm)
  return TRUE
end function

'' Unary minus on exact int64/uint64/complex scalars (avoids float multiply for large magnitudes).
private function TryNegateEvalScalarUnary(byref v as EvalValue, byref outV as EvalValue) as Boolean
  if v.kind <> VK_SCALAR then return FALSE
  if TryNegateExactComplexScalar(v.scalarValue, outV) then return TRUE
  if Parser_SupportComplexNumbers andalso ScalarHasNonzeroImaginaryPart(v.scalarValue) then
    ' Complex scalar: don't fall through to plain int64/uint64 negation
    ' that would discard NaN/Inf imaginary components.
    return FALSE
  end if
  if ScalarExactInt64Valid(v.scalarValue) orelse v.scalarValue.scalarStorageKind = SSK_INT64 then
    if v.scalarValue.exactInt64 = FB_I64_MIN then return FALSE
    ValueSetInt64(outV, -v.scalarValue.exactInt64)
    return TRUE
  end if
  if ScalarExactUInt64Valid(v.scalarValue) orelse v.scalarValue.scalarStorageKind = SSK_UINT64 then
    dim u as ULongInt = v.scalarValue.exactUInt64
    if u = 0ull then
      ValueSetInt64(outV, 0)
      return TRUE
    end if
    if u = FB_I64_MIN_MAG_U then
      ValueSetInt64(outV, FB_I64_MIN)
      return TRUE
    end if
    if u <= FB_I64_MAX_U then
      ValueSetInt64(outV, -CLngInt(u))
      return TRUE
    end if
    ValueSetScalar(outV, -CDbl(u))
    return TRUE
  end if
  return FALSE
end function

private sub CalcRoundingFnCartesian(byval fnId as Integer, byref scalarV as ScalarValue, byval ar as Double, byval ai as Double, byref outV as EvalValue)
  dim svRe as ScalarValue = scalarV
  svRe.scalar = ar
  ScalarClearImag(svRe)
  dim svImOnly as ScalarValue
  svImOnly.scalar = ai
  ScalarClearImag(svImOnly)
  if ScalarImagExactInt64Valid(scalarV) then
    svImOnly.exactInt64Valid = TRUE
    svImOnly.exactInt64 = scalarV.imagExactInt64
    if ScalarImagExactUInt64Valid(scalarV) then
      svImOnly.exactUInt64Valid = TRUE
      svImOnly.exactUInt64 = scalarV.imagExactUInt64
    end if
  end if
  dim outRe as EvalValue
  dim outIm as EvalValue
  calcRoundingFn(fnId, svRe, outRe)
  calcRoundingFn(fnId, svImOnly, outIm)
  ValueSetScalarComplexFromEvalRealImagParts(outV, outRe, outIm)
end sub

private function TryApplyFactorialScalarInt(byval n as LongInt, byref outV as EvalValue) as Boolean
  if n < 0 then return FALSE
  static factTable(0 to 20) as LongInt = { _
    1ll, 1ll, 2ll, 6ll, 24ll, 120ll, 720ll, 5040ll, 40320ll, 362880ll, _
    3628800ll, 39916800ll, 479001600ll, 6227020800ll, 87178291200ll, 1307674368000ll, _
    20922789888000ll, 355687428096000ll, 6402373705728000ll, 121645100408832000ll, 2432902008176640000ll }
  if n <= 20 then
    ValueSetInt64(outV, factTable(n))
    return TRUE
  end if
  dim d as Double = CDbl(factTable(20))
  dim fi as LongInt
  for fi = 21 to n
    d *= CDbl(fi)
    if IsNonFiniteValue(d) then exit for
  next fi
  ValueSetScalar(outV, d)
  return TRUE
end function

private function ApplyUnaryBuiltin(byval fnId as Integer, byref scalarV as ScalarValue, byref outV as EvalValue) as Boolean
  if ApplyUnaryComplexSupportScalars(fnId, scalarV, outV) then return TRUE
  if TryApplyUnaryComplexMathOverlay(fnId, scalarV, outV) then return TRUE
  return TryApplyUnaryRealByKind(fnId, scalarV, outV)
end function

private function ApplyUnaryComplexSupportScalars(byval fnId as Integer, byref scalarV as ScalarValue, byref outV as EvalValue) as Boolean
  dim isCxComponentUnary as Boolean = (fnId = FUNC_REAL) orelse (fnId = FUNC_IMAG) orelse (fnId = FUNC_PHASE) orelse (fnId = FUNC_POLAR) orelse (fnId = FUNC_CART) orelse (fnId = FUNC_CONJ)
  if Parser_SupportComplexNumbers = FALSE then
    if isCxComponentUnary = FALSE then return FALSE
  end if

  dim ar as Double
  dim ai as Double
  ScalarLoadCartesian(scalarV, ar, ai)
  if Parser_SupportComplexNumbers = FALSE andalso ScalarHasNonzeroImaginaryPart(scalarV) then return FALSE

  select case fnId
    case FUNC_REAL
      dim cRe as ExactCartesianComponent
      if TryExtractExactRealComponent(scalarV, cRe) then
        ValueSetScalarFromExactCartesianComponent(outV, cRe)
      else
        ValueSetScalar(outV, ar)
        ScalarClearImag(outV.scalarValue)
      end if
    case FUNC_IMAG
      dim cIm as ExactCartesianComponent
      if Parser_SupportComplexNumbers andalso TryExtractExactImagComponent(scalarV, cIm) then
        ValueSetScalarFromExactCartesianComponent(outV, cIm)
      else
        ValueSetScalar(outV, ai)
        ScalarClearImag(outV.scalarValue)
      end if
    case FUNC_PHASE
      ValueSetScalar(outV, CalcAtan2(ai, ar))
    case FUNC_POLAR
      dim polarVals(0 to 1) as ScalarValue
      polarVals(0).scalar = CalcHypot(ar, ai)
      polarVals(1).scalar = CalcAtan2(ai, ar)
      ValueSetArrayFromScalarValues(outV, polarVals())
    case FUNC_CART
      if Parser_SupportComplexNumbers then
        dim cReCart as ExactCartesianComponent
        dim cImCart as ExactCartesianComponent
        if TryExtractExactRealComponent(scalarV, cReCart) andalso TryExtractExactImagComponent(scalarV, cImCart) then
          ValueSetScalarComplexFromExactCartesian(outV, cReCart, cImCart)
        else
          ValueSetScalarComplexFromDoubles(outV, ar, ai)
        end if
      else
        ValueSetScalar(outV, ar)
        ScalarClearImag(outV.scalarValue)
      end if
    case FUNC_CONJ
      if Parser_SupportComplexNumbers then
        dim cRe as ExactCartesianComponent
        dim cIm as ExactCartesianComponent
        dim cImConj as ExactCartesianComponent
        if TryExtractExactRealComponent(scalarV, cRe) andalso TryExtractExactImagComponent(scalarV, cIm) then
          if ScalarHasNonzeroImaginaryPart(scalarV) andalso TryNegateExactCartesianComponent(cIm, cImConj) = FALSE then
            ValueSetScalarComplexFromDoubles(outV, ar, -ai)
          else
            if ScalarHasNonzeroImaginaryPart(scalarV) then
              ValueSetScalarComplexFromExactCartesian(outV, cRe, cImConj)
            else
              ValueSetScalarComplexFromExactCartesian(outV, cRe, cIm)
            end if
          end if
        else
          ValueSetScalarComplexFromDoubles(outV, ar, -ai)
        end if
      else
        ValueSetScalar(outV, ar)
        ScalarClearImag(outV.scalarValue)
      end if
    case FUNC_INT, FUNC_TRUNC, FUNC_FLOOR, FUNC_CEIL, FUNC_ROUND
      if Parser_SupportComplexNumbers = FALSE then return FALSE
      CalcRoundingFnCartesian(fnId, scalarV, ar, ai, outV)
    case FUNC_FRAC
      if Parser_SupportComplexNumbers = FALSE then return FALSE
      dim svFracRe as ScalarValue = scalarV
      svFracRe.scalar = ar
      ScalarClearImag(svFracRe)
      dim svFracIm as ScalarValue
      svFracIm.scalar = ai
      ScalarClearImag(svFracIm)
      if ScalarImagExactInt64Valid(scalarV) then
        svFracIm.exactInt64Valid = TRUE
        svFracIm.exactInt64 = scalarV.imagExactInt64
        if ScalarImagExactUInt64Valid(scalarV) then
          svFracIm.exactUInt64Valid = TRUE
          svFracIm.exactUInt64 = scalarV.imagExactUInt64
        end if
      end if
      dim fracIntRe as EvalValue
      dim fracIntIm as EvalValue
      calcRoundingFn(FUNC_INT, svFracRe, fracIntRe)
      calcRoundingFn(FUNC_INT, svFracIm, fracIntIm)
      dim fracOutRe as EvalValue
      dim fracOutIm as EvalValue
      ValueSetScalar(fracOutRe, ar - fracIntRe.scalar)
      ValueSetScalar(fracOutIm, ai - fracIntIm.scalar)
      ValueSetScalarComplexFromEvalRealImagParts(outV, fracOutRe, fracOutIm)
    case FUNC_ABS
      if ScalarHasNonzeroImaginaryPart(scalarV) = FALSE then
        return ApplyAbsScalarValue(scalarV, outV)
      end if
      if Parser_SupportComplexNumbers = FALSE then return FALSE
      if IsNaNValue(ar) orelse IsNaNValue(ai) then
        ValueSetScalar(outV, MakeNaN())
      else
        ValueSetScalar(outV, CalcHypot(ar, ai))
      end if
    case FUNC_SIGN
      if Parser_SupportComplexNumbers = FALSE then return FALSE
      dim mag as Double = CalcHypot(ar, ai)
      dim isMagZero as Boolean = (mag = 0.0)
      if isMagZero orElse IsNaNValue(mag) orElse IsNaNValue(ar) orElse IsNaNValue(ai) then
        ValueSetScalarComplexFromDoubles(outV, 0.0, 0.0)
      else
        ValueSetScalarComplexFromDoubles(outV, ar / mag, ai / mag)
      end if
    case FUNC_FACT
      if Parser_SupportComplexNumbers = FALSE andalso ScalarHasNonzeroImaginaryPart(scalarV) then return FALSE
      if ai = 0.0 andalso ScalarHasNonzeroImaginaryPart(scalarV) = FALSE then
        dim nFact as LongInt
        if TryGetExactInt64Scalar(scalarV, nFact) andalso nFact >= 0 then
          if TryApplyFactorialScalarInt(nFact, outV) then return TRUE
        end if
      end if
      if Parser_SupportComplexNumbers = FALSE then return FALSE
      dim gr as Double
      dim gi as Double
      if ScalarComplexGamma(ar + 1.0, ai, gr, gi) = FALSE then return FALSE
      ValueSetScalarComplexFromDoubles(outV, gr, gi)
    case else
      return FALSE
  end select
  return TRUE
end function

private sub ScalarComplexPowPrincipal(byval ar as Double, byval ai as Double, byval br as Double, byval bi as Double, byref outR as Double, byref outI as Double)
  if IsNaNValue(ar) orelse IsNaNValue(ai) orelse IsNaNValue(br) orelse IsNaNValue(bi) then
    outR = MakeNaN()
    outI = MakeNaN()
    exit sub
  end if
  dim mag as Double = CalcHypot(ar, ai)
  if mag = 0.0 then
    if br = 0.0 andalso bi = 0.0 then
      outR = 1.0
      outI = 0.0
    elseif br > 0.0 then
      outR = 0.0
      outI = 0.0
    elseif br = 0.0 andalso bi <> 0.0 then
      outR = 0.0
      outI = 0.0
    else
      outR = MakeNaN()
      outI = MakeNaN()
    end if
    exit sub
  end if
  const epsPow as Double = 1e-14
  if abs(bi) < epsPow then
    dim nRootFrac as LongInt
    if FractionalPowerResolveRootDegree(br, nRootFrac) then
      ScalarComplexCartesianPrincipalNthRoot(ar, ai, 1.0 / CDbl(nRootFrac), outR, outI)
      exit sub
    end if
    if abs(br - Fix(br)) < 1e-12 then
      dim n as LongInt = CLngInt(Fix(br))
      if abs(n) <= 256 then
        if n >= 0 then
          ScalarComplexPowIntegerNonneg ar, ai, n, outR, outI
        else
          dim pr as Double, pi as Double
          ScalarComplexPowIntegerNonneg ar, ai, -n, pr, pi
          dim den as Double = pr * pr + pi * pi
          if den = 0.0 then
            outR = MakeNaN()
            outI = MakeNaN()
          else
            outR = pr / den
            outI = (-pi) / den
          end if
        end if
        if IsNaNValue(outR) = FALSE andalso IsNaNValue(outI) = FALSE then
          ScalarSnapComplexNearZeroAxis(outR, outI)
        end if
        exit sub
      end if
    end if
  end if
  dim loR as Double = log(mag)
  dim loI as Double = CalcAtan2(ai, ar)
  dim powRe as Double = br * loR - bi * loI
  dim powIm as Double = br * loI + bi * loR
  if IsTrigRadiansInRange(powIm) = FALSE then
    outR = MakeNaN()
    outI = MakeNaN()
    exit sub
  end if
  dim er as Double = exp(powRe) * CalcCos(powIm)
  dim ei as Double = exp(powRe) * CalcSin(powIm)
  outR = er
  outI = ei
  ScalarSnapComplexNearZeroAxis(outR, outI)
end sub

private sub ApplyComplexCaretPrincipalEval(byref leftS as ScalarValue, byref rightS as ScalarValue, byref outV as EvalValue)
  if TryApplyScalarPowSpecialPaths(leftS, rightS, outV) then exit sub
  dim ar as Double
  dim ai as Double
  dim br as Double
  dim bi as Double
  ScalarLoadCartesian(leftS, ar, ai)
  ScalarLoadCartesian(rightS, br, bi)
  dim powR as Double
  dim powI as Double
  ScalarComplexPowPrincipal(ar, ai, br, bi, powR, powI)
  if TryRefinePowPrincipalToExactScalarResult(leftS, rightS, powR, powI, outV) then exit sub
  ValueSetScalarComplexFromDoubles(outV, powR, powI)
end sub

private function ComplexNeedsPrincipalNegRealPow(byval ar as Double, byval ai as Double, byval br as Double, byval bi as Double) as Boolean
  if ai <> 0.0 orelse bi <> 0.0 then return FALSE
  if ar >= 0.0 then return FALSE
  if IsNonFiniteValue(ar) orelse IsNonFiniteValue(br) then return FALSE
  if abs(br - Fix(br)) < 1e-12 then return FALSE
  return TRUE
end function

private sub ScalarComplexCartesianBinary(byval ar as Double, byval ai as Double, byval br as Double, byval bi as Double, byval op as UByte, byref outR as Double, byref outI as Double)
  select case op
  case CHAR_PLUS
    outR = ar + br
    outI = ai + bi
  case CHAR_MINUS
    outR = ar - br
    outI = ai - bi
  case CHAR_ASTERISK
    ScalarComplexCartesianMul(ar, ai, br, bi, outR, outI)
  case CHAR_DIVIDE
    ScalarComplexDivide(ar, ai, br, bi, outR, outI)
  end select
end sub

private function ValueApplyBinaryScalarsComplex(byref leftS as ScalarValue, byref rightS as ScalarValue, byval op as UByte, byref outV as EvalValue) as Boolean
  if Parser_SupportComplexNumbers = FALSE then return FALSE
  select case op
    case CHAR_PLUS, CHAR_MINUS, CHAR_ASTERISK, CHAR_DIVIDE, CHAR_CARET
    case else
      return FALSE
  end select

  dim ar as Double, ai as Double, br as Double, bi as Double
  ScalarLoadCartesian(leftS, ar, ai)
  ScalarLoadCartesian(rightS, br, bi)

  if op = CHAR_CARET then
    ApplyComplexCaretPrincipalEval(leftS, rightS, outV)
    return TRUE
  end if

  if op = CHAR_PLUS orelse op = CHAR_MINUS orelse op = CHAR_ASTERISK orelse op = CHAR_DIVIDE then
    if TryApplyExactComplexCartesianBinary(leftS, rightS, op, outV) then return TRUE
  end if

  if op = CHAR_PLUS then
    if ScalarHasNonzeroImaginaryPart(leftS) = FALSE andalso ScalarHasNonzeroImaginaryPart(rightS) = FALSE then
      dim lr as LongInt, rr as LongInt, ssum as LongInt
      if TryGetExactInt64Scalar(leftS, lr) andalso TryGetExactInt64Scalar(rightS, rr) then
        if TryAddInt64(lr, rr, ssum) then
          ValueSetInt64(outV, ssum)
          return TRUE
        end if
      end if
    end if
  end if

  dim floatR as Double
  dim floatI as Double
  ScalarComplexCartesianBinary(ar, ai, br, bi, op, floatR, floatI)
  outV.scalarValue.flags and= not CUInt(SVF_RENDER_RATIONAL or SVF_IMAG_RENDER_RATIONAL or SVF_RENDER_INT_POWER)
  ValueSetScalarComplexFromDoubles(outV, floatR, floatI)
  return TRUE
end function

private function TryApplyExactUInt64BinaryScalarOp(byval op as UByte, byval lu as ULongInt, byval ru as ULongInt, byref outV as EvalValue) as Boolean
  select case op
    case CHAR_PLUS
      dim outU as ULongInt
      if TryAddULongChecked(lu, ru, outU) then ValueSetUInt64(outV, outU): return TRUE
    case CHAR_MINUS
      if lu >= ru then ValueSetUInt64(outV, lu - ru): return TRUE
    case CHAR_ASTERISK
      dim outU as ULongInt
      if TryMulULongChecked(lu, ru, outU) then ValueSetUInt64(outV, outU): return TRUE
    case CHAR_DIVIDE
      dim quoU as ULongInt
      if TryQuotExactULong(lu, ru, quoU) then ValueSetUInt64(outV, quoU): return TRUE
  end select
  return FALSE
end function

private function ValueApplyBinaryScalars(byref leftS as ScalarValue, byref rightS as ScalarValue, byval op as UByte, byref outV as EvalValue) as Boolean
  if op = CHAR_CARET then
    if TryApplyScalarPowSpecialPaths(leftS, rightS, outV) then return TRUE
  end if
  if Parser_SupportComplexNumbers then
    if ScalarHasNonzeroImaginaryPart(leftS) orelse ScalarHasNonzeroImaginaryPart(rightS) then
      return ValueApplyBinaryScalarsComplex(leftS, rightS, op, outV)
    elseif op = CHAR_CARET then
      dim arP as Double, aiP as Double, brP as Double, biP as Double
      ScalarLoadCartesian(leftS, arP, aiP)
      ScalarLoadCartesian(rightS, brP, biP)
      if ComplexNeedsPrincipalNegRealPow(arP, aiP, brP, biP) then
        return ValueApplyBinaryScalarsComplex(leftS, rightS, op, outV)
      end if
    end if
  end if

  dim li as LongInt, ri as LongInt, ro as LongInt
  dim hasUIntL as Boolean
  dim hasUIntR as Boolean
  dim lu as ULongInt, ru as ULongInt
  hasUIntL = TryGetExactNonNegativeUInt64Scalar(leftS, lu)
  hasUIntR = TryGetExactNonNegativeUInt64Scalar(rightS, ru)
  if ScalarExactUInt64Valid(leftS) andalso ScalarExactUInt64Valid(rightS) _
    andalso (ScalarExactInt64Valid(leftS) = FALSE orelse ScalarExactInt64Valid(rightS) = FALSE) then
    if TryApplyExactUInt64BinaryScalarOp(op, leftS.exactUInt64, rightS.exactUInt64, outV) then return TRUE
  end if

  dim hasIntL as Boolean = ScalarExactInt64Valid(leftS)
  dim hasIntR as Boolean = ScalarExactInt64Valid(rightS)
  if hasIntL then
    li = leftS.exactInt64
  elseif ScalarExactUInt64Valid(leftS) andalso leftS.exactUInt64 <= FB_I64_MAX_U then
    hasIntL = TRUE
    li = CLngInt(leftS.exactUInt64)
  end if
  if hasIntR then
    ri = rightS.exactInt64
  elseif ScalarExactUInt64Valid(rightS) andalso rightS.exactUInt64 <= FB_I64_MAX_U then
    hasIntR = TRUE
    ri = CLngInt(rightS.exactUInt64)
  end if
  if op = CHAR_CARET then
    if hasUIntL andalso hasUIntR then
      dim powU as ULongInt
      if TryPowULong(lu, ru, powU) then ValueSetUInt64(outV, powU): return TRUE
    end if
    if hasIntL andalso hasUIntR andalso li < 0 then
      dim baseMag as ULongInt
      if li = FB_I64_MIN then
        baseMag = FB_I64_MIN_MAG_U
      else
        baseMag = CULngInt(-li)
      end if
      dim powMag as ULongInt
      if TryPowULong(baseMag, ru, powMag) then
        if (ru and 1ull) = 0ull then
          ValueSetUInt64(outV, powMag)
          return TRUE
        elseif powMag <= FB_I64_MIN_MAG_U then
          if powMag = FB_I64_MIN_MAG_U then
            ValueSetInt64(outV, FB_I64_MIN)
          else
            ValueSetInt64(outV, -CLngInt(powMag))
          end if
          return TRUE
        end if
      end if
    end if
  end if
  if hasIntL andalso hasIntR then
    select case op
      case CHAR_ASTERISK
        if TryMulInt64(li, ri, ro) then ValueSetInt64(outV, ro): return TRUE
      case CHAR_PLUS
        if TryAddInt64(li, ri, ro) then ValueSetInt64(outV, ro): return TRUE
      case CHAR_MINUS
        if TrySubInt64(li, ri, ro) then ValueSetInt64(outV, ro): return TRUE
      case CHAR_CARET
        if TryPowInt64(li, ri, ro) then ValueSetInt64(outV, ro): return TRUE
      case CHAR_DIVIDE
        if TryQuotExactInt64(li, ri, ro) then ValueSetInt64(outV, ro): return TRUE
    end select
  end if

  if hasUIntL andalso hasUIntR then
    if (op = CHAR_PLUS) orelse (op = CHAR_ASTERISK) orelse (op = CHAR_DIVIDE) then
      if TryApplyExactUInt64BinaryScalarOp(op, lu, ru, outV) then return TRUE
    end if
  end if

  select case op
    case CHAR_ASTERISK
      dim r as Double = leftS.scalar * rightS.scalar
      if TryApplyExactIntegerMultiplicationFromProduct(leftS, rightS, r, outV) = FALSE then
        ValueSetScalar(outV, r)
      end if
    case CHAR_DIVIDE
      if rightS.scalar = 0 andalso leftS.scalar = 0 then
        ValueSetScalar(outV, MakeNaN())
      else
        dim r as Double = leftS.scalar / rightS.scalar
        if TryApplyExactIntegerDivisionFromQuotient(leftS, rightS, r, outV) = FALSE then
          ValueSetScalar(outV, r)
        end if
      end if
    case CHAR_PLUS: ValueSetScalar(outV, leftS.scalar + rightS.scalar)
    case CHAR_MINUS: ValueSetScalar(outV, leftS.scalar - rightS.scalar)
    case CHAR_CARET
      ValueSetScalar(outV, leftS.scalar ^ rightS.scalar)
    case else: return FALSE
  end select
  return TRUE
end function

declare function ValueApplyBinaryInt64Scalars(byref leftS as ScalarValue, byref rightS as ScalarValue, byval op as OperatorBitNameId, byref outV as EvalValue) as Boolean
declare function ApplyScalarBinaryMathFunctionScalars(byref leftS as ScalarValue, byref rightS as ScalarValue, byval fnId as Integer, byref outV as EvalValue) as Boolean

private const MAP_BINARY_OP_NUMERIC as Integer = 1
private const MAP_BINARY_OP_INT64 as Integer = 2
private const MAP_BINARY_OP_SCALAR_MATH as Integer = 3

private const BSD_NUMERIC as Integer = 1
private const BSD_INT64 as Integer = 2
private const BSD_SCALAR_MATH as Integer = 3

declare function ValueApplyBinaryTimeAware(byref leftV as EvalValue, byref rightV as EvalValue, byval op as UByte, byref outV as EvalValue) as Boolean

declare function MapBinaryBroadcastScalarsImpl( _
  byval useTimeOps as Boolean, _
  byval mode as Integer, _
  byref leftV as EvalValue, _
  byref rightV as EvalValue, _
  byval op as UByte, _
  byval intOp as OperatorBitNameId, _
  byval fnId as Integer, _
  byref outV as EvalValue) as Boolean

private function RejectInt64BinaryOperands(byref leftV as EvalValue, byref rightV as EvalValue, byval isModulo as Boolean) as Boolean
  if Parser_SupportTimeValues then
    if EvalValueInvolvesTime(leftV) orelse EvalValueInvolvesTime(rightV) then
      if isModulo then
        SetParseErrorById(PARSE_ERR_MODULO_INTEGER_OPERANDS)
      else
        SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      end if
      return TRUE
    end if
  end if
  if Parser_SupportComplexNumbers then
    if EvalValueHasNonzeroImaginary(leftV) orelse EvalValueHasNonzeroImaginary(rightV) then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return TRUE
    end if
  end if
  return FALSE
end function

private function ApplyBinaryEvalPolicy(byval kind as Integer, byref leftV as EvalValue, byref rightV as EvalValue, byval op as UByte, byval intOp as OperatorBitNameId, byval fnId as Integer, byref outV as EvalValue, byval tryTimeFirst as Boolean) as Boolean
  if tryTimeFirst then
    if ValueApplyBinaryTimeAware(leftV, rightV, op, outV) then
      return (parseError = 0)
    end if
  end if
  if kind = BSD_INT64 then
    if RejectInt64BinaryOperands(leftV, rightV, intOp = OP_BIT_MOD) then
      return FALSE
    end if
  end if
  dim mode as Integer = MAP_BINARY_OP_NUMERIC
  select case kind
    case BSD_NUMERIC: mode = MAP_BINARY_OP_NUMERIC
    case BSD_INT64: mode = MAP_BINARY_OP_INT64
    case BSD_SCALAR_MATH: mode = MAP_BINARY_OP_SCALAR_MATH
    case else: return FALSE
  end select
  return MapBinaryBroadcastScalarsImpl(FALSE, mode, leftV, rightV, op, intOp, fnId, outV)
end function

private function TryMapBinaryPair(byval mode as Integer, byref leftS as ScalarValue, byref rightS as ScalarValue, byval op as UByte, byval intOp as OperatorBitNameId, byval fnId as Integer, byref outV as EvalValue) as Boolean
  select case mode
    case MAP_BINARY_OP_NUMERIC
      return ValueApplyBinaryScalars(leftS, rightS, op, outV)
    case MAP_BINARY_OP_INT64
      return ValueApplyBinaryInt64Scalars(leftS, rightS, intOp, outV)
    case MAP_BINARY_OP_SCALAR_MATH
      return ApplyScalarBinaryMathFunctionScalars(leftS, rightS, fnId, outV)
  end select
  return FALSE
end function

private function MapBinaryBroadcastPair(byval useTimeOps as Boolean, byval mode as Integer, byref leftS as ScalarValue, byref rightS as ScalarValue, byval op as UByte, byval intOp as OperatorBitNameId, byval fnId as Integer, byref outV as EvalValue) as Boolean
  if useTimeOps then
    return ApplyTimeBinaryScalars(leftS, rightS, op, outV)
  end if
  return TryMapBinaryPair(mode, leftS, rightS, op, intOp, fnId, outV)
end function

private function MapBinaryBroadcastArrayPair(byval useTimeOps as Boolean, byval mode as Integer, byref leftArr as EvalValue, byref rightArr as EvalValue, byval op as UByte, byval intOp as OperatorBitNameId, byval fnId as Integer, byref outV as EvalValue) as Boolean
  if ValueArrayLen(leftArr) <> ValueArrayLen(rightArr) then return FALSE
  dim lb as Integer = lbound(leftArr.arr)
  dim ub as Integer = ubound(leftArr.arr)
  ValueInitArrayLike(outV, lb, ub)
  for i as Integer = lb to ub
    dim r as EvalValue
    if MapBinaryBroadcastPair(useTimeOps, mode, leftArr.arr(i), rightArr.arr(i), op, intOp, fnId, r) = FALSE then return FALSE
    ValueSetArrayElemFromScalar(outV, i, r)
  next i
  return TRUE
end function

private function MapBinaryBroadcastArrayScalar(byval useTimeOps as Boolean, byval mode as Integer, byref arrV as EvalValue, byref scalarS as ScalarValue, byval scalarOnLeft as Boolean, byval op as UByte, byval intOp as OperatorBitNameId, byval fnId as Integer, byref outV as EvalValue) as Boolean
  dim lb as Integer = lbound(arrV.arr)
  dim ub as Integer = ubound(arrV.arr)
  ValueInitArrayLike(outV, lb, ub)
  for i as Integer = lb to ub
    dim r as EvalValue
    dim ok as Boolean
    if scalarOnLeft then
      ok = MapBinaryBroadcastPair(useTimeOps, mode, scalarS, arrV.arr(i), op, intOp, fnId, r)
    else
      ok = MapBinaryBroadcastPair(useTimeOps, mode, arrV.arr(i), scalarS, op, intOp, fnId, r)
    end if
    if ok = FALSE then return FALSE
    ValueSetArrayElemFromScalar(outV, i, r)
  next i
  return TRUE
end function

private function MapBinaryBroadcastScalarsImpl(byval useTimeOps as Boolean, byval mode as Integer, byref leftV as EvalValue, byref rightV as EvalValue, byval op as UByte, byval intOp as OperatorBitNameId, byval fnId as Integer, byref outV as EvalValue) as Boolean
  if leftV.kind = VK_SCALAR andalso rightV.kind = VK_SCALAR then
    return MapBinaryBroadcastPair(useTimeOps, mode, leftV.scalarValue, rightV.scalarValue, op, intOp, fnId, outV)
  end if
  if leftV.kind = VK_ARRAY andalso rightV.kind = VK_ARRAY then
    return MapBinaryBroadcastArrayPair(useTimeOps, mode, leftV, rightV, op, intOp, fnId, outV)
  end if
  if leftV.kind = VK_ARRAY then
    return MapBinaryBroadcastArrayScalar(useTimeOps, mode, leftV, rightV.scalarValue, FALSE, op, intOp, fnId, outV)
  end if
  return MapBinaryBroadcastArrayScalar(useTimeOps, mode, rightV, leftV.scalarValue, TRUE, op, intOp, fnId, outV)
end function

private function MapTimeBinaryBroadcastScalars(byref leftV as EvalValue, byref rightV as EvalValue, byval op as UByte, byref outV as EvalValue) as Boolean
  return MapBinaryBroadcastScalarsImpl(TRUE, MAP_BINARY_OP_NUMERIC, leftV, rightV, op, OP_BIT_NONE, -1, outV)
end function

private function ApplyTimeBinaryScalars(byref leftS as ScalarValue, byref rightS as ScalarValue, byval op as UByte, byref outV as EvalValue) as Boolean
  if ScalarHasNonzeroImaginaryPart(leftS) orelse ScalarHasNonzeroImaginaryPart(rightS) then return FALSE
  dim lt as Boolean = ScalarIsTime(leftS)
  dim rt as Boolean = ScalarIsTime(rightS)
  if lt = FALSE andalso rt = FALSE then return FALSE

  if (lt = FALSE andalso IsNonFiniteValue(leftS.scalar)) orelse (rt = FALSE andalso IsNonFiniteValue(rightS.scalar)) then
    SetTimeNonFiniteError()
    return FALSE
  end if

  dim lms as LongInt
  dim rms as LongInt
  dim outMs as LongInt

  if lt then
    lms = TimeTotalMsFromScalarValue(leftS)
  else
    lms = RoundHalfUpDoubleToLongInt(leftS.scalar * 1000.0)
  end if
  if rt then
    rms = TimeTotalMsFromScalarValue(rightS)
  else
    rms = RoundHalfUpDoubleToLongInt(rightS.scalar * 1000.0)
  end if

  select case op
    case CHAR_PLUS
      if TryAddTimeMsChecked(lms, rms, outMs) = FALSE then return FALSE
      ValueSetTimeMs(outV, outMs)
      return TRUE
    case CHAR_MINUS
      if TrySubTimeMsChecked(lms, rms, outMs) = FALSE then return FALSE
      ValueSetTimeMs(outV, outMs)
      return TRUE
    case CHAR_ASTERISK
      if lt andalso rt then
        return FALSE
      else
        dim mult as Double
        dim baseMs as LongInt
        if lt then
          baseMs = lms
          mult = rightS.scalar
        else
          baseMs = rms
          mult = leftS.scalar
        end if
        if IsNonFiniteValue(mult) then return FALSE
        dim tMul as Double = CDbl(baseMs) * mult
        if tMul < CDbl(FB_I64_MIN) orelse tMul > CDbl(FB_I64_MAX) then return FALSE
        ValueSetTimeMs(outV, RoundHalfUpDoubleToLongInt(tMul))
        return TRUE
      end if
    case CHAR_DIVIDE
      if lt andalso rt then
        if rms = 0 then return FALSE
        dim ratio as Double = (CDbl(lms) / 1000.0) / (CDbl(rms) / 1000.0)
        if IsNonFiniteValue(ratio) then return FALSE
        ValueSetScalar(outV, ratio)
        return TRUE
      elseif lt andalso rt = FALSE then
        if rightS.scalar = 0.0 then return FALSE
        dim td as Double = (CDbl(lms) / 1000.0) / rightS.scalar
        if IsNonFiniteValue(td) then return FALSE
        if td < CDbl(FB_I64_MIN) orelse td > CDbl(FB_I64_MAX) then return FALSE
        ValueSetTimeMs(outV, RoundHalfUpDoubleToLongInt(td * 1000.0))
        return TRUE
      else
        return FALSE
      end if
  end select
  return FALSE
end function

private function ValueApplyBinaryTimeAware(byref leftV as EvalValue, byref rightV as EvalValue, byval op as UByte, byref outV as EvalValue) as Boolean
  if EvalValueInvolvesTime(leftV) = FALSE andalso EvalValueInvolvesTime(rightV) = FALSE then return FALSE
  if op <> CHAR_PLUS andalso op <> CHAR_MINUS andalso op <> CHAR_ASTERISK andalso op <> CHAR_DIVIDE then
    if op = CHAR_PERCENT then
      SetParseErrorById(PARSE_ERR_MODULO_INTEGER_OPERANDS)
    else
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
    end if
    return TRUE
  end if
  if MapTimeBinaryBroadcastScalars(leftV, rightV, op, outV) = FALSE then
    if parseError = 0 then SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
    return TRUE
  end if
  return TRUE
end function

private function ValueApplyBinary(byref leftV as EvalValue, byref rightV as EvalValue, byval op as UByte, byref outV as EvalValue) as Boolean
  return ApplyBinaryEvalPolicy(BSD_NUMERIC, leftV, rightV, op, OP_BIT_NONE, -1, outV, FALSE)
end function

private function ApplyScalarBinaryMathFunctionScalars(byref leftS as ScalarValue, byref rightS as ScalarValue, byval fnId as Integer, byref outV as EvalValue) as Boolean
  if fnId = FUNC_LOG then
    if Parser_SupportComplexNumbers = FALSE then
      if leftS.scalar <= 0 orelse rightS.scalar <= 0 orelse rightS.scalar = 1 then return FALSE
      ValueSetScalar(outV, log(leftS.scalar) / log(rightS.scalar))
      return TRUE
    end if
    dim ar as Double, ai as Double, br as Double, bi as Double
    ScalarLoadCartesian(leftS, ar, ai)
    ScalarLoadCartesian(rightS, br, bi)
    dim pureReal as Boolean
    pureReal = (ScalarHasNonzeroImaginaryPart(leftS) = FALSE andalso ScalarHasNonzeroImaginaryPart(rightS) = FALSE andalso ai = 0.0 andalso bi = 0.0)
    if pureReal andalso ar > 0.0 andalso br > 0.0 andalso br <> 1.0 then
      ValueSetScalar(outV, log(ar) / log(br))
      return TRUE
    end if
    if IsNaNValue(ar) orelse IsNaNValue(ai) orelse IsNaNValue(br) orelse IsNaNValue(bi) then
      ValueSetScalarComplexFromDoubles(outV, MakeNaN(), MakeNaN())
      return TRUE
    end if
    dim lnr as Double, lni as Double, rnr as Double, rni as Double
    ScalarPrincipalLnCartesian ar, ai, lnr, lni
    ScalarPrincipalLnCartesian br, bi, rnr, rni
    dim den as Double = rnr * rnr + rni * rni
    if den = 0.0 then
      ValueSetScalarComplexFromDoubles(outV, MakeNaN(), MakeNaN())
      return TRUE
    end if
    dim outR as Double = (lnr * rnr + lni * rni) / den
    dim outI as Double = (lni * rnr - lnr * rni) / den
    ScalarSnapComplexNearZeroAxis(outR, outI)
    ValueSetScalarComplexFromDoubles(outV, outR, outI)
    return TRUE
  end if
  if fnId = FUNC_ATAN2 then
    if Parser_SupportComplexNumbers andalso (ScalarHasNonzeroImaginaryPart(leftS) orelse ScalarHasNonzeroImaginaryPart(rightS)) then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return TRUE
    end if
    ValueSetScalar(outV, CalcAtan2(leftS.scalar, rightS.scalar))
    return TRUE
  end if
  if fnId = FUNC_HYPOT then
    if Parser_SupportComplexNumbers then
      if ScalarHasNonzeroImaginaryPart(leftS) orelse ScalarHasNonzeroImaginaryPart(rightS) then
        dim ar as Double, ai as Double, br as Double, bi as Double
        ScalarLoadCartesian(leftS, ar, ai)
        ScalarLoadCartesian(rightS, br, bi)
        if IsNaNValue(ar) orelse IsNaNValue(ai) orelse IsNaNValue(br) orelse IsNaNValue(bi) then
          ValueSetScalar(outV, MakeNaN())
          return TRUE
        end if
        dim ml as Double = CalcHypot(ar, ai)
        dim mr as Double = CalcHypot(br, bi)
        ValueSetScalar(outV, CalcHypot(ml, mr))
        return TRUE
      end if
    end if
    if TryApplyHypotExactScalars(leftS, rightS, outV) = FALSE then
      ValueSetScalar(outV, CalcHypot(leftS.scalar, rightS.scalar))
    end if
    return TRUE
  end if
  return FALSE
end function

private function ApplyScalarBinaryMathFunctionValues(byref leftV as EvalValue, byref rightV as EvalValue, byval fnId as Integer, byref outV as EvalValue) as Boolean
  return ApplyBinaryEvalPolicy(BSD_SCALAR_MATH, leftV, rightV, 0, OP_BIT_NONE, fnId, outV, FALSE)
end function

private function TryShiftLeftUInt64MaybeExact( _
  byref outV as EvalValue, _
  byval leftU as ULongInt, _
  byval leftScalar as Double, _
  byval shiftU as ULongInt) as Boolean
  if shiftU > 63ull then return FALSE
  if shiftU > 0ull andalso leftU > (FB_U64_MAX shr CInt(shiftU)) then
    ValueSetScalar(outV, leftScalar * pow(2.0, CDbl(shiftU)))
    return TRUE
  end if
  ValueSetUInt64(outV, leftU shl CInt(shiftU))
  return TRUE
end function

private function ValueApplyBinaryInt64Scalars(byref leftS as ScalarValue, byref rightS as ScalarValue, byval op as OperatorBitNameId, byref outV as EvalValue) as Boolean
  dim requiresIntegers as Boolean = (op = OP_BIT_SHL orelse op = OP_BIT_SHR orelse op = OP_BIT_AND orelse op = OP_BIT_XOR orelse op = OP_BIT_OR orelse op = OP_BIT_MOD)
  dim l as LongInt, r as LongInt

  if op = OP_BIT_SHL then
    dim luShl as ULongInt, ruShl as ULongInt
    if TryGetExactNonNegativeUInt64Scalar(leftS, luShl) andalso TryGetExactNonNegativeUInt64Scalar(rightS, ruShl) then
      return TryShiftLeftUInt64MaybeExact(outV, luShl, leftS.scalar, ruShl)
    end if
  end if

  if leftS.exactUInt64Valid andalso rightS.exactUInt64Valid then
    dim lu as ULongInt = leftS.exactUInt64
    dim ru as ULongInt = rightS.exactUInt64
    select case op
      case OP_BIT_SHL
        return TryShiftLeftUInt64MaybeExact(outV, lu, leftS.scalar, ru)
      case OP_BIT_SHR
        if ru > 63ull then return FALSE
        ValueSetUInt64(outV, lu shr CInt(ru))
        return TRUE
      case OP_BIT_AND
        ValueSetUInt64(outV, lu and ru)
        return TRUE
      case OP_BIT_XOR
        ValueSetUInt64(outV, lu xor ru)
        return TRUE
      case OP_BIT_OR
        ValueSetUInt64(outV, lu or ru)
        return TRUE
      case OP_BIT_MOD
        if ru = 0ull then return FALSE
        ValueSetUInt64(outV, lu mod ru)
        return TRUE
    end select
  end if

  if requiresIntegers then
    if (TryGetExactInt64Scalar(leftS, l) = FALSE) orelse (TryGetExactInt64Scalar(rightS, r) = FALSE) then
      if op = OP_BIT_MOD then
        SetParseErrorById(PARSE_ERR_MODULO_INTEGER_OPERANDS)
      else
        SetParseErrorById(PARSE_ERR_BITWISE_INTEGER_OPERANDS)
      end if
      return FALSE
    end if
  end if

  select case op
    case OP_BIT_SHL
      if r < 0 orelse r > 63 then return FALSE
      ValueSetInt64(outV, l shl r)
    case OP_BIT_SHR
      if r < 0 orelse r > 63 then return FALSE
      ValueSetInt64(outV, l shr r)
    case OP_BIT_AND
      ValueSetInt64(outV, l and r)
    case OP_BIT_XOR
      ValueSetInt64(outV, l xor r)
    case OP_BIT_OR
      ValueSetInt64(outV, l or r)
    case OP_BIT_MOD
      if r = 0 then return FALSE
      ValueSetInt64(outV, l mod r)
    case else
      return FALSE
  end select
  return TRUE
end function

private function ValueApplyBinaryInt64(byref leftV as EvalValue, byref rightV as EvalValue, byval op as OperatorBitNameId, byref outV as EvalValue) as Boolean
  return ApplyBinaryEvalPolicy(BSD_INT64, leftV, rightV, 0, op, -1, outV, FALSE)
end function

private function CmpScalarValuesForCompare(byref sa as ScalarValue, byref sb as ScalarValue, byref cmp as Integer) as Boolean
  dim ta as Boolean = ScalarIsTime(sa)
  dim tb as Boolean = ScalarIsTime(sb)
  dim ha as Boolean = Parser_SupportComplexNumbers andalso ScalarHasNonzeroImaginaryPart(sa)
  dim hb as Boolean = Parser_SupportComplexNumbers andalso ScalarHasNonzeroImaginaryPart(sb)
  if (ha orelse hb) andalso (ta orelse tb) then
    return FALSE
  end if

  if ta orelse tb then
    dim lm as LongInt
    dim rm as LongInt
    if ta then
      lm = TimeTotalMsFromScalarValue(sa)
    elseif ScalarToSecondsMsForTimeOp(sa, lm) = FALSE then
      lm = 0
    end if
    if tb then
      rm = TimeTotalMsFromScalarValue(sb)
    elseif ScalarToSecondsMsForTimeOp(sb, rm) = FALSE then
      rm = 0
    end if
    if lm < rm then
      cmp = -1
    elseif lm > rm then
      cmp = 1
    else
      cmp = 0
    end if
    return TRUE
  end if

  if ha orelse hb then
    dim ar as Double, ai as Double, br as Double, bi as Double
    ScalarLoadCartesian(sa, ar, ai)
    ScalarLoadCartesian(sb, br, bi)
    if IsNaNValue(ar) orelse IsNaNValue(ai) orelse IsNaNValue(br) orelse IsNaNValue(bi) then
      cmp = 1
      return TRUE
    end if
    if ar < br then
      cmp = -1
    elseif ar > br then
      cmp = 1
    elseif ai < bi then
      cmp = -1
    elseif ai > bi then
      cmp = 1
    else
      cmp = 0
    end if
    return TRUE
  end if

  if sa.scalar < sb.scalar then
    cmp = -1
  elseif sa.scalar > sb.scalar then
    cmp = 1
  else
    cmp = 0
  end if
  return TRUE
end function

private function ScalarValuesEqualForCompare(byref a as ScalarValue, byref b as ScalarValue) as Boolean
  dim cmp as Integer
  if CmpScalarValuesForCompare(a, b, cmp) = FALSE then return FALSE
  return (cmp = 0)
end function

private function CompareEvalValues(byref leftV as EvalValue, byref rightV as EvalValue, byref cmp as Integer) as Boolean
  if Parser_SupportComplexNumbers = FALSE then
    if EvalValueHasNonzeroImaginary(leftV) orelse EvalValueHasNonzeroImaginary(rightV) then
      return FALSE
    end if
  end if

  dim na as Integer
  dim nb as Integer
  if leftV.kind = VK_SCALAR then
    na = 1
  else
    na = ValueArrayLen(leftV)
  end if
  if rightV.kind = VK_SCALAR then
    nb = 1
  else
    nb = ValueArrayLen(rightV)
  end if

  dim minLen as Integer = IIf(na < nb, na, nb)
  dim i as Integer
  dim lsv as ScalarValue
  dim rsv as ScalarValue
  dim c as Integer

  for i = 0 to minLen - 1
    if leftV.kind = VK_SCALAR then
      lsv = leftV.scalarValue
    else
      lsv = leftV.arr(lbound(leftV.arr) + i)
    end if
    if rightV.kind = VK_SCALAR then
      rsv = rightV.scalarValue
    else
      rsv = rightV.arr(lbound(rightV.arr) + i)
    end if
    if CmpScalarValuesForCompare(lsv, rsv, c) = FALSE then
      return FALSE
    end if
    if c <> 0 then
      cmp = c
      return TRUE
    end if
  next i

  if na < nb then
    cmp = -1
  elseif na > nb then
    cmp = 1
  else
    cmp = 0
  end if
  return TRUE
end function

private function ApplyComparison(byref leftV as EvalValue, byref rightV as EvalValue, byval op as OperatorCmpNameId, byref outV as EvalValue) as Boolean
  if leftV.kind = VK_SCALAR andalso rightV.kind = VK_SCALAR then
    if ScalarIsTime(leftV.scalarValue) orelse ScalarIsTime(rightV.scalarValue) then
      if (ScalarIsTime(leftV.scalarValue) = FALSE andalso IsNonFiniteValue(leftV.scalar)) orelse _
         (ScalarIsTime(rightV.scalarValue) = FALSE andalso IsNonFiniteValue(rightV.scalar)) then
        SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
        return FALSE
      end if
    end if
  end if
  if Parser_SupportComplexNumbers then
    dim hasIm as Boolean = EvalValueHasNonzeroImaginary(leftV) orelse EvalValueHasNonzeroImaginary(rightV)
    if hasIm then
      select case op
      case OP_CMP_LT, OP_CMP_LE, OP_CMP_GT, OP_CMP_GE
        SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
        return FALSE
      end select
      if EvalValueInvolvesTime(leftV) orelse EvalValueInvolvesTime(rightV) then
        SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
        return FALSE
      end if
    end if
  end if
  '' IEEE: any scalar NaN makes comparisons unordered - only ``!=`` / ``<>`` is true.
  if leftV.kind = VK_SCALAR andalso rightV.kind = VK_SCALAR then
    if Parser_SupportComplexNumbers then
      dim lr as Double, li as Double, rr as Double, ri as Double
      ScalarLoadCartesian(leftV.scalarValue, lr, li)
      ScalarLoadCartesian(rightV.scalarValue, rr, ri)
      if IsNaNValue(lr) orelse IsNaNValue(li) orelse IsNaNValue(rr) orelse IsNaNValue(ri) then
        select case op
        case OP_CMP_NONE
          return FALSE
        case OP_CMP_NE
          ValueSetInt64(outV, 1)
        case else
          ValueSetInt64(outV, 0)
        end select
        return TRUE
      end if
    else
      if IsNaNValue(leftV.scalar) orelse IsNaNValue(rightV.scalar) then
        select case op
        case OP_CMP_NONE
          return FALSE
        case OP_CMP_NE
          ValueSetInt64(outV, 1)
        case else
          ValueSetInt64(outV, 0)
        end select
        return TRUE
      end if
    end if
  end if

  dim cmp as Integer = 0
  if CompareEvalValues(leftV, rightV, cmp) = FALSE then return FALSE
  dim isTrue as Boolean = FALSE
  select case op
    case OP_CMP_EQ
      isTrue = (cmp = 0)
    case OP_CMP_NE
      isTrue = (cmp <> 0)
    case OP_CMP_LT
      isTrue = (cmp < 0)
    case OP_CMP_LE
      isTrue = (cmp <= 0)
    case OP_CMP_GT
      isTrue = (cmp > 0)
    case OP_CMP_GE
      isTrue = (cmp >= 0)
    case else
      return FALSE
  end select
  if isTrue then
    ValueSetInt64(outV, 1)
  else
    ValueSetInt64(outV, 0)
  end if
  return TRUE
end function

private function EvalValueIsTruthy(byref v as EvalValue) as Boolean
  if v.kind = VK_ARRAY then
    return (ValueArrayLen(v) > 0)
  end if
  dim tr as Double
  dim ti as Double
  ScalarLoadCartesian(v.scalarValue, tr, ti)
  if IsNaNValue(tr) orelse IsNaNValue(ti) then return FALSE
  return (tr <> 0.0) orelse (ti <> 0.0)
end function

private sub ValueSetBoolResult(byval b as Boolean, byref outV as EvalValue)
  if b then
    ValueSetInt64(outV, 1)
  else
    ValueSetInt64(outV, 0)
  end if
end sub

private function ApplyInt64ParserOp(byref leftV as EvalValue, byref rightV as EvalValue, byval op as OperatorBitNameId, byref outV as EvalValue) as Boolean
  if ValueApplyBinaryInt64(leftV, rightV, op, outV) = FALSE then
    SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
    return FALSE
  end if
  return TRUE
end function

private function ApplyBinaryParserOp(byref leftV as EvalValue, byref rightV as EvalValue, byval op as UByte, byref outV as EvalValue) as Boolean
  if ApplyBinaryEvalPolicy(BSD_NUMERIC, leftV, rightV, op, OP_BIT_NONE, -1, outV, TRUE) = FALSE then
    SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
    return FALSE
  end if
  return TRUE
end function

private sub ApplyInt64ParserOpInPlace(byref leftV as EvalValue, byref rightV as EvalValue, byval op as OperatorBitNameId)
  dim outV as EvalValue
  if ApplyInt64ParserOp(leftV, rightV, op, outV) then leftV = outV
end sub

private sub ApplyBinaryParserOpInPlace(byref leftV as EvalValue, byref rightV as EvalValue, byval op as UByte)
  dim outV as EvalValue
  if ApplyBinaryParserOp(leftV, rightV, op, outV) then leftV = outV
end sub

private sub ApplyComparisonParserOpInPlace(byref leftV as EvalValue, byref rightV as EvalValue, byval op as OperatorCmpNameId)
  dim outV as EvalValue
  if ApplyComparison(leftV, rightV, op, outV) = FALSE then
    SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
  else
    leftV = outV
  end if
end sub

declare function ArgWalkNextPosition(args() as EvalValue, byref argIdx as Integer, byref elemIdx as Integer, byref srcArgIdx as Integer, byref srcElemIdx as Integer, byref isScalar as Boolean) as Boolean
declare function ArgScalarWalkNext(args() as EvalValue, byref argIdx as Integer, byref elemIdx as Integer, byref outV as Double) as Boolean
declare function ArgScalarValueWalkNext(args() as EvalValue, byref argIdx as Integer, byref elemIdx as Integer, byref outV as ScalarValue) as Boolean

private function TryBuiltinMapBinaryTwoArgCore(args() as EvalValue, byref fnName as String, byval fnId as Integer, byval rejectComplex as Boolean, byref outV as EvalValue) as Boolean
  if EvalValueInvolvesTime(args(0)) orelse EvalValueInvolvesTime(args(1)) then
    SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
    return FALSE
  end if
  if rejectComplex andalso Parser_SupportComplexNumbers then
    if EvalValueHasNonzeroImaginary(args(0)) orelse EvalValueHasNonzeroImaginary(args(1)) then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return FALSE
    end if
  end if
  return ApplyScalarBinaryMathFunctionValues(args(0), args(1), fnId, outV)
end function

private function ArgsContainNonFinite(args() as EvalValue) as Boolean
  dim argIdx as Integer = lbound(args)
  dim elemIdx as Integer = -1
  dim item as Double
  while ArgScalarWalkNext(args(), argIdx, elemIdx, item)
    if IsNonFiniteValue(item) then return TRUE
  wend
  return FALSE
end function

private function ScalarIntegerRepresentableForFormat(byref sv as ScalarValue, byval allowNonFiniteForFormat as Boolean) as Boolean
  dim ar as Double, ai as Double
  ScalarLoadCartesian(sv, ar, ai)

  if IsNonFiniteValue(ar) then
    if allowNonFiniteForFormat = FALSE then return FALSE
  else
    if (sv.exactInt64Valid = FALSE) andalso (sv.exactUInt64Valid = FALSE) then
      dim tmpRe as String
      if FormatHexScalar(ar, tmpRe, TRUE) = FALSE then return FALSE
    end if
  end if

  if Parser_SupportComplexNumbers = FALSE then return TRUE
  if ScalarHasNonzeroImaginaryPart(sv) = FALSE then return TRUE

  if IsNonFiniteValue(ai) then return allowNonFiniteForFormat

  if ScalarImagExactInt64Valid(sv) orelse ScalarImagExactUInt64Valid(sv) then return TRUE

  dim tmpIm as LongInt
  return TryGetExactInt64FromDouble(ai, tmpIm)
end function

private function ValidateIntegerRepresentableArgs(args() as EvalValue, byref fnName as String, byval allowNonFiniteForFormat as Boolean) as Boolean
  dim argIdx as Integer = lbound(args)
  dim elemIdx as Integer = -1
  dim sv as ScalarValue
  while ArgScalarValueWalkNext(args(), argIdx, elemIdx, sv)
    if ScalarIntegerRepresentableForFormat(sv, allowNonFiniteForFormat) = FALSE then
      SetIntegerValuesError(fnName)
      return FALSE
    end if
  wend
  return TRUE
end function

private function ValidateBuiltinCallArgs(byval fnId as Integer, byref fnName as String, args() as EvalValue) as Boolean
  if HasBuiltinFlag(fnId, BUILTIN_FLAG_FORMAT) then
    return ValidateIntegerRepresentableArgs(args(), fnName, TRUE)
  end if
  if HasBuiltinFlag(fnId, BUILTIN_FLAG_INTEGER_ONLY) then
    return ValidateIntegerRepresentableArgs(args(), fnName, FALSE)
  end if
  if HasBuiltinFlag(fnId, BUILTIN_FLAG_NON_CALCULATING) then
    return TRUE
  end if
  if HasBuiltinFlag(fnId, BUILTIN_FLAG_FINITE_REQUIRED) andalso ArgsContainNonFinite(args()) then
    SetNumericErrorInFunction(fnName)
    return FALSE
  end if
  return TRUE
end function

private function IsPercentageTail() as Boolean
  dim p as ZString ptr = pStream
  while (p[0] = CHAR_SPACE) orelse (p[0] = CHAR_TAB) orelse (p[0] = CHAR_LF) orelse (p[0] = CHAR_CR)
    p += 1
  wend

  dim ch as UByte = p[0]
  if (ch = CHAR_NUL) orelse (ch = CHAR_RPAREN) orelse (ch = CHAR_PLUS) orelse (ch = CHAR_MINUS) _
     orelse (ch = CHAR_COMMA) orelse (ch = CHAR_SEMICOLON) orelse (ch = CHAR_RBRACKET) orelse (ch = CHAR_RBRACE) then
    return TRUE
  end if
  return FALSE
end function

private sub TryApplyTightImagSuffixToEvalValue(byref v as EvalValue)
  if Parser_SupportComplexNumbers = FALSE then exit sub
  if pStream[0] = CHAR_LC_I orelse pStream[0] = CHAR_I then
    dim peekIdent as UByte = pStream[1]
    if IsIdentChar(peekIdent) = FALSE then
      pStream += 1
      dim imagV as EvalValue
      ValueSetPureImaginaryFromMagnitudeScalar(imagV, v.scalarValue)
      v = imagV
    end if
  end if
end sub

private sub TryOverrideBareImagUnitIdent(byref v as EvalValue, byval firstB as UByte, byref nam as String)
  if Parser_SupportComplexNumbers = FALSE then exit sub
  if len(nam) > 1 then exit sub
  if firstB <> CHAR_LC_I andalso firstB <> CHAR_I then exit sub
  ValueSetImagUnit(v)
end sub

private function IsImplicitMulStart() as Boolean
  if pStream[0] = CHAR_LPAREN then return TRUE
  return FALSE
end function

private function TryParsePrefixedUIntLiteral(byval prefixChar as UByte, byval radix as ULongInt, byref outV as ULongInt) as Boolean
  dim p as ZString ptr = pStream
  if p[0] <> CHAR_DIGIT_0 then return FALSE
  dim prefixUpper as UByte = prefixChar
  if prefixUpper >= CHAR_LC_A andalso prefixUpper <= CHAR_LC_Z then
    prefixUpper -= (CHAR_LC_A - CHAR_A)
  end if
  if p[1] <> prefixChar andalso p[1] <> prefixUpper then return FALSE
  p += 2
  dim parsed as ULongInt = 0
  dim digits as Integer = 0
  while TRUE
    dim c as UByte = p[0]
    dim d as Integer = -1
    if c >= CHAR_DIGIT_0 andalso c <= CHAR_DIGIT_9 then
      d = c - CHAR_DIGIT_0
    elseif c >= CHAR_LC_A andalso c <= CHAR_LC_F then
      d = 10 + (c - CHAR_LC_A)
    elseif c >= CHAR_A andalso c <= CHAR_F then
      d = 10 + (c - CHAR_A)
    else
      exit while
    end if
    if d < 0 orelse CULngInt(d) >= radix then exit while
    if parsed > ((FB_U64_MAX - CULngInt(d)) \ radix) then
      return FALSE
    end if
    parsed = parsed * radix + CULngInt(d)
    digits += 1
    p += 1
  wend
  if digits = 0 then return FALSE
  pStream = p
  outV = parsed
  return TRUE
end function

declare function TryBuiltinDispatchWithTime(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
declare function TryBuiltinDispatchWithComplex(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
declare function TryEvaluateBuiltinAggregate(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
declare function TryApproximateRational(byval x as Double, byref num as LongInt, byref den as ULongInt) as Boolean
declare sub ValueSetRationalReduced(byref outV as EvalValue, byval num as LongInt, byval den as ULongInt)
declare function TryBuiltinSortby(byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
declare function TryBuiltinRatio(byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
declare function TryParseSortbyCallArguments(args() as EvalValue, byref argsCount as Integer, byref argsCap as Integer) as Boolean
declare function TryParseSortbyFunctionRef(byref outV as EvalValue) as Boolean
declare function TryDispatchBuiltinCall(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
declare function TryEvaluateStatementCore(byref exprInput as String, byref result as Double, byref resultText as String, byref isArray as Boolean, byval suppressTailHint as Boolean) as Boolean
declare function IsStmtUdfDefinitionAt(byref stmt as String) as Boolean
declare function TrySingleArgPassthroughOrCollect(args() as EvalValue, byref fnName as String, byval reverseSingleArray as Boolean, byref outV as EvalValue, vals() as ScalarValue, byref c as Integer) as Integer

private function CountFlattenedArgs(args() as EvalValue) as Integer
  dim count as Integer = 0
  dim argIdx as Integer = lbound(args)
  dim elemIdx as Integer = -1
  dim srcArgIdx as Integer
  dim srcElemIdx as Integer
  dim isScalar as Boolean
  while ArgWalkNextPosition(args(), argIdx, elemIdx, srcArgIdx, srcElemIdx, isScalar)
    count += 1
  wend
  return count
end function

private function CollectArgsAsFlat(args() as EvalValue, flat() as Double) as Integer
  dim count as Integer = CountFlattenedArgs(args())
  if count <= 0 then return 0
  redim flat(0 to count - 1)

  dim flatPos as Integer = 0
  dim argIdx as Integer = lbound(args)
  dim elemIdx as Integer = -1
  dim item as Double
  while ArgScalarWalkNext(args(), argIdx, elemIdx, item)
    flat(flatPos) = item
    flatPos += 1
  wend
  return count
end function

private function CollectRequiredArgsAsFlat(args() as EvalValue, flat() as Double, byref fnName as String) as Integer
  dim count as Integer = CollectArgsAsFlat(args(), flat())
  if count <= 0 then
    SetAtLeastOneArgError(fnName)
    return 0
  end if
  return count
end function

private function CollectArgsAsScalarValues(args() as EvalValue, vals() as ScalarValue) as Integer
  dim count as Integer = CountFlattenedArgs(args())
  if count <= 0 then return 0
  redim vals(0 to count - 1)

  dim outPos as Integer = 0
  dim argIdx as Integer = lbound(args)
  dim elemIdx as Integer = -1
  dim item as ScalarValue
  while ArgScalarValueWalkNext(args(), argIdx, elemIdx, item)
    vals(outPos) = item
    outPos += 1
  wend
  return count
end function

private function CollectRequiredArgsAsScalarValues(args() as EvalValue, vals() as ScalarValue, byref fnName as String) as Integer
  dim count as Integer = CollectArgsAsScalarValues(args(), vals())
  if count <= 0 then
    SetAtLeastOneArgError(fnName)
    return 0
  end if
  return count
end function

private function CopySingleArgToScalarValues(byref a as EvalValue, vals() as ScalarValue, byval reverseOrder as Boolean) as Integer
  if a.kind = VK_SCALAR then
    redim vals(0 to 0)
    vals(0) = a.scalarValue
    return 1
  end if
  dim c as Integer = ValueArrayLen(a)
  if c <= 0 then return 0
  redim vals(0 to c - 1)
  dim i as Integer
  if reverseOrder then
    for i = 0 to c - 1
      vals(i) = a.arr(ubound(a.arr) - i)
    next i
  else
    for i = 0 to c - 1
      vals(i) = a.arr(lbound(a.arr) + i)
    next i
  end if
  return c
end function

private function ArgWalkNextPosition(args() as EvalValue, byref argIdx as Integer, byref elemIdx as Integer, byref srcArgIdx as Integer, byref srcElemIdx as Integer, byref isScalar as Boolean) as Boolean
  if ubound(args) = -1 then return FALSE
  do while argIdx <= ubound(args)
    if args(argIdx).kind = VK_SCALAR then
      srcArgIdx = argIdx
      srcElemIdx = -1
      isScalar = TRUE
      argIdx += 1
      elemIdx = -1
      return TRUE
    else
      if elemIdx = -1 then elemIdx = lbound(args(argIdx).arr)
      if elemIdx <= ubound(args(argIdx).arr) then
        srcArgIdx = argIdx
        srcElemIdx = elemIdx
        isScalar = FALSE
        elemIdx += 1
        return TRUE
      end if
      argIdx += 1
      elemIdx = -1
    end if
  loop
  return FALSE
end function

private function ArgScalarWalkNext(args() as EvalValue, byref argIdx as Integer, byref elemIdx as Integer, byref outV as Double) as Boolean
  dim srcArgIdx as Integer
  dim srcElemIdx as Integer
  dim isScalar as Boolean
  if ArgWalkNextPosition(args(), argIdx, elemIdx, srcArgIdx, srcElemIdx, isScalar) = FALSE then return FALSE
  if isScalar then
    outV = args(srcArgIdx).scalar
  else
    outV = args(srcArgIdx).arr(srcElemIdx).scalar
  end if
  return TRUE
end function

private function ArgScalarValueWalkNext(args() as EvalValue, byref argIdx as Integer, byref elemIdx as Integer, byref outV as ScalarValue) as Boolean
  dim srcArgIdx as Integer
  dim srcElemIdx as Integer
  dim isScalar as Boolean
  if ArgWalkNextPosition(args(), argIdx, elemIdx, srcArgIdx, srcElemIdx, isScalar) = FALSE then return FALSE
  if isScalar then
    outV = args(srcArgIdx).scalarValue
  else
    outV = args(srcArgIdx).arr(srcElemIdx)
  end if
  return TRUE
end function

'' Exact integer metadata for min/max winner tie-break (not render-rational storage).
private function ScalarHasExactIntegerMetadata(byref sv as ScalarValue) as Boolean
  if ScalarHasRenderRational(sv) then return FALSE
  return ScalarExactInt64Valid(sv) orelse ScalarExactUInt64Valid(sv)
end function

private function ScalarMinMaxShouldReplaceWinner(byval wantMin as Boolean, byval v as Double, byval winnerV as Double, byval hasWinner as Boolean) as Boolean
  if hasWinner = FALSE then return TRUE
  if wantMin then
    return v < winnerV
  end if
  return v > winnerV
end function

private function ScalarMinMaxShouldPreferOnTie(byref winner as ScalarValue, byref candidate as ScalarValue) as Boolean
  if ScalarHasExactIntegerMetadata(candidate) = FALSE then return FALSE
  if ScalarHasExactIntegerMetadata(winner) then return FALSE
  return TRUE
end function

private function TryMinMaxPreserveWinner(args() as EvalValue, byval wantMin as Boolean, byref outV as EvalValue) as Boolean
  dim argIdx as Integer = lbound(args)
  dim elemIdx as Integer = -1
  dim sv as ScalarValue
  dim winnerSv as ScalarValue
  dim winnerV as Double
  dim hasWinner as Boolean = FALSE
  dim hasNonNanWinner as Boolean = FALSE
  dim itemCount as Integer = 0
  while ArgScalarValueWalkNext(args(), argIdx, elemIdx, sv)
    itemCount += 1
    dim v as Double = ScalarNumericReal(sv)
    if IsNaNValue(v) then
      if hasNonNanWinner = FALSE andalso hasWinner = FALSE then
        winnerSv = sv
        winnerV = v
        hasWinner = TRUE
      end if
    else
      if (hasWinner = FALSE) orelse IsNaNValue(winnerV) orelse ScalarMinMaxShouldReplaceWinner(wantMin, v, winnerV, TRUE) then
        winnerSv = sv
        winnerV = v
        hasWinner = TRUE
        hasNonNanWinner = TRUE
      elseif v = winnerV then
        if ScalarMinMaxShouldPreferOnTie(winnerSv, sv) then winnerSv = sv
      end if
    end if
  wend
  if itemCount <= 0 then return FALSE
  EvalScalarFromScalarValue(winnerSv, outV)
  return TRUE
end function

private function TryFoldExactComplexCartesian(args() as EvalValue, byval op as UByte, byref outV as EvalValue) as Boolean
  dim argIdx as Integer = lbound(args)
  dim elemIdx as Integer = -1
  dim sv as ScalarValue
  dim gotAny as Boolean = FALSE
  dim accV as EvalValue
  while ArgScalarValueWalkNext(args(), argIdx, elemIdx, sv)
    dim itemV as EvalValue
    EvalScalarFromScalarValue(sv, itemV)
    if gotAny = FALSE then
      accV = itemV
      gotAny = TRUE
    else
      if TryApplyExactComplexCartesianBinary(accV.scalarValue, itemV.scalarValue, op, outV) = FALSE then return FALSE
      accV = outV
    end if
  wend
  if gotAny = FALSE then return FALSE
  outV = accV
  return TRUE
end function

private function TryAvgExactComplexFromSum(byref sumV as EvalValue, byval itemCount as LongInt, byref outV as EvalValue) as Boolean
  if itemCount <= 0 then return FALSE
  dim lRe as ExactCartesianComponent
  dim lIm as ExactCartesianComponent
  dim oRe as ExactCartesianComponent
  dim oIm as ExactCartesianComponent
  if TryExtractExactRealComponent(sumV.scalarValue, lRe) = FALSE then return FALSE
  if TryExtractExactImagComponent(sumV.scalarValue, lIm) = FALSE then return FALSE
  dim reI as LongInt, imI as LongInt, qRe as LongInt, qIm as LongInt
  if TryExactCartesianComponentToInt64(lRe, reI) = FALSE then return FALSE
  if TryExactCartesianComponentToInt64(lIm, imI) = FALSE then return FALSE
  if TryQuotExactInt64(reI, itemCount, qRe) = FALSE then return FALSE
  if TryQuotExactInt64(imI, itemCount, qIm) = FALSE then return FALSE
  ExactCartesianComponentAssignFromInt64(oRe, qRe)
  ExactCartesianComponentAssignFromInt64(oIm, qIm)
  ValueSetScalarComplexFromExactCartesian(outV, oRe, oIm)
  return TRUE
end function

'' sum / product / min / max: preserve exact uint64/int64 metadata when every operand carries exact integer state.
private function TryAggSimpleExactInteger(args() as EvalValue, byval fnId as Integer, byref outV as EvalValue) as Boolean
  dim argIdx as Integer = lbound(args)
  dim elemIdx as Integer = -1
  dim sv as ScalarValue
  dim allNnU as Boolean = TRUE
  dim allSwI as Boolean = TRUE
  dim gotAny as Boolean = FALSE
  while ArgScalarValueWalkNext(args(), argIdx, elemIdx, sv)
    gotAny = TRUE
    dim uProbe as ULongInt
    dim liProbe as LongInt
    dim nnU as Boolean = TryGetExactNonNegativeUInt64Scalar(sv, uProbe)
    dim swI as Boolean = TryGetExactSignedInt64NoUIntWrapScalar(sv, liProbe)
    if (nnU = FALSE) andalso (swI = FALSE) then return FALSE
    if nnU = FALSE then allNnU = FALSE
    if swI = FALSE then allSwI = FALSE
  wend
  if gotAny = FALSE then return FALSE

  if fnId = FUNC_PRODUCT then
    argIdx = lbound(args)
    elemIdx = -1
    dim productMag as ULongInt = 1
    dim isNegativeProduct as Boolean = FALSE
    while ArgScalarValueWalkNext(args(), argIdx, elemIdx, sv)
      dim termMag as ULongInt
      if TryGetExactNonNegativeUInt64Scalar(sv, termMag) then
        ' termMag already contains the unsigned magnitude.
      else
        dim termI as LongInt
        if TryGetExactSignedInt64NoUIntWrapScalar(sv, termI) = FALSE then return FALSE
        if termI < 0 then
          isNegativeProduct = not isNegativeProduct
          if termI = FB_I64_MIN then
            termMag = FB_I64_MIN_MAG_U
          else
            termMag = CULngInt(-termI)
          end if
        else
          termMag = CULngInt(termI)
        end if
      end if

      dim nextMag as ULongInt
      if TryMulULongChecked(productMag, termMag, nextMag) = FALSE then return FALSE
      productMag = nextMag
    wend
    if isNegativeProduct then
      if productMag > FB_I64_MIN_MAG_U then return FALSE
      if productMag = FB_I64_MIN_MAG_U then
        ValueSetInt64(outV, FB_I64_MIN)
      else
        ValueSetInt64(outV, -CLngInt(productMag))
      end if
    else
      ValueSetUInt64(outV, productMag)
    end if
    return TRUE
  end if

  if allNnU then
    argIdx = lbound(args)
    elemIdx = -1
    dim accU as ULongInt = 0
    dim hasBestU as Boolean = FALSE
    dim bestU as ULongInt
    while ArgScalarValueWalkNext(args(), argIdx, elemIdx, sv)
      dim u2 as ULongInt
      TryGetExactNonNegativeUInt64Scalar(sv, u2)
      if fnId = FUNC_SUM then
        dim nextU as ULongInt
        if TryAddULongChecked(accU, u2, nextU) = FALSE then return FALSE
        accU = nextU
      elseif fnId = FUNC_MIN then
        if (hasBestU = FALSE) orelse (u2 < bestU) then bestU = u2: hasBestU = TRUE
      else
        if (hasBestU = FALSE) orelse (u2 > bestU) then bestU = u2: hasBestU = TRUE
      end if
    wend
    if fnId = FUNC_SUM then ValueSetUInt64(outV, accU) else ValueSetUInt64(outV, bestU)
    return TRUE
  elseif allSwI then
    argIdx = lbound(args)
    elemIdx = -1
    dim accI as LongInt = 0
    dim hasBestI as Boolean = FALSE
    dim bestI as LongInt
    while ArgScalarValueWalkNext(args(), argIdx, elemIdx, sv)
      dim i2 as LongInt
      TryGetExactSignedInt64NoUIntWrapScalar(sv, i2)
      if fnId = FUNC_SUM then
        dim nextI as LongInt
        if TryAddInt64(accI, i2, nextI) = FALSE then return FALSE
        accI = nextI
      elseif fnId = FUNC_MIN then
        if (hasBestI = FALSE) orelse (i2 < bestI) then bestI = i2: hasBestI = TRUE
      else
        if (hasBestI = FALSE) orelse (i2 > bestI) then bestI = i2: hasBestI = TRUE
      end if
    wend
    if fnId = FUNC_SUM then ValueSetInt64(outV, accI) else ValueSetInt64(outV, bestI)
    return TRUE
  end if
  return FALSE
end function

private function ExpandUnpackedArgs(argsIn() as EvalValue, argsOut() as EvalValue) as Integer
  dim outCount as Integer = 0
  dim i as Integer, j as Integer
  dim hasExpandMarkers as Boolean = FALSE
  erase argsOut
  if ubound(argsIn) = -1 then return 0

  ' Pre-count once and allocate once to avoid repeated redim preserve.
  for i = lbound(argsIn) to ubound(argsIn)
    if argsIn(i).expandArgs then hasExpandMarkers = TRUE
    if argsIn(i).expandArgs andalso argsIn(i).kind = VK_ARRAY then
      outCount += ValueArrayLen(argsIn(i))
    else
      outCount += 1
    end if
  next i
  if hasExpandMarkers = FALSE then return 0
  if outCount <= 0 then return 0
  redim argsOut(0 to outCount - 1)

  dim outPos as Integer = 0
  for i = lbound(argsIn) to ubound(argsIn)
    if argsIn(i).expandArgs then
      if argsIn(i).kind = VK_ARRAY then
        for j = lbound(argsIn(i).arr) to ubound(argsIn(i).arr)
          EvalScalarFromScalarValue(argsIn(i).arr(j), argsOut(outPos))
          outPos += 1
        next j
      else
        argsOut(outPos) = argsIn(i)
        argsOut(outPos).expandArgs = FALSE
        outPos += 1
      end if
    else
      argsOut(outPos) = argsIn(i)
      outPos += 1
    end if
  next i

  return outPos
end function

private sub NormalizeCallArgs(args() as EvalValue)
  dim expandedArgs() as EvalValue
  dim expandedCount as Integer = ExpandUnpackedArgs(args(), expandedArgs())
  if expandedCount <= 0 then exit sub
  erase args
  redim args(0 to expandedCount - 1)
  for i as Integer = 0 to expandedCount - 1
    args(i) = expandedArgs(i)
  next i
end sub

private sub EnsureEvalArgsCapacity(args() as EvalValue, byref argsCount as Integer, byref argsCap as Integer)
  if argsCount < argsCap then exit sub
  if argsCap = 0 then
    argsCap = 4
  else
    argsCap = argsCap * 2
  end if
  if argsCount = 0 then
    redim args(0 to argsCap - 1)
  else
    redim preserve args(0 to argsCap - 1)
  end if
end sub

private sub AppendEvalArg(args() as EvalValue, byref argsCount as Integer, byref argsCap as Integer, byref value as EvalValue)
  EnsureEvalArgsCapacity(args(), argsCount, argsCap)
  args(argsCount) = value
  argsCount += 1
end sub

private function TryParseCallArguments(args() as EvalValue, byref argsCount as Integer, byref argsCap as Integer) as Boolean
  if pStream[0] = CHAR_COMMA then
    SetParseErrorById(PARSE_ERR_UNEXPECTED_COMMA)
    return FALSE
  end if
  if pStream[0] = CHAR_RPAREN then
    return TRUE
  end if
  do
    dim a as EvalValue = ParseExpression()
    if parseError then return FALSE
    AppendEvalArg(args(), argsCount, argsCap, a)
    SkipSpaces()
    dim hasComma as Boolean
    if TryConsumeCommaArgSeparator(hasComma) = FALSE then return FALSE
    if hasComma = FALSE then exit do
  loop
  return TRUE
end function

private sub ValueSetFunctionRef(byref outV as EvalValue, byref nameText as String)
  ValueClearLambdaPayload(outV)
  outV.kind = VK_FUNCTION_REF
  outV.flags = 0
  outV.funcRefName = lcase(nameText)
end sub

private sub ValueSetInlineLambda(byref outV as EvalValue, fnParams() as string, byref lamBody as string)
  erase outV.arr
  outV.funcRefName = ""
  outV.kind = VK_INLINE_LAMBDA
  outV.flags = 0
  if ubound(fnParams) >= lbound(fnParams) then
    redim outV.lambdaParams(lbound(fnParams) to ubound(fnParams))
    dim i as Integer
    for i = lbound(fnParams) to ubound(fnParams)
      outV.lambdaParams(i) = fnParams(i)
    next i
  else
    erase outV.lambdaParams
  end if
  outV.lambdaBody = lamBody
end sub

private function IsSortbyIneligibleBuiltin(byval fnId as Integer) as Boolean
  select case fnId
    case FUNC_RAND, FUNC_POW, FUNC_ATAN2, FUNC_HYPOT, FUNC_GCD, FUNC_LCM, FUNC_NCR, FUNC_NPR, FUNC_MOD, FUNC_CLAMP, FUNC_LOG, FUNC_RANDOM
      return TRUE
    case else: return FALSE
  end select
end function

private function IsSortbyEligibleFunctionName(byref funcName as String, byref errText as String) as Boolean
  dim lowFn as String = lcase(funcName)
  dim fnId as Integer = TryFindBuiltinFunctionId(lowFn)
  if fnId >= 0 then
    if IsSortbyIneligibleBuiltin(fnId) then
      errText = FB_STR_SORTBY_EXPECTS_UNARY_FUNCTION
      return FALSE
    end if
    return TRUE
  end if
  dim idx as Integer = FindFunctionIndex(lowFn)
  if idx < 0 then
    dim boundVar as EvalValue
    if GetVariable(lowFn, boundVar) then
      errText = FB_STR_SORTBY_EXPECTS_UNARY_FUNCTION
      return FALSE
    end if
    errText = FB_STR_UNKNOWN_FUNCTION_COLON & funcName
    return FALSE
  end if
  dim pCount as Integer = 0
  if ubound(userFunctions(idx).params) >= lbound(userFunctions(idx).params) then
    pCount = ubound(userFunctions(idx).params) - lbound(userFunctions(idx).params) + 1
  end if
  if pCount <> 1 then
    errText = FB_STR_SORTBY_EXPECTS_UNARY_FUNCTION
    return FALSE
  end if
  return TRUE
end function

private function NetRoundParenDepthBetween(byval lo as ZString ptr, byval hiEx as ZString ptr) as Integer
  dim d as Integer = 0
  dim q as ZString ptr = lo
  while q < hiEx
    dim cu as UByte = q[0]
    if cu = CHAR_LPAREN then
      d += 1
    elseif cu = CHAR_RPAREN then
      d -= 1
    end if
    q += 1
  wend
  return d
end function

private function LambdaBodyTake(byref body as string, byval stopMode as Integer, byval sortbyLambdaKeySeg as ZString ptr) as Boolean
  body = ""
  dim g as Integer = 0
  while pStream[0] <> CHAR_NUL
    dim cu as UByte = pStream[0]
    if g = 0 then
      select case stopMode
      case LAMBDA_BODY_UNTIL_RPAREN
        if cu = CHAR_RPAREN then return TRUE
      case LAMBDA_BODY_UNTIL_SORTBY_DELIM
        if (cu = CHAR_COMMA orelse cu = CHAR_RPAREN) andalso sortbyLambdaKeySeg <> 0 then
          if NetRoundParenDepthBetween(sortbyLambdaKeySeg, pStream) = 0 then return TRUE
        end if
      case LAMBDA_BODY_UNTIL_SEMICOLON_EOF
        if cu = CHAR_SEMICOLON then return TRUE
      end select
    end if
    select case cu
    case CHAR_LPAREN, CHAR_LBRACKET, CHAR_LBRACE
      g += 1
    case CHAR_RPAREN, CHAR_RBRACKET, CHAR_RBRACE
      g -= 1
      if g < 0 then return FALSE
    end select
    body &= chr(cu)
    pStream += 1
  wend
  return (stopMode = LAMBDA_BODY_UNTIL_SEMICOLON_EOF) _
      orelse (stopMode = LAMBDA_BODY_UNTIL_SORTBY_DELIM)
end function

private function TryConsumeLambdaParamList(fnParams() as string, byval quiet as Boolean) as Boolean
  erase fnParams
  SkipSpaces()
  if pStream[0] = CHAR_LPAREN then
    pStream += 1
    SkipSpaces()
    if pStream[0] = CHAR_RPAREN then
      pStream += 1
      return TRUE
    end if
    do
      if IsIdentStartChar(asc(pStream[0])) = FALSE then
        if quiet = FALSE then SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
        return FALSE
      end if
      dim nm as string = ConsumeIdentTokenFromStream()
      if ubound(fnParams) < lbound(fnParams) then
        redim fnParams(0 to 0)
        fnParams(0) = nm
      else
        redim preserve fnParams(lbound(fnParams) to ubound(fnParams) + 1)
        fnParams(ubound(fnParams)) = nm
      end if
      SkipSpaces()
      if pStream[0] = CHAR_COMMA then
        pStream += 1
        SkipSpaces()
      elseif pStream[0] = CHAR_RPAREN then
        pStream += 1
        return TRUE
      else
        if quiet = FALSE then SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
        return FALSE
      end if
    loop
  elseif IsIdentStartChar(asc(pStream[0])) then
    redim fnParams(0 to 0)
    fnParams(0) = ConsumeIdentTokenFromStream()
    SkipSpaces()
    while pStream[0] = CHAR_COMMA
      pStream += 1
      SkipSpaces()
      if IsIdentStartChar(asc(pStream[0])) = FALSE then
        if quiet = FALSE then SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
        return FALSE
      end if
      redim preserve fnParams(lbound(fnParams) to ubound(fnParams) + 1)
      fnParams(ubound(fnParams)) = ConsumeIdentTokenFromStream()
      SkipSpaces()
    wend
    return TRUE
  end if
  return FALSE
end function

private function TryParseLambdaInnerSuffix(fnParams() as string, byref body as string, byval bodyMode as Integer, byval sortbyLambdaKeySeg as ZString ptr) as Boolean
  if TryConsumeLambdaParamList(fnParams(), TRUE) = FALSE then return FALSE
  SkipSpaces()
  if pStream[0] <> CHAR_COLON then return FALSE
  pStream += 1
  SkipSpaces()
  if sortbyKeyParseErrorCol > 0 then sortbyKeyBodyParseErrorCol = CurrentParseErrorColumn()
  return LambdaBodyTake(body, bodyMode, sortbyLambdaKeySeg)
end function

private function TryFinalizeUnarySortbyInlineLambda(fnParams() as string, byref body as string, byref outV as EvalValue) as Boolean
  dim pcount as Integer = 0
  if ubound(fnParams) >= lbound(fnParams) then pcount = ubound(fnParams) - lbound(fnParams) + 1
  if pcount <> 1 then
    SetParseError(FB_STR_SORTBY_EXPECTS_UNARY_FUNCTION)
    return FALSE
  end if
  if InlineLambdaBodyIsEffectivelyEmpty(body) then
    SetFunctionBodyIsEmptyError()
    return FALSE
  end if
  ValueSetInlineLambda(outV, fnParams(), body)
  CopySortbyKeyParseColumnsToEvalValue(outV)
  return TRUE
end function

private function TryParseWrappedParenLambdaSuffix(fnParams() as string, byref body as string, byval bodyMode as Integer) as Boolean
  dim saveOuter as ZString ptr = pStream
  if pStream[0] <> CHAR_LPAREN then return FALSE
  dim inner as ZString ptr = pStream + 1
  if PeekRhsMayBeLambdaSyntaxAt(inner) = FALSE then return FALSE
  pStream += 1
  if TryParseLambdaInnerSuffix(fnParams(), body, bodyMode, 0) = FALSE then
    pStream = saveOuter
    return FALSE
  end if
  SkipSpaces()
  if pStream[0] <> CHAR_RPAREN then
    pStream = saveOuter
    return FALSE
  end if
  pStream += 1
  SkipSpaces()
  return TRUE
end function

private function TryParseLambdaAssignmentRhs(fnParams() as string, byref lamBody as string) as Boolean
  erase fnParams
  lamBody = ""
  dim saveOuter as ZString ptr = pStream
  if PeekRhsMayBeLambdaSyntaxAt(saveOuter) = FALSE then return FALSE
  SkipSpaces()
  if TryParseWrappedParenLambdaSuffix(fnParams(), lamBody, LAMBDA_BODY_UNTIL_RPAREN) then
    if pStream[0] = CHAR_NUL orelse pStream[0] = CHAR_SEMICOLON then
      if InlineLambdaBodyIsEffectivelyEmpty(lamBody) then
        SetFunctionBodyIsEmptyError()
        return FALSE
      end if
      return TRUE
    end if
    pStream = saveOuter
    erase fnParams
    lamBody = ""
  end if
  SkipSpaces()
  if TryParseLambdaInnerSuffix(fnParams(), lamBody, LAMBDA_BODY_UNTIL_SEMICOLON_EOF, 0) = FALSE then return FALSE
  SkipSpaces()
  if pStream[0] = CHAR_NUL orelse pStream[0] = CHAR_SEMICOLON then
    if InlineLambdaBodyIsEffectivelyEmpty(lamBody) then
      SetFunctionBodyIsEmptyError()
      return FALSE
    end if
    return TRUE
  end if
  return FALSE
end function

private function TryParseSortbyKeyArgFunctionRefOnly(byref outV as EvalValue) as Boolean
  parseError = 0
  SkipSpaces()
  if PeekRhsMayBeLambdaSyntaxAt(pStream) then
    SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
    return FALSE
  end if
  return TryParseSortbyFunctionRef(outV)
end function

private function TryParseUnarySortbyLambdaOrFunctionRef(byref outV as EvalValue) as Boolean
  dim save as ZString ptr = pStream
  parseError = 0
  SkipSpaces()
  dim fnParams() as string
  dim body as string = ""
  if pStream[0] = CHAR_LPAREN then
    dim inner as ZString ptr = pStream + 1
    if PeekRhsMayBeLambdaSyntaxAt(inner) then
      pStream += 1
      if TryParseLambdaInnerSuffix(fnParams(), body, LAMBDA_BODY_UNTIL_RPAREN, 0) then
        SkipSpaces()
        if pStream[0] = CHAR_COMMA orelse pStream[0] = CHAR_RPAREN orelse pStream[0] = CHAR_NUL then
          return TryFinalizeUnarySortbyInlineLambda(fnParams(), body, outV)
        end if
      end if
    end if
  end if
  pStream = save
  SkipSpaces()
  erase fnParams
  body = ""
  if PeekRhsMayBeLambdaSyntaxAt(pStream) = FALSE then
    return TryParseSortbyFunctionRef(outV)
  end if
  if TryParseLambdaInnerSuffix(fnParams(), body, LAMBDA_BODY_UNTIL_SORTBY_DELIM, save) = FALSE then
    pStream = save
    erase fnParams
    body = ""
    return TryParseSortbyFunctionRef(outV)
  end if
  SkipSpaces()
  if pStream[0] = CHAR_COMMA orelse pStream[0] = CHAR_RPAREN orelse pStream[0] = CHAR_NUL then
    return TryFinalizeUnarySortbyInlineLambda(fnParams(), body, outV)
  end if
  pStream = save
  erase fnParams
  body = ""
  return TryParseSortbyFunctionRef(outV)
end function

private function TryParseSortbyKeyArg(byref outV as EvalValue) as Boolean
  if Parser_SupportLambdaFunctions then
    return TryParseUnarySortbyLambdaOrFunctionRef(outV)
  end if
  return TryParseSortbyKeyArgFunctionRefOnly(outV)
end function

private function TryParseSortbyFunctionRef(byref outV as EvalValue) as Boolean
  SkipSpaces()
  dim p as ZString ptr = pStream
  if p[0] = CHAR_LPAREN then
    dim parsed as EvalValue = ParseExpression()
    if parseError then return FALSE
    if parsed.kind = VK_ARRAY then
      SetParseError(FB_STR_SORTBY_EXPECTS_ONE_FUNCTION)
      return FALSE
    end if
    SetParseError(FB_STR_SORTBY_EXPECTS_UNARY_FUNCTION)
    return FALSE
  end if
  if not ((p[0] >= CHAR_LC_A andalso p[0] <= CHAR_LC_Z) orelse (p[0] >= CHAR_A andalso p[0] <= CHAR_Z) orelse p[0] = CHAR_UNDERSCORE) then
    SetParseError(FB_STR_SORTBY_EXPECTS_UNARY_FUNCTION)
    return FALSE
  end if
  dim start as ZString ptr = p
  p += 1
  while TRUE
    dim chId as UByte = p[0]
    if IsIdentChar(chId) = FALSE then exit while
    p += 1
  wend
  dim nameText as String = left(*start, p - start)
  SkipSpaces()
  if p[0] = CHAR_COLON then
    SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
    return FALSE
  end if
  if p[0] = CHAR_LPAREN then
    SetParseError(FB_STR_SORTBY_EXPECTS_ONE_FUNCTION)
    return FALSE
  end if
  pStream = p
  ValueSetFunctionRef(outV, nameText)
  CopySortbyKeyParseColumnsToEvalValue(outV)
  return TRUE
end function

private function TryParseSortbyCallArguments(args() as EvalValue, byref argsCount as Integer, byref argsCap as Integer) as Boolean
  if pStream[0] = CHAR_COMMA then
    SetParseErrorById(PARSE_ERR_UNEXPECTED_COMMA)
    return FALSE
  end if
  if pStream[0] = CHAR_RPAREN then
    SetParseError(FB_STR_SORTBY_EXPECTS_UNARY_FUNCTION)
    return FALSE
  end if
  dim a as EvalValue = ParseExpression()
  if parseError then return FALSE
  AppendEvalArg(args(), argsCount, argsCap, a)
  SkipSpaces()
  dim hasComma as Boolean
  if TryConsumeCommaArgSeparator(hasComma) = FALSE then return FALSE
  if hasComma = FALSE then
    SetParseError(FB_STR_SORTBY_EXPECTS_UNARY_FUNCTION)
    return FALSE
  end if
  dim keyArg as EvalValue
  sortbyKeyParseErrorCol = 0
  sortbyKeyBodyParseErrorCol = 0
  sortbyKeyParseErrorCol = CurrentParseErrorColumn()
  if TryParseSortbyKeyArg(keyArg) = FALSE then
    sortbyKeyParseErrorCol = 0
    sortbyKeyBodyParseErrorCol = 0
    return FALSE
  end if
  sortbyKeyParseErrorCol = 0
  sortbyKeyBodyParseErrorCol = 0
  AppendEvalArg(args(), argsCount, argsCap, keyArg)
  SkipSpaces()
  if TryConsumeCommaArgSeparator(hasComma) = FALSE then return FALSE
  if hasComma then
    SetParseError(FB_STR_SORTBY_EXPECTS_ONE_FUNCTION)
    return FALSE
  end if
  return TRUE
end function

private function SortbyInvokeKeyFunction(byref funcName as String, byref elem as ScalarValue, byref outV as EvalValue) as Boolean
  dim args(0 to 0) as EvalValue
  args(0).kind = VK_SCALAR
  args(0).scalarValue = elem
  args(0).flags = 0
  dim fnId as Integer = TryFindBuiltinFunctionId(lcase(funcName))
  if fnId < 0 then
    if EvaluateUserFunction(funcName, args(), outV) then return TRUE
    SetParseError(FB_STR_UNKNOWN_FUNCTION_COLON & funcName)
    return TRUE
  end if
  dim fn as String = funcName
  if ValidateBuiltinCallArgs(fnId, fn, args()) = FALSE then return TRUE
  dim cat as Integer = GetBuiltinCategory(fnId)
  if cat = BC_SORTBY orelse cat = BC_RATIO then
    SetParseError(FB_STR_SORTBY_EXPECTS_UNARY_FUNCTION)
    return TRUE
  end if
  if TryDispatchBuiltinCall(fnId, fn, args(), outV) then return TRUE
  SetParseError(FB_STR_SORTBY_EXPECTS_UNARY_FUNCTION)
  return TRUE
end function

private sub ValueSetRationalReduced(byref outV as EvalValue, byval num as LongInt, byval den as ULongInt)
  ValueSetScalar(outV, CDbl(num) / CDbl(den))
  outV.scalarValue.exactInt64 = num
  outV.scalarValue.exactUInt64 = den
  ScalarSetExactInt64Valid(outV.scalarValue, TRUE)
  ScalarSetExactUInt64Valid(outV.scalarValue, TRUE)
  outV.scalarValue.flags or= SVF_RENDER_RATIONAL
  ScalarRepairExactMetadata(outV.scalarValue)
end sub

private function RatioApproxAbsNumerator(byval v as Double, byval p as LongInt, byval q as ULongInt) as Double
  return abs(v * CDbl(q) - CDbl(p))
end function

private function RatioApproxErrNumLess(byval n1 as Double, byval q1 as ULongInt, byval n2 as Double, byval q2 as ULongInt) as Boolean
  return (n1 * CDbl(q2)) < (n2 * CDbl(q1))
end function

private function TryExactPower10Rational(byval v as Double, byref bestNum as LongInt, byref bestDen as ULongInt, byref bestAbsNum as Double) as Boolean
  dim k as Integer
  dim denPow as ULongInt
  dim denPowLong as LongInt
  dim scaled as Double
  dim n as LongInt
  dim nAbs as LongInt
  dim scaleErr as Double
  dim g as LongInt
  dim candNum as LongInt
  dim candDenLong as LongInt
  dim candDen as ULongInt
  dim candAbs as Double
  dim foundExact as Boolean = FALSE
  for k = 1 to RATIO_MAX_POWER10_EXP
    denPow = Pow10U64(k)
    scaled = v * CDbl(denPow)
    n = clngint(round(scaled))
    if n = 0 then continue for
    nAbs = abs(n)
    scaleErr = RATIO_APPROX_EPS * abs(scaled)
    if scaleErr < RATIO_APPROX_EPS then scaleErr = RATIO_APPROX_EPS
    if abs(scaled - CDbl(n)) > scaleErr then continue for
    denPowLong = CLngInt(denPow)
    g = GcdInt64(nAbs, denPowLong)
    candNum = n \ g
    candDenLong = denPowLong \ g
    candDen = CULngInt(candDenLong)
    candAbs = RatioApproxAbsNumerator(v, candNum, candDen)
    if RatioApproxErrNumLess(candAbs, candDen, bestAbsNum, bestDen) then
      bestAbsNum = candAbs
      bestNum = candNum
      bestDen = candDen
      if candAbs = 0.0 then foundExact = TRUE
    end if
  next k
  return foundExact
end function

private function RatioConsiderCandidate(byval v as Double, byval p as LongInt, byval q as ULongInt, byref bestNum as LongInt, byref bestDen as ULongInt, byref bestAbsNum as Double) as Boolean
  if q = 0 orelse q > CULngInt(RATIO_MAX_DENOMINATOR) then return FALSE
  dim absNum as Double = RatioApproxAbsNumerator(v, p, q)
  if RatioApproxErrNumLess(absNum, q, bestAbsNum, bestDen) then
    bestAbsNum = absNum
    bestNum = p
    bestDen = q
    if absNum = 0.0 then return TRUE
  end if
  return FALSE
end function

private function RatioSemiconvergentAbsNumLess(byval v as Double, byval p1 as LongInt, byval q1 as LongInt, byval p0 as LongInt, byval q0 as LongInt, byval h1 as LongInt, byval h2 as LongInt) as Boolean
  dim qh1 as LongInt = q1 + h1 * q0
  dim qh2 as LongInt = q1 + h2 * q0
  if qh1 <= 0 orelse qh2 <= 0 then return FALSE
  dim ph1 as LongInt = p1 + h1 * p0
  dim ph2 as LongInt = p1 + h2 * p0
  dim n1 as Double = RatioApproxAbsNumerator(v, ph1, CULngInt(qh1))
  dim n2 as Double = RatioApproxAbsNumerator(v, ph2, CULngInt(qh2))
  return RatioApproxErrNumLess(n1, CULngInt(qh1), n2, CULngInt(qh2))
end function

private function RatioScanSemiconvergentRange(byval v as Double, byval p1 as LongInt, byval q1 as LongInt, byval p0 as LongInt, byval q0 as LongInt, byval hMax as LongInt, byref bestNum as LongInt, byref bestDen as ULongInt, byref bestAbsNum as Double) as Boolean
  if hMax < 0 then return FALSE
  if hMax <= RATIO_SEMICONV_LINEAR_THRESH then
    dim hLin as LongInt
    for hLin = 0 to hMax
      if RatioConsiderCandidate(v, p1 + hLin * p0, CULngInt(q1 + hLin * q0), bestNum, bestDen, bestAbsNum) then return TRUE
    next hLin
    return FALSE
  end if
  dim lo as LongInt = 0
  dim hi as LongInt = hMax
  if RatioConsiderCandidate(v, p1, CULngInt(q1), bestNum, bestDen, bestAbsNum) then return TRUE
  while hi - lo > 2
    dim span as LongInt = hi - lo
    dim m1 as LongInt = lo + span \ 3
    dim m2 as LongInt = hi - span \ 3
    if RatioSemiconvergentAbsNumLess(v, p1, q1, p0, q0, m1, m2) then
      hi = m2
    else
      lo = m1
    end if
  wend
  dim hFin as LongInt
  for hFin = lo to hi
    if RatioConsiderCandidate(v, p1 + hFin * p0, CULngInt(q1 + hFin * q0), bestNum, bestDen, bestAbsNum) then return TRUE
  next hFin
  return FALSE
end function

private function TryApproximateRational(byval x as Double, byref num as LongInt, byref den as ULongInt) as Boolean
  if IsNaNValue(x) orelse IsInfValue(x) then return FALSE
  dim neg as Boolean = (x < 0.0)
  dim v as Double = abs(x)
  dim scale as Double = v
  if scale < 1.0 then scale = 1.0
  dim tol as Double = RATIO_APPROX_EPS * scale
  if v < tol then
    num = 0
    den = 1
    return TRUE
  end if
  dim bestNum as LongInt = 0
  dim bestDen as ULongInt = 1
  dim bestAbsNum as Double = 1e300
  dim p0 as LongInt = 0
  dim p1 as LongInt = 1
  dim q0 as LongInt = 1
  dim q1 as LongInt = 0
  dim cfVal as Double = v
  dim i as Integer
  dim a as LongInt
  dim p as LongInt
  dim q as LongInt
  dim t as Double
  dim hMax as LongInt
  dim cfDone as Boolean = FALSE
  for i = 1 to 64
    a = fix(cfVal)
    p = a * p1 + p0
    q = a * q1 + q0
    if q > RATIO_MAX_DENOMINATOR then
      if q1 > 0 andalso q0 > 0 then
        hMax = (RATIO_MAX_DENOMINATOR - q1) \ q0
        if RatioScanSemiconvergentRange(v, p1, q1, p0, q0, hMax, bestNum, bestDen, bestAbsNum) then cfDone = TRUE
      end if
      exit for
    end if
    if RatioConsiderCandidate(v, p, CULngInt(q), bestNum, bestDen, bestAbsNum) then
      cfDone = TRUE
      exit for
    end if
    t = cfVal - CDbl(a)
    if t <= RATIO_APPROX_EPS then exit for
    cfVal = 1.0 / t
    p0 = p1
    p1 = p
    q0 = q1
    q1 = q
  next i
  if v <= 1.0 / CDbl(RATIO_MAX_DENOMINATOR) then
    TryExactPower10Rational(v, bestNum, bestDen, bestAbsNum)
  end if
  if bestNum = 0 then
    num = 0
    den = 1
    return TRUE
  end if
  dim g as LongInt = GcdInt64(abs(bestNum), CLngInt(bestDen))
  num = bestNum \ g
  den = CULngInt(CLngInt(bestDen) \ g)
  if neg then num = -num
  return TRUE
end function

private function TryBuiltinRatioScalar(byref sv as ScalarValue, byref outV as EvalValue) as Boolean
  if ScalarIsTime(sv) then
    SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
    return TRUE
  end if
  dim ar as Double, ai as Double
  ScalarLoadCartesian(sv, ar, ai)
  if IsNaNValue(ar) orelse IsNaNValue(ai) then
    if IsNaNValue(ar) then
      if IsNaNValue(ai) orelse (abs(ai) < RATIO_APPROX_EPS) then
        ValueSetScalar(outV, MakeNaN())
        return TRUE
      end if
    end if
    SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
    return TRUE
  end if
  if ScalarHasNonzeroImaginaryPart(sv) = FALSE then
    if IsInfValue(ar) then
      ValueSetScalar(outV, ar)
      return TRUE
    end if
    if IsInfValue(ai) then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return TRUE
    end if
  end if
  if Parser_SupportComplexNumbers andalso ScalarHasNonzeroImaginaryPart(sv) then
    dim numR as LongInt, denR as ULongInt
    dim numI as LongInt, denI as ULongInt
    dim reC as ExactCartesianComponent
    dim aiScale as Double = abs(ai)
    if aiScale < 1.0 then aiScale = 1.0
    dim arScale as Double = abs(ar)
    if arScale < 1.0 then arScale = 1.0
    outV.kind = VK_SCALAR
    outV.scalarValue = sv
    outV.flags = 0
    if ScalarHasRenderRational(sv) orelse ScalarHasImagRenderRational(sv) then
      return TRUE
    end if
    ScalarClearCartesianRenderExact(outV.scalarValue)
    if ScalarImagExactInt64Valid(sv) andalso ScalarImagExactMetadataMatchesFloat(sv) then
      ScalarApplyExactInt64Part(outV.scalarValue, TRUE, sv.imagExactInt64)
    elseif abs(ai) >= RATIO_APPROX_EPS * aiScale then
      if TryApproximateRational(ai, numI, denI) = FALSE then
        SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
        return TRUE
      end if
      ScalarApplyReducedRationalPart(outV.scalarValue, TRUE, numI, denI)
    end if
    if TryExtractExactRealComponent(sv, reC) andalso TryExactCartesianComponentToInt64(reC, numR) then
      ScalarApplyExactInt64Part(outV.scalarValue, FALSE, numR)
    elseif abs(ar) >= RATIO_APPROX_EPS * arScale then
      if TryApproximateRational(ar, numR, denR) = FALSE then
        SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
        return TRUE
      end if
      ScalarApplyReducedRationalPart(outV.scalarValue, FALSE, numR, denR)
    elseif sv.exactInt64Valid then
      ScalarApplyExactInt64Part(outV.scalarValue, FALSE, sv.exactInt64)
    end if
    return TRUE
  end if
  if sv.exactInt64Valid then
    ValueSetInt64(outV, sv.exactInt64)
    return TRUE
  end if
  if sv.exactUInt64Valid then
    ValueSetUInt64(outV, sv.exactUInt64)
    return TRUE
  end if
  dim arScale0 as Double = abs(ar)
  if arScale0 < 1.0 then arScale0 = 1.0
  if abs(ar) < RATIO_APPROX_EPS * arScale0 then
    ValueSetScalar(outV, 0.0)
    return TRUE
  end if
  dim nearInt as LongInt
  if TryGetExactInt64FromDouble(ar, nearInt) then
    ValueSetInt64(outV, nearInt)
    return TRUE
  end if
  dim num as LongInt, den as ULongInt
  if TryApproximateRational(ar, num, den) = FALSE then
    SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
    return TRUE
  end if
  if den = 1 then
    ValueSetInt64(outV, num)
  else
    ValueSetRationalReduced(outV, num, den)
  end if
  return TRUE
end function

private function TryBuiltinRatio(byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  if ValidateBuiltinCallArity(FUNC_RATIO, fnName, args()) = FALSE then return TRUE
  dim vals() as ScalarValue
  dim c as Integer = CopySingleArgToScalarValues(args(0), vals(), FALSE)
  if c <= 0 then
    SetAtLeastOneArgError(fnName)
    return TRUE
  end if
  if c = 1 andalso args(0).kind = VK_SCALAR then
    return TryBuiltinRatioScalar(vals(0), outV)
  end if
  dim i as Integer
  dim arr() as ScalarValue
  redim arr(0 to c - 1)
  for i = 0 to c - 1
    dim tmp as EvalValue
    if TryBuiltinRatioScalar(vals(i), tmp) = FALSE then return FALSE
    if parseError then return FALSE
    arr(i) = tmp.scalarValue
  next i
  ValueSetArrayFromScalarValues(outV, arr())
  return TRUE
end function

private function CmpScalarsForSort(byref a as ScalarValue, byref b as ScalarValue, byval wantLess as Boolean) as Boolean
  if ScalarIsTime(a) orelse ScalarIsTime(b) then
    dim am as LongInt
    dim bm as LongInt
    if ScalarIsTime(a) then
      am = TimeTotalMsFromScalarValue(a)
    elseif ScalarToSecondsMsForTimeOp(a, am) = FALSE then
      am = 0
    end if
    if ScalarIsTime(b) then
      bm = TimeTotalMsFromScalarValue(b)
    elseif ScalarToSecondsMsForTimeOp(b, bm) = FALSE then
      bm = 0
    end if
    if wantLess then return am < bm
    return am > bm
  end if
  dim aNan as Boolean = IsNaNValue(a.scalar)
  dim bNan as Boolean = IsNaNValue(b.scalar)
  if wantLess then
    if aNan then return (bNan = FALSE)
    if bNan then return FALSE
    return a.scalar < b.scalar
  end if
  if bNan then return (aNan = FALSE)
  if aNan then return FALSE
  return a.scalar > b.scalar
end function

private function ScalarSortLess(byref a as ScalarValue, byref b as ScalarValue) as Boolean
  return CmpScalarsForSort(a, b, TRUE)
end function

private function ScalarSortGreater(byref a as ScalarValue, byref b as ScalarValue) as Boolean
  return CmpScalarsForSort(a, b, FALSE)
end function

private function SortbyStableSortIndicesFromEvalKeys(sortKeys() as EvalValue, orderIdx() as Integer, byval count as Integer) as Boolean
  dim i as Integer
  for i = 0 to count - 1
    orderIdx(i) = i
  next i
  if count <= 1 then return TRUE
  dim j as Integer
  dim cmpLess as Boolean
  for i = 1 to count - 1
    j = i
    do while j > 0
      dim cmp as Integer
      if CompareEvalValues(sortKeys(orderIdx(j)), sortKeys(orderIdx(j - 1)), cmp) = FALSE then
        SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
        return FALSE
      end if
      cmpLess = (cmp < 0)
      if cmpLess then
        dim ts as Integer = orderIdx(j)
        orderIdx(j) = orderIdx(j - 1)
        orderIdx(j - 1) = ts
        j -= 1
      else
        exit do
      end if
    loop
  next i
  return TRUE
end function

private function TryBuiltinSortby(byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  if ValidateBuiltinCallArity(FUNC_SORTBY, fnName, args()) = FALSE then return TRUE
  dim keyIsLambda as Boolean = (args(1).kind = VK_INLINE_LAMBDA)
  dim keyIsRef as Boolean = (args(1).kind = VK_FUNCTION_REF)
  if keyIsLambda = FALSE and keyIsRef = FALSE then
    if args(1).kind = VK_ARRAY then
      SetParseError(FB_STR_SORTBY_EXPECTS_ONE_FUNCTION)
    else
      SetParseError(FB_STR_SORTBY_EXPECTS_UNARY_FUNCTION)
    end if
    return TRUE
  end if
  if keyIsRef then
    dim errText as String
    if IsSortbyEligibleFunctionName(args(1).funcRefName, errText) = FALSE then
      SetParseError(errText)
      return TRUE
    end if
  end if
  dim vals() as ScalarValue
  dim c as Integer = CopySingleArgToScalarValues(args(0), vals(), FALSE)
  if c <= 0 then
    SetAtLeastOneArgError(fnName)
    return TRUE
  end if
  dim keys(0 to c - 1) as EvalValue
  dim i as Integer
  for i = 0 to c - 1
    dim keyV as EvalValue
    if keyIsLambda then
      dim la(0 to 0) as EvalValue
      la(0).kind = VK_SCALAR
      la(0).scalarValue = vals(i)
      la(0).flags = 0
      with args(1)
        EvaluateInlineLambda(.lambdaParams(), .lambdaBody, la(), keyV)
      end with
    else
      SortbyInvokeKeyFunction(args(1).funcRefName, vals(i), keyV)
    end if
    if parseError then
      RemapParseErrorToSortbyKeyColumn(args(1))
      return TRUE
    end if
    if keyV.kind = VK_FUNCTION_REF orelse keyV.kind = VK_INLINE_LAMBDA orelse (keyV.kind <> VK_SCALAR andalso keyV.kind <> VK_ARRAY) then
      SetParseError(FB_STR_SORTBY_KEY_MUST_BE_SCALAR_OR_ARRAY)
      return TRUE
    end if
    keys(i) = keyV
  next i
  dim order(0 to c - 1) as Integer
  if SortbyStableSortIndicesFromEvalKeys(keys(), order(), c) = FALSE then
    RemapParseErrorToSortbyKeyColumn(args(1))
    return TRUE
  end if
  dim sorted(0 to c - 1) as ScalarValue
  for i = 0 to c - 1
    sorted(i) = vals(order(i))
  next i
  ValueSetArrayFromScalarValues(outV, sorted())
  return TRUE
end function

private sub SortScalarValueArray(a() as ScalarValue)
  dim lo as Integer = lbound(a)
  dim hi as Integer = ubound(a)
  if hi <= lo then exit sub
  dim leftStack(0 to 63) as Integer
  dim rightStack(0 to 63) as Integer
  dim sp as Integer = 0
  leftStack(0) = lo
  rightStack(0) = hi
  do while sp >= 0
    lo = leftStack(sp)
    hi = rightStack(sp)
    sp -= 1
    do while (hi - lo) > 16
      dim midIdx as Integer = lo + ((hi - lo) \ 2)
      dim pivot as ScalarValue = a(midIdx)
      dim i as Integer = lo
      dim j as Integer = hi
      do
        while ScalarSortLess(a(i), pivot)
          i += 1
        wend
        while ScalarSortGreater(a(j), pivot)
          j -= 1
        wend
        if i <= j then
          dim t as ScalarValue = a(i)
          a(i) = a(j)
          a(j) = t
          i += 1
          j -= 1
        end if
      loop while i <= j
      if (j - lo) < (hi - i) then
        if i < hi then
          sp += 1
          leftStack(sp) = i
          rightStack(sp) = hi
        end if
        hi = j
      else
        if lo < j then
          sp += 1
          leftStack(sp) = lo
          rightStack(sp) = j
        end if
        lo = i
      end if
    loop
    dim x as Integer
    for x = lo + 1 to hi
      dim v as ScalarValue = a(x)
      dim y as Integer = x - 1
      while y >= lo andalso ScalarSortGreater(a(y), v)
        a(y + 1) = a(y)
        y -= 1
      wend
      a(y + 1) = v
    next x
  loop
end sub

private sub ReverseScalarValueArrayInPlace(a() as ScalarValue, byval count as Integer)
  dim i as Integer
  for i = 0 to (count \ 2) - 1
    dim t as ScalarValue = a(i)
    a(i) = a(count - 1 - i)
    a(count - 1 - i) = t
  next i
end sub

' Returns: 1 ok, 0 not an integer count (SetIntegerValuesError), -1 non-positive integer (SetPositiveIntegerError).
private function TryGetRepeatCountArg(byref v as EvalValue, byref outN as LongInt) as Integer
  if v.kind = VK_ARRAY then return 0
  if EvalValueInvolvesTime(v) then return 0
  if Parser_SupportComplexNumbers andalso EvalValueHasNonzeroImaginary(v) then return 0
  dim n as LongInt
  if TryGetExactInt64(v, n) = FALSE then return 0
  if n <= 0 then return -1
  outN = n
  return 1
end function

' Returns 1 when v is a scalar exact integer; 0 otherwise (integer-values error).
private function TryGetRangeIntegerScalarArg(byref v as EvalValue, byref outN as LongInt) as Integer
  if v.kind = VK_ARRAY then return 0
  if EvalValueInvolvesTime(v) then return 0
  if Parser_SupportComplexNumbers andalso EvalValueHasNonzeroImaginary(v) then return 0
  if TryGetExactInt64(v, outN) = FALSE then return 0
  return 1
end function

private function TryHandleBuiltinRange(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  if fnId <> FUNC_RANGE then return FALSE

  dim startV as LongInt, stopV as LongInt, stepV as LongInt
  if TryGetRangeIntegerScalarArg(args(0), startV) = 0 then
    SetIntegerValuesError(fnName)
    return TRUE
  end if
  if TryGetRangeIntegerScalarArg(args(1), stopV) = 0 then
    SetIntegerValuesError(fnName)
    return TRUE
  end if
  if ubound(args) >= 2 then
    if TryGetRangeIntegerScalarArg(args(2), stepV) = 0 then
      SetIntegerValuesError(fnName)
      return TRUE
    end if
  else
    stepV = 1
  end if

  if stepV = 0 then
    SetRangeStepZeroError(fnName)
    return TRUE
  end if

  if (stepV > 0 andalso startV >= stopV) orelse (stepV < 0 andalso startV <= stopV) then
    SetRangeEmptyError(fnName)
    return TRUE
  end if

  dim estimated as ULongInt = EstimateRangeItemCount(startV, stopV, stepV)
  if estimated = 0ull then
    SetRangeEmptyError(fnName)
    return TRUE
  end if
  if AcceptProducedItemCount(fnName, estimated) = FALSE then return TRUE

  dim count as Integer = CInt(estimated)
  dim vals() as ScalarValue
  redim vals(0 to count - 1)
  dim cur as LongInt = startV
  dim i as Integer
  for i = 0 to count - 1
    dim tmp as EvalValue
    ValueSetInt64(tmp, cur)
    vals(i) = tmp.scalarValue
    if i < count - 1 then cur += stepV
  next i

  ValueSetArrayFromScalarValues(outV, vals())
  return TRUE
end function

private function TryHandleBuiltinRepeat(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  if fnId <> FUNC_REPEAT then return FALSE

  dim vals() as ScalarValue
  dim c as Integer = CopySingleArgToScalarValues(args(0), vals(), FALSE)
  if c <= 0 then
    SetAtLeastOneArgError(fnName)
    return TRUE
  end if

  dim n as LongInt
  dim countStatus as Integer = TryGetRepeatCountArg(args(1), n)
  if countStatus = 0 then
    SetIntegerValuesError(fnName)
    return TRUE
  elseif countStatus = -1 then
    SetPositiveIntegerError(fnName)
    return TRUE
  end if

  dim estimated as ULongInt
  if TryMulULongChecked(CULngInt(c), CULngInt(n), estimated) = FALSE then
    SetTooManyValuesError(fnName)
    return TRUE
  end if
  if AcceptProducedItemCount(fnName, estimated) = FALSE then return TRUE

  dim total as Integer = CInt(estimated)
  dim outVals() as ScalarValue
  redim outVals(0 to total - 1)
  dim rep as Integer, i as Integer, blockBase as Integer
  for rep = 0 to CInt(n) - 1
    blockBase = rep * c
    for i = 0 to c - 1
      outVals(blockBase + i) = vals(i)
    next i
  next rep
  ValueSetArrayFromScalarValues(outV, outVals())
  return TRUE
end function

sub ValueSetArrayFromScalarValues(byref outV as EvalValue, vals() as ScalarValue)
  ValueSetScalar(outV, 0)
  outV.kind = VK_ARRAY
  redim outV.arr(lbound(vals) to ubound(vals))
  dim i as Integer
  for i = lbound(vals) to ubound(vals)
    outV.arr(i) = vals(i)
  next i
end sub

private function TryApplyFactorial(byref v as EvalValue, byref outV as EvalValue) as Boolean
  if v.kind = VK_ARRAY then return FALSE
  dim n as LongInt
  if TryGetExactInt64(v, n) = FALSE then return FALSE
  return TryApplyFactorialScalarInt(n, outV)
end function

' Returns: 1 if outV has final passthrough result; 0 if vals()/c are collected; -1 on error (parseError set).
private function TrySingleArgPassthroughOrCollect( _
  args() as EvalValue, _
  byref fnName as String, _
  byval reverseSingleArray as Boolean, _
  byref outV as EvalValue, _
  vals() as ScalarValue, _
  byref c as Integer _
) as Integer
  if ubound(args) = -1 then
    SetAtLeastOneArgError(fnName)
    return -1
  end if

  if ubound(args) = 0 then
    if args(0).kind = VK_SCALAR then
      c = CopySingleArgToScalarValues(args(0), vals(), FALSE)
      ValueSetArrayFromScalarValues(outV, vals())
      return 1
    end if
    c = CopySingleArgToScalarValues(args(0), vals(), reverseSingleArray)
    if c <= 0 then
      SetAtLeastOneArgError(fnName)
      return -1
    end if
    return 0
  end if

  c = CollectRequiredArgsAsScalarValues(args(), vals(), fnName)
  if c <= 0 then return -1
  return 0
end function

private function CallArgsInvolveTime(args() as EvalValue) as Boolean
  dim i as Integer
  if ubound(args) < lbound(args) then return FALSE
  for i = lbound(args) to ubound(args)
    if EvalValueInvolvesTime(args(i)) then return TRUE
  next i
  return FALSE
end function

private function CollectRequiredArgsAsFlatTimeMs(args() as EvalValue, flat() as Double, byref fnName as String) as Integer
  dim argIdx as Integer = lbound(args)
  dim elemIdx as Integer = -1
  dim count as Integer = 0
  dim sv as ScalarValue
  while ArgScalarValueWalkNext(args(), argIdx, elemIdx, sv)
    if ScalarIsTime(sv) = FALSE then
      SetTimeArrayMixedError(fnName & FB_STR_PAR)
      return -1
    end if
    if count = 0 then
      redim flat(0 to 0)
    else
      redim preserve flat(0 to count)
    end if
    flat(count) = CDbl(TimeTotalMsFromScalarValue(sv))
    count += 1
  wend
  if count <= 0 then
    SetAtLeastOneArgError(fnName)
    return -1
  end if
  return count
end function

private function MedianFromDoubleFlatInPlace(a() as Double, byval c as Integer) as Double
  dim midIdx as Integer = c \ 2
  dim leftIdx as Integer = 0
  dim rightIdx as Integer = c - 1
  dim kIdx as Integer = midIdx
  dim i as Integer
  do while leftIdx < rightIdx
    dim pivot as Double = a((leftIdx + rightIdx) \ 2)
    i = leftIdx
    dim j as Integer = rightIdx
    do
      while a(i) < pivot
        i += 1
      wend
      while a(j) > pivot
        j -= 1
      wend
      if i <= j then
        SwapDouble(a(i), a(j))
        i += 1
        j -= 1
      end if
    loop while i <= j
    if kIdx <= j then
      rightIdx = j
    elseif kIdx >= i then
      leftIdx = i
    else
      exit do
    end if
  loop
  dim upper as Double = a(kIdx)
  if (c and 1) = 1 then
    return upper
  end if
  dim lower as Double = a(0)
  for i = 1 to midIdx - 1
    if a(i) > lower then lower = a(i)
  next i
  return (lower + upper) / 2.0
end function




private function CountAggregateScalarValueItems(args() as EvalValue) as Integer
  dim argIdx as Integer = lbound(args)
  dim elemIdx as Integer = -1
  dim sv as ScalarValue
  dim n as Integer = 0
  while ArgScalarValueWalkNext(args(), argIdx, elemIdx, sv)
    n += 1
  wend
  return n
end function

private function TryAggregateFoldByMode(byval mode as AggregateFoldMode, byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  select case mode
  case AFM_COMPLEX
  if ubound(args) = -1 then
    SetAtLeastOneArgError(fnName)
    return TRUE
  end if
  if ubound(args) = 0 andalso args(0).kind = VK_SCALAR then
    outV = args(0)
    return TRUE
  end if
  dim itemCountCx as Integer = CountAggregateScalarValueItems(args())
  if itemCountCx <= 0 then
    SetAtLeastOneArgError(fnName)
    return TRUE
  end if
  dim foldOp as UByte = CHAR_PLUS
  if fnId = FUNC_PRODUCT then foldOp = CHAR_ASTERISK
  if TryFoldExactComplexCartesian(args(), foldOp, outV) then
    if (fnId = FUNC_AVG) orelse (fnId = FUNC_MEAN) then
      dim avgV as EvalValue
      if TryAvgExactComplexFromSum(outV, CLngInt(itemCountCx), avgV) then
        outV = avgV
      else
        dim arCx as Double
        dim aiCx as Double
        ScalarLoadCartesian(outV.scalarValue, arCx, aiCx)
        arCx /= CDbl(itemCountCx)
        aiCx /= CDbl(itemCountCx)
        ValueSetScalarComplexFromDoubles(outV, arCx, aiCx)
      end if
    end if
    return TRUE
  end if
  dim argIdxCx as Integer = lbound(args)
  dim elemIdxCx as Integer = -1
  dim svCx as ScalarValue
  dim arCx as Double
  dim aiCx as Double
  dim brCx as Double
  dim biCx as Double
  if fnId = FUNC_PRODUCT then
    arCx = 1.0
    aiCx = 0.0
  else
    arCx = 0.0
    aiCx = 0.0
  end if
  while ArgScalarValueWalkNext(args(), argIdxCx, elemIdxCx, svCx)
    ScalarLoadCartesian(svCx, brCx, biCx)
    if fnId = FUNC_PRODUCT then
      ScalarComplexCartesianMul(arCx, aiCx, brCx, biCx, arCx, aiCx)
      ' allow `Inf + N*i` or `N + Inf*i`
      if IsNonFiniteValue(arCx) andalso IsNonFiniteValue(aiCx) then exit while
    else
      arCx += brCx
      aiCx += biCx
    end if
  wend
  if (fnId = FUNC_AVG) orelse (fnId = FUNC_MEAN) then
    arCx /= CDbl(itemCountCx)
    aiCx /= CDbl(itemCountCx)
  end if
  ValueSetScalarComplexFromDoubles(outV, arCx, aiCx)
  return TRUE
  case AFM_TIME
  if fnId = FUNC_MEDIAN then
    dim flatMed() as Double
    dim cM as Integer = CollectRequiredArgsAsFlatTimeMs(args(), flatMed(), fnName)
    if cM < 0 then return TRUE
    if cM = 1 then
      ValueSetTimeMs(outV, RoundHalfUpDoubleToLongInt(flatMed(0)))
      return TRUE
    end if
    dim med as Double = MedianFromDoubleFlatInPlace(flatMed(), cM)
    ValueSetTimeMs(outV, RoundHalfUpDoubleToLongInt(med))
    return TRUE
  end if

  dim argIdx as Integer = lbound(args)
  dim elemIdx as Integer = -1
  dim sv as ScalarValue
  dim accMs as LongInt = 0
  dim accInit as Boolean = FALSE
  dim itemCount as Integer = 0
  while ArgScalarValueWalkNext(args(), argIdx, elemIdx, sv)
    if ScalarIsTime(sv) = FALSE then
      SetTimeArrayMixedError(fnName & FB_STR_PAR)
      return TRUE
    end if
    dim curMs as LongInt = TimeTotalMsFromScalarValue(sv)
    if fnId = FUNC_MIN then
      if accInit = FALSE orelse curMs < accMs then accMs = curMs
      accInit = TRUE
    elseif fnId = FUNC_MAX then
      if accInit = FALSE orelse curMs > accMs then accMs = curMs
      accInit = TRUE
    else
      if TryAddTimeMsChecked(accMs, curMs, accMs) = FALSE then
        SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
        return TRUE
      end if
    end if
    itemCount += 1
  wend
  if itemCount <= 0 then
    SetAtLeastOneArgError(fnName)
    return TRUE
  end if
  if (fnId = FUNC_AVG) orelse (fnId = FUNC_MEAN) then
    dim avgD as Double = CDbl(accMs) / CDbl(itemCount)
    ValueSetTimeMs(outV, RoundHalfUpDoubleToLongInt(avgD))
    return TRUE
  end if
  ValueSetTimeMs(outV, accMs)
  return TRUE
  case AFM_REAL
  dim c as Integer
  dim flat() as Double
  dim isAggSimple as Boolean = (fnId = FUNC_SUM) orelse (fnId = FUNC_PRODUCT) orelse (fnId = FUNC_MIN) orelse (fnId = FUNC_MAX) orelse (fnId = FUNC_AVG) orelse (fnId = FUNC_MEAN)
  if ubound(args) = 0 andalso args(0).kind = VK_SCALAR then
    if isAggSimple then
      outV = args(0)
      return TRUE
    end if
  end if

  dim acc as Double = 0
  dim i as Integer

  if isAggSimple then
    if fnId = FUNC_PRODUCT then acc = 1
    if (fnId = FUNC_SUM) orelse (fnId = FUNC_PRODUCT) orelse (fnId = FUNC_MIN) orelse (fnId = FUNC_MAX) then
      if TryAggSimpleExactInteger(args(), fnId, outV) then return TRUE
    end if
    if (fnId = FUNC_MIN) orelse (fnId = FUNC_MAX) then
      dim wantMinAgg as Boolean = (fnId = FUNC_MIN)
      if TryMinMaxPreserveWinner(args(), wantMinAgg, outV) = FALSE then
        SetAtLeastOneArgError(fnName)
      end if
      return TRUE
    end if
    dim itemCount as Integer = 0
    dim argIdx as Integer = lbound(args)
    dim elemIdx as Integer = -1
    dim v as Double
    while ArgScalarWalkNext(args(), argIdx, elemIdx, v)
      if fnId = FUNC_PRODUCT then
        acc *= v
        if IsNonFiniteValue(acc) then exit while
      else
        acc += v
      end if
      itemCount += 1
    wend
    if itemCount <= 0 then SetAtLeastOneArgError(fnName): return TRUE
    if (fnId = FUNC_AVG) orelse (fnId = FUNC_MEAN) then acc /= itemCount
    ValueSetScalar(outV, acc)
    return TRUE
  end if

  if fnId = FUNC_MEDIAN then
    if ubound(args) = lbound(args) then
      dim onlyIdx as Integer = lbound(args)
      if args(onlyIdx).kind = VK_SCALAR then
        outV = args(onlyIdx)
        return TRUE
      end if
      c = ValueArrayLen(args(onlyIdx))
      if c = 1 then
        ValueGetArrayElemAsScalar(args(onlyIdx), lbound(args(onlyIdx).arr), outV)
        return TRUE
      end if
    end if
    c = CollectRequiredArgsAsFlat(args(), flat(), fnName)
    if c <= 0 then return TRUE
    acc = MedianFromDoubleFlatInPlace(flat(), c)
    ValueSetScalar(outV, acc)
    return TRUE
  end if

  if (fnId = FUNC_VARIANCE) orelse (fnId = FUNC_STDDEV) then
    dim meanVal as Double = 0
    dim m2 as Double = 0
    dim n as Integer = 0
    dim argIdxVar as Integer = lbound(args)
    dim elemIdxVar as Integer = -1
    dim vVar as Double
    while ArgScalarWalkNext(args(), argIdxVar, elemIdxVar, vVar)
      n += 1
      dim delta as Double = vVar - meanVal
      meanVal += delta / n
      dim delta2 as Double = vVar - meanVal
      m2 += delta * delta2
    wend
    if n <= 0 then SetAtLeastOneArgError(fnName): return TRUE
    acc = m2 / n
    if fnId = FUNC_STDDEV then acc = sqr(acc)
    ValueSetScalar(outV, acc)
    return TRUE
  end if

  return FALSE
  end select
end function

private function IsBuiltinAggregateFnId(byval fnId as Integer) as Boolean
  select case fnId
    case FUNC_SUM, FUNC_PRODUCT, FUNC_MIN, FUNC_MAX, FUNC_AVG, FUNC_MEAN, FUNC_MEDIAN, FUNC_VARIANCE, FUNC_STDDEV
      return TRUE
    case else
      return FALSE
  end select
end function

private function TryEvaluateBuiltinAggregate(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  if IsBuiltinAggregateFnId(fnId) = FALSE then return FALSE

  if Parser_SupportTimeValues andalso CallArgsInvolveTime(args()) andalso fnId = FUNC_PRODUCT then
    SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
    return TRUE
  end if

  if Parser_SupportComplexNumbers andalso CallArgsInvolveComplex(args()) then
    if CallArgsInvolveTime(args()) then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return TRUE
    end if
    if fnId = FUNC_MIN orelse fnId = FUNC_MAX orelse fnId = FUNC_MEDIAN orelse fnId = FUNC_VARIANCE orelse fnId = FUNC_STDDEV then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return TRUE
    end if
    if fnId = FUNC_SUM orelse fnId = FUNC_PRODUCT orelse fnId = FUNC_AVG orelse fnId = FUNC_MEAN then
      return TryAggregateFoldByMode(AFM_COMPLEX, fnId, fnName, args(), outV)
    end if
  end if

  if Parser_SupportTimeValues andalso CallArgsInvolveTime(args()) then
    if fnId = FUNC_VARIANCE orelse fnId = FUNC_STDDEV then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return TRUE
    end if
    if fnId = FUNC_SUM orelse fnId = FUNC_MIN orelse fnId = FUNC_MAX orelse fnId = FUNC_AVG orelse fnId = FUNC_MEAN orelse fnId = FUNC_MEDIAN then
      return TryAggregateFoldByMode(AFM_TIME, fnId, fnName, args(), outV)
    end if
  end if

  return TryAggregateFoldByMode(AFM_REAL, fnId, fnName, args(), outV)
end function

private function TryBuiltinDispatchWithComplex(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  if CallArgsInvolveComplex(args()) = FALSE then return FALSE
  if CallArgsInvolveTime(args()) then
    SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
    return TRUE
  end if
  if IsBuiltinAggregateFnId(fnId) then return FALSE

  select case fnId
    case FUNC_MIN, FUNC_MAX, FUNC_SORT, FUNC_MEDIAN, FUNC_VARIANCE, FUNC_STDDEV
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return TRUE
    case FUNC_REVERSE, FUNC_UNIQUE, FUNC_UNPACK, FUNC_FLAT, FUNC_REPEAT, FUNC_RANGE, FUNC_LEN
      return FALSE
    case else
      return FALSE
  end select
end function

private function TryBuiltinDispatchWithTime(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  if Parser_SupportTimeValues = FALSE then
    if (fnId = FUNC_MILLISECONDS) orelse (fnId = FUNC_SECONDS) orelse (fnId = FUNC_MINUTES) orelse (fnId = FUNC_HOURS) orelse (fnId = FUNC_DAYS) then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return TRUE
    end if
    return FALSE
  end if
  if (fnId = FUNC_MILLISECONDS) orelse (fnId = FUNC_SECONDS) orelse (fnId = FUNC_MINUTES) orelse (fnId = FUNC_HOURS) orelse (fnId = FUNC_DAYS) then
    if args(0).kind = VK_SCALAR then
      if ScalarIsTime(args(0).scalarValue) = FALSE then
        SetParseError(fnName & FB_STR_TIME_EXPECTS_TIME_ARG)
        return TRUE
      end if
      ValueFromTimeMs(TimeTotalMsFromScalarValue(args(0).scalarValue), fnId, outV)
      return TRUE
    elseif args(0).kind = VK_ARRAY then
      return MapTimeUnitOverArray(fnName, args(0), fnId, outV)
    else
      SetParseError(fnName & FB_STR_TIME_EXPECTS_TIME_ARG)
      return TRUE
    end if
  end if

  if CallArgsInvolveTime(args()) = FALSE then return FALSE

  if IsBuiltinAggregateFnId(fnId) then return FALSE

  if fnId = FUNC_PRODUCT then
    SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
    return TRUE
  end if

  select case fnId
    case FUNC_SORT
      dim argIdxSort as Integer = lbound(args)
      dim elemIdxSort as Integer = -1
      dim svSort as ScalarValue
      while ArgScalarValueWalkNext(args(), argIdxSort, elemIdxSort, svSort)
        if ScalarIsTime(svSort) = FALSE then
          SetTimeArrayMixedError(fnName & FB_STR_PAR)
          return TRUE
        end if
      wend
      return FALSE
    case FUNC_REVERSE, FUNC_UNPACK, FUNC_UNIQUE, FUNC_FLAT, FUNC_REPEAT, FUNC_RANGE, FUNC_LEN
      return FALSE
    case FUNC_VARIANCE, FUNC_STDDEV
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return TRUE
    case else
      ' User-defined and unknown names are handled later; only reject time args on known builtins here.
      if fnId < 0 then return FALSE
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return TRUE
  end select
end function

private function TryBuiltinUniqueScalars(uniqueVals() as ScalarValue, byval c as Integer, byref outV as EvalValue) as Boolean
  dim tmp() as ScalarValue, keys() as ULongInt, used() as UByte
  redim tmp(0 to c - 1)
  dim cap as Integer = NextPow2AtLeast(c * 2)
  if cap < 4 then cap = 4
  redim keys(0 to cap - 1)
  redim used(0 to cap - 1)
  dim outCount as Integer = 0
  dim i as Integer
  dim useComplexUnique as Boolean = FALSE
  if Parser_SupportComplexNumbers then
    for i = 0 to c - 1
      if ScalarHasNonzeroImaginaryPart(uniqueVals(i)) then
        useComplexUnique = TRUE
        exit for
      end if
    next i
  end if
  for i = 0 to c - 1
    dim seen as Boolean = FALSE
    if useComplexUnique then
      dim j as Integer
      for j = 0 to outCount - 1
        if ScalarValuesEqualForCompare(uniqueVals(i), tmp(j)) then
          seen = TRUE
          exit for
        end if
      next j
      if seen = FALSE then
        tmp(outCount) = uniqueVals(i)
        outCount += 1
      end if
    else
      dim v as Double = uniqueVals(i).scalar
      if v <> v then
        tmp(outCount) = uniqueVals(i)
        outCount += 1
        continue for
      end if
      dim key as ULongInt
      if ScalarIsTime(uniqueVals(i)) then
        key = UniqueHashKeyFromDouble(CDbl(TimeTotalMsFromScalarValue(uniqueVals(i))))
      else
        key = UniqueHashKeyFromDouble(v)
      end if
      dim idx as Integer = CInt(key and CULngInt(cap - 1))
      do
        if used(idx) = 0 then exit do
        if keys(idx) = key then
          seen = TRUE
          exit do
        end if
        idx = (idx + 1) and (cap - 1)
      loop
      if seen = FALSE then
        used(idx) = 1
        keys(idx) = key
        tmp(outCount) = uniqueVals(i)
        outCount += 1
      end if
    end if
  next i
  redim preserve tmp(0 to outCount - 1)
  ValueSetArrayFromScalarValues(outV, tmp())
  return TRUE
end function

private function TryHandleBuiltinArrayTransform(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  dim vals() as ScalarValue
  dim c as Integer = 0
  dim prep as Integer
  select case fnId
    case FUNC_SORT
      prep = TrySingleArgPassthroughOrCollect(args(), fnName, FALSE, outV, vals(), c)
      if prep = -1 orelse prep = 1 then return TRUE
      SortScalarValueArray(vals())
      ValueSetArrayFromScalarValues(outV, vals())
      return TRUE
    case FUNC_REVERSE
      prep = TrySingleArgPassthroughOrCollect(args(), fnName, FALSE, outV, vals(), c)
      if prep = -1 orelse prep = 1 then return TRUE
      ReverseScalarValueArrayInPlace(vals(), c)
      ValueSetArrayFromScalarValues(outV, vals())
      return TRUE
    case FUNC_FLAT
      prep = TrySingleArgPassthroughOrCollect(args(), fnName, FALSE, outV, vals(), c)
      if prep = -1 orelse prep = 1 then return TRUE
      ValueSetArrayFromScalarValues(outV, vals())
      return TRUE
    case FUNC_UNPACK
      if ubound(args) = 0 then
        outV = args(0)
      else
        c = CollectRequiredArgsAsScalarValues(args(), vals(), fnName)
        if c <= 0 then return TRUE
        ValueSetArrayFromScalarValues(outV, vals())
      end if
      outV.expandArgs = TRUE
      return TRUE
    case FUNC_UNIQUE
      prep = TrySingleArgPassthroughOrCollect(args(), fnName, FALSE, outV, vals(), c)
      if prep = -1 orelse prep = 1 then return TRUE
      return TryBuiltinUniqueScalars(vals(), c, outV)
    case FUNC_LEN
      ValueSetInt64(outV, CountFlattenedArgs(args()))
      return TRUE
    case else
      return FALSE
  end select
end function

private function TryHandleBuiltinScalarBinary(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  select case fnId
    case FUNC_LOG
      if TryBuiltinMapBinaryTwoArgCore(args(), fnName, FUNC_LOG, FALSE, outV) = FALSE andalso parseError = 0 then
        SetBinaryBuiltinBroadcastFailure(fnName, args(0), args(1), 2)
      end if
      return TRUE
    case FUNC_ATAN2
      if TryBuiltinMapBinaryTwoArgCore(args(), fnName, FUNC_ATAN2, TRUE, outV) = FALSE andalso parseError = 0 then
        SetBinaryBuiltinBroadcastFailure(fnName, args(0), args(1), 2)
      end if
      return TRUE
    case FUNC_HYPOT
      if TryBuiltinMapBinaryTwoArgCore(args(), fnName, FUNC_HYPOT, FALSE, outV) = FALSE andalso parseError = 0 then
        SetBinaryBuiltinBroadcastFailure(fnName, args(0), args(1), 2)
      end if
      return TRUE
    case FUNC_MOD
      if ValueApplyBinaryInt64(args(0), args(1), OP_BIT_MOD, outV) = FALSE andalso parseError = 0 then
        SetBinaryBuiltinBroadcastFailure(fnName, args(0), args(1), 2)
      end if
      return TRUE
    case FUNC_POW
      if ValueApplyBinary(args(0), args(1), CHAR_CARET, outV) = FALSE andalso parseError = 0 then
        SetBinaryBuiltinBroadcastFailure(fnName, args(0), args(1), 2)
      end if
      return TRUE
    case else
      return FALSE
  end select
end function

private function TryHandleBuiltinSpecialScalars(byval fnId as Integer, byref fn as String, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  select case fnId
    case FUNC_FACT
      if Parser_SupportComplexNumbers then
        if ApplyUnaryFunction(fn, args(0), outV) = FALSE then SetNumericErrorInFunction(fnName)
      elseif TryApplyFactorial(args(0), outV) = FALSE then
        SetNonNegativeIntegerError(fnName)
      end if
      return TRUE
    case FUNC_FACTORINT
      if Parser_SupportComplexNumbers andalso EvalValueHasNonzeroImaginary(args(0)) then
        SetIntegerValuesError(fnName)
        return TRUE
      end if
      if args(0).kind = VK_ARRAY then
        SetScalarValuesError(fnName)
        return TRUE
      end if
      if TryApplyFactorint(args(0), outV) = FALSE then SetIntegerValuesError(fnName)
      return TRUE
    case FUNC_RAND
      ValueSetScalar(outV, rnd)
      return TRUE
    case FUNC_RANDOM
      if args(0).kind <> VK_SCALAR orelse args(1).kind <> VK_SCALAR then
        SetScalarValuesError(fnName)
        return TRUE
      end if
      ValueSetScalar(outV, args(0).scalar + (args(1).scalar - args(0).scalar) * rnd)
      return TRUE
    case FUNC_CLAMP
      if args(1).kind <> VK_SCALAR orelse args(2).kind <> VK_SCALAR then
        SetScalarMinMaxError(fnName)
        return TRUE
      end if
      if ApplyClamp(args(0), args(1), args(2), outV) = FALSE then SetNumericErrorInFunction(fnName)
      return TRUE
    case else
      if TryApplyScalarBinaryIntegerBuiltin(fnId, fnName, args(), outV) then return TRUE
      return FALSE
  end select
end function

private function TryHandleBuiltinBaseFormat(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  if GetBuiltinCategory(fnId) <> BC_BASE_FORMAT then return FALSE
  dim c as Integer
  if ubound(args) = 0 then
    outV = args(0)
  else
    dim formatVals() as ScalarValue
    c = CollectRequiredArgsAsScalarValues(args(), formatVals(), fnName)
    if c <= 0 then return TRUE
    ValueSetArrayFromScalarValues(outV, formatVals())
  end if
  ApplyBuiltinFormatRenderMeta(fnId, outV)
  return TRUE
end function

private function TryHandleBuiltinDegRad(byval fnId as Integer, byref fn as String, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  if (fnId <> FUNC_DEG) andalso (fnId <> FUNC_RAD) then return FALSE
  if Parser_SupportComplexNumbers andalso CallArgsInvolveComplex(args()) then
    SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
    return TRUE
  end if
  if ubound(args) = 0 then
    if ApplyUnaryFunction(fn, args(0), outV) = FALSE then SetNumericErrorInFunction(fnName)
    return TRUE
  end if
  dim angleVals() as ScalarValue
  dim c as Integer = CollectRequiredArgsAsScalarValues(args(), angleVals(), fnName)
  if c <= 0 then return TRUE
  dim angleArr as EvalValue
  ValueSetArrayFromScalarValues(angleArr, angleVals())
  if MapUnaryEvalValueById(fnId, angleArr, outV) = FALSE then SetNumericErrorInFunction(fnName)
  return TRUE
end function

private function TryDispatchBuiltinCall(byval fnId as Integer, byref fnName as String, args() as EvalValue, byref outV as EvalValue) as Boolean
  dim fn as String = lcase(fnName)
  if TryBuiltinDispatchWithTime(fnId, fnName, args(), outV) then return TRUE
  if TryEvaluateBuiltinAggregate(fnId, fnName, args(), outV) then return TRUE
  if TryBuiltinDispatchWithComplex(fnId, fnName, args(), outV) then return TRUE
  if TryHandleBuiltinRange(fnId, fnName, args(), outV) then return TRUE
  if TryHandleBuiltinRepeat(fnId, fnName, args(), outV) then return TRUE
  if TryHandleBuiltinArrayTransform(fnId, fnName, args(), outV) then return TRUE
  if TryHandleBuiltinScalarBinary(fnId, fnName, args(), outV) then return TRUE
  if TryHandleBuiltinSpecialScalars(fnId, fn, fnName, args(), outV) then return TRUE
  if TryHandleBuiltinBaseFormat(fnId, fnName, args(), outV) then return TRUE
  if (fnId = FUNC_POLAR) orelse (fnId = FUNC_CART) then
    TryBuiltinPolarCart(fnId, fnName, args(), outV)
    return TRUE
  end if
  if TryHandleBuiltinDegRad(fnId, fn, fnName, args(), outV) then return TRUE
  if IsUnaryBuiltin(fnName) then
    if ApplyUnaryFunction(fn, args(0), outV) = FALSE then SetNumericErrorInFunction(fnName)
    return TRUE
  end if
  return FALSE
end function

private function ParseFunctionCall(byref fnName as String) as EvalValue
  dim outV as EvalValue
  if pStream[0] <> CHAR_LPAREN then SetMissingOpeningBracketError(): return outV
  pStream += 1
  SkipSpaces()
  if TrySetIncompleteOpenedFunctionCallHint(fnName) then return outV

  dim args() as EvalValue
  dim argsCount as Integer = 0
  dim argsCap as Integer = 0
  dim fnLower as String = lcase(fnName)
  if fnLower = FB_STR_SORTBY then
    if TryParseSortbyCallArguments(args(), argsCount, argsCap) = FALSE then return outV
  else
    if TryParseCallArguments(args(), argsCount, argsCap) = FALSE then return outV
  end if

  if TryConsumeClosingParenOrSetError() = FALSE then return outV
  if parseError then return outV

  if argsCount = 0 then
    erase args
  elseif argsCap <> argsCount then
    redim preserve args(0 to argsCount - 1)
  end if

  dim fn as String = fnLower
  dim fnId as Integer = TryFindBuiltinFunctionId(fn)
  if GetBuiltinCategory(fnId) = BC_SORTBY then
    if TryBuiltinSortby(fnName, args(), outV) then return outV
    return outV
  end if
  if GetBuiltinCategory(fnId) = BC_RATIO then
    if TryBuiltinRatio(fnName, args(), outV) then return outV
    return outV
  end if
  NormalizeCallArgs(args())
  if ValidateBuiltinCallArgs(fnId, fnName, args()) = FALSE then return outV
  if ValidateBuiltinCallArity(fnId, fnName, args()) = FALSE then return outV
  if TryDispatchBuiltinCall(fnId, fnName, args(), outV) then return outV

  if EvaluateUserFunction(fnName, args(), outV) then return outV

  AppendUniqueName(unknownFuncsText, fnName)
  ValueSetInt64(outV, 0)
  return outV
end function

private function ParseScalarNumericValue(byref n as EvalValue) as Boolean
  dim dVal as Double = 0
  dim keepExactInt as Boolean = FALSE
  dim keepInt as LongInt = 0
  dim keepExactUInt as Boolean = FALSE
  dim keepUInt as ULongInt = 0
  dim numIntDigits as Integer = 0

  if IsDecimalRadixPrefixedAt(pStream) then
    dim prefixLower as UByte = 0
    dim radix as ULongInt = 0
    if pStream[1] = CHAR_LC_X orelse pStream[1] = CHAR_X then
      prefixLower = CHAR_LC_X
      radix = 16
    elseif pStream[1] = CHAR_LC_B orelse pStream[1] = CHAR_B then
      prefixLower = CHAR_LC_B
      radix = 2
    elseif pStream[1] = CHAR_LC_O orelse pStream[1] = CHAR_O then
      prefixLower = CHAR_LC_O
      radix = 8
    end if
    if prefixLower <> 0 then
      if TryParsePrefixedUIntLiteral(prefixLower, radix, keepUInt) = FALSE then
        SetInvalidPrefixedLiteralError(prefixLower)
        return FALSE
      end if

      dVal = CDbl(keepUInt)
      keepExactUInt = TRUE
      if keepUInt <= FB_I64_MAX_U then
        keepExactInt = TRUE
        keepInt = CLngInt(keepUInt)
      end if
    end if
  end if

  if keepExactUInt = FALSE then
    ' Decimal: single pass accumulates float + optional exact uint64 metadata.
    dim fract as Double = 1
    dim decIntAcc as ULongInt = 0
    dim decFracAcc as ULongInt = 0
    dim numFracDigits as Integer = 0
    dim decIntOverflow as Boolean = FALSE
    dim intPartStarted as Boolean = FALSE
    dim hasDigit as Boolean = FALSE
    const U64_MAX_DIV10 as ULongInt = (FB_U64_MAX \ 10ull)
    const U64_MAX_MOD10 as Integer = CInt(FB_U64_MAX mod 10ull)

    ' Parse integer part, skip leading zeros
    while pStream[0] >= CHAR_DIGIT_0 andalso pStream[0] <= CHAR_DIGIT_9
      dim digit as Integer = (pStream[0] - CHAR_DIGIT_0)
      dVal = dVal * 10 + digit
      hasDigit = TRUE
      if digit <> 0 then
        intPartStarted = TRUE
      end if
      if intPartStarted then
        if not decIntOverflow then
          if (decIntAcc > U64_MAX_DIV10) orelse (decIntAcc = U64_MAX_DIV10 andalso digit > U64_MAX_MOD10) then
            decIntOverflow = TRUE
            decIntAcc = 0
          else
            decIntAcc = quickMult10(decIntAcc) + CULngInt(digit)
          end if
        end if
        numIntDigits += 1
      end if
      pStream += 1
    wend

    ' Parse fractional part
    if pStream[0] = CHAR_DOT then
      intPartStarted = TRUE
      pStream += 1
      while pStream[0] >= CHAR_DIGIT_0 andalso pStream[0] <= CHAR_DIGIT_9
        dim digit as Integer = (pStream[0] - CHAR_DIGIT_0)
        hasDigit = TRUE
        fract /= 10
        dVal += digit * fract
        if not decIntOverflow then
          if (decFracAcc > U64_MAX_DIV10) orelse (decFracAcc = U64_MAX_DIV10 andalso digit > U64_MAX_MOD10) then
            decIntOverflow = TRUE
            decFracAcc = 0
          else
            decFracAcc = quickMult10(decFracAcc) + CULngInt(digit)
          end if
        end if
        numFracDigits += 1
        pStream += 1
      wend
    end if

    ' Check if we have any digits
    if numIntDigits = 0 andalso numFracDigits = 0 then
      if not hasDigit then
        SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
        return FALSE
      end if
      dVal = 0
      keepExactInt = TRUE
      keepInt = 0
      keepExactUInt = TRUE
      keepUInt = 0
    end if

    ' Parse exponent
    dim expVal as Integer = 0
    dim expNegative as Boolean = FALSE
    dim exactIntLiteral as Boolean = FALSE
    dim hasExponent as Boolean = FALSE
    if pStream[0] = CHAR_LC_E orelse pStream[0] = CHAR_E then
      hasExponent = TRUE
      dim pExp as ZString ptr = pStream + 1
      if pExp[0] = CHAR_MINUS then
        expNegative = TRUE
        pExp += 1
      elseif pExp[0] = CHAR_PLUS then
        pExp += 1
      end if
      if pExp[0] < CHAR_DIGIT_0 orelse pExp[0] > CHAR_DIGIT_9 then
        SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
        return FALSE
      end if
      dim expDigits as Integer = 0
      pStream = pExp
      while pStream[0] >= CHAR_DIGIT_0 andalso pStream[0] <= CHAR_DIGIT_9
        dim digit as Integer = (pStream[0] - CHAR_DIGIT_0)
        if digit <> 0 orelse expDigits <> 0 then
          if expDigits < 4 then
            expVal = expVal * 10 + digit
          end if
          expDigits += 1
        end if
        pStream += 1
      wend
      if expNegative then
        expVal = -expVal
      end if
    end if

    if not decIntOverflow then
      ' Compute adjustment: exponent - fracDigits
      dim adjust as Integer = expVal - numFracDigits
      if adjust >= 0 then
        ' Positive adjustment: combine int and frac parts, then scale
        dim significantDigits as Integer = numIntDigits + numFracDigits
        if significantDigits + adjust > 20 then
          ' Result would exceed uint64 range
          decIntOverflow = TRUE
        elseif numFracDigits = 0 andalso adjust = 0 then
          ' Pure decimal integer without exponent: mantissa already in decIntAcc (skip mult/add no-ops)
          dVal = CDbl(decIntAcc)
          keepExactUInt = TRUE
          keepUInt = decIntAcc
          exactIntLiteral = TRUE
        else
          ' Combine: intPart * 10^fracDigits + fracPart (checked: silent ULongInt wrap must not attach exact uint metadata)
          dim exactInt as ULongInt = decIntAcc
          if TryMult10_N_TimesImpl(exactInt, numFracDigits, exactInt) = FALSE then
            decIntOverflow = TRUE
          elseif TryAddULongChecked(exactInt, decFracAcc, exactInt) = FALSE then
            decIntOverflow = TRUE
          elseif adjust > 0 then
            if TryMult10_N_TimesImpl(exactInt, adjust, exactInt) = FALSE then decIntOverflow = TRUE
          end if

          if decIntOverflow = FALSE then
            decIntAcc = exactInt
            numFracDigits = 0
            dVal = CDbl(exactInt)
            keepExactUInt = TRUE
            keepUInt = decIntAcc
            exactIntLiteral = TRUE
          end if
        end if
      else
        ' Negative adjustment: check if exactly divisible
        dim divisor as Integer = -adjust
        if divisor <= numFracDigits then
          dim pow10Divisor as ULongInt
          if TryMult10_N_TimesImpl(1ull, divisor, pow10Divisor) then
            ' Check if the last 'divisor' fractional digits are all zero
            dim fracRemainder as ULongInt = decFracAcc mod pow10Divisor
            if fracRemainder = 0ull then
              ' Divisible: result is exact integer
              dim resultDigits as Integer = numIntDigits + numFracDigits - divisor
              exactIntLiteral = TRUE
              if resultDigits = 0 then
                decIntAcc = 0
              elseif resultDigits <= 20 then
                ' Combine and reduce by divisor
                dim exactInt as ULongInt = decIntAcc
                if TryMult10_N_TimesImpl(exactInt, numFracDigits - divisor, exactInt) = FALSE then
                  exactIntLiteral = FALSE
                elseif TryAddULongChecked(exactInt, decFracAcc \ pow10Divisor, exactInt) = FALSE then
                  exactIntLiteral = FALSE
                else
                  decIntAcc = exactInt
                end if
              else
                ' Too many result digits
                exactIntLiteral = FALSE
              end if
              if exactIntLiteral then
                numFracDigits = 0
                dVal = CDbl(decIntAcc)
              end if
            end if
          end if
        end if
      end if
    end if

    if numFracDigits = 0 andalso exactIntLiteral then
      if decIntAcc <= FB_I64_MAX_U then
        keepExactInt = TRUE
        keepInt = CLngInt(decIntAcc)
      end if
      keepExactUInt = TRUE
      keepUInt = decIntAcc
    elseif hasExponent then
      dVal = dVal * pow(10.0, CDbl(expVal))
    end if
  end if

  if keepExactUInt andalso keepUInt <= FB_I64_MAX_U then
    if keepExactInt = FALSE then
      keepExactInt = TRUE
      keepInt = CLngInt(keepUInt)
    end if
  end if

  if keepExactUInt andalso keepUInt > FB_I64_MAX_U then
    ValueSetUInt64(n, keepUInt)
  elseif keepExactInt then
    ValueSetInt64(n, keepInt)
  elseif keepExactUInt then
    ValueSetUInt64(n, keepUInt)
  else
    ValueSetScalar(n, dVal)
  end if
  return TRUE
end function

private function ParseFactor() as EvalValue
  dim n as EvalValue
  ValueSetInt64(n, 0)
  wasPercentage = FALSE
  dim skipTightImagSuffix as Boolean = FALSE

  SkipSpaces()
  if IsNumericLiteralStartChar(asc(pStream[0])) then
    if Parser_SupportTimeValues then
      select case ClassifyNumericLiteralAtCursor()
      case NLK_COLON_TIME
        if TryParseScalarTimeLiteral(n) = FALSE then return n
        skipTightImagSuffix = TRUE
      case NLK_COMPACT_TIME
        if TryParseCompactSuffixTimeLiteral(n) = FALSE then
          if parseError then return n
          if not ParseScalarNumericValue(n) then return n
        else
          skipTightImagSuffix = TRUE
        end if
      case else
        if not ParseScalarNumericValue(n) then return n
      end select
    else
      if not ParseScalarNumericValue(n) then return n
    end if
  elseif IsIdentStartChar(asc(pStream[0])) then
    dim firstIdentB as UByte = pStream[0]
    dim identStart as ZString ptr = pStream
    dim nam as String = ConsumeIdentTokenFromStream()
    SkipSpaces()
    if pStream[0] = CHAR_LPAREN then
      n = ParseFunctionCall(nam)
      if parseError then return n
      dim indexed as EvalValue
      if TryParseArrayIndex(n, indexed) = FALSE then return n
      n = indexed
    else
      dim canIndex as Boolean = TRUE
      if TryGetConstant(nam, n) = FALSE then
        if GetVariable(nam, n) = FALSE then
          if TryHandleUnknownIdentifier(nam, n, canIndex, identStart) = FALSE then return n
        end if
      end if
      TryOverrideBareImagUnitIdent(n, firstIdentB, nam)
      if canIndex then
        dim indexed as EvalValue
        if TryParseArrayIndex(n, indexed) = FALSE then return n
        n = indexed
      end if
    end if
  elseif pStream[0] = CHAR_LPAREN then
    pStream += 1
    if pStream[0] = CHAR_COMMA then
      SetParseErrorById(PARSE_ERR_UNEXPECTED_COMMA)
      return n
    end if
    if pStream[0] = CHAR_RPAREN then
      if TryConsumeClosingParenOrSetError() = FALSE then return n
      ValueInitArrayLike(n, 0, -1)
      return n
    end if
    dim firstVal as EvalValue = ParseExpression()
    if parseError then return n
    SkipSpaces()
    if pStream[0] = CHAR_COMMA then
      dim vals() as EvalValue
      redim vals(0)
      if firstVal.kind <> VK_SCALAR then SetArrayElementMustBeScalarError(): return n
      vals(0) = firstVal
      dim firstIsT as Boolean = ScalarIsTime(firstVal.scalarValue)
      dim hasComma as Boolean = TRUE
      do
        if TryConsumeCommaArgSeparator(hasComma) = FALSE then return n
        if hasComma = FALSE then exit do
        dim nextVal as EvalValue = ParseExpression()
        if parseError then return n
        if nextVal.kind <> VK_SCALAR then SetArrayElementMustBeScalarError(): return n
        if ScalarIsTime(nextVal.scalarValue) <> firstIsT then
          SetTimeArrayMixedError("array literal")
          return n
        end if
        redim preserve vals(0 to ubound(vals) + 1)
        vals(ubound(vals)) = nextVal
        SkipSpaces()
        if pStream[0] <> CHAR_COMMA andalso pStream[0] <> CHAR_RPAREN then
          SetMismatchedBracketBraceOrUnexpectedToken(asc(pStream[0]))
          return n
        end if
      loop while hasComma
      if TryConsumeClosingParenOrSetError() = FALSE then return n
      ValueInitArrayLike(n, 0, ubound(vals))
      dim arrI as Integer
      for arrI = 0 to ubound(vals)
        ValueSetArrayElemFromScalar(n, arrI, vals(arrI))
      next arrI
    else
      if TryConsumeClosingParenOrSetError() = FALSE then return n
      n = firstVal
    end if
  else
    SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
  end if

  if parseError = FALSE andalso skipTightImagSuffix = FALSE then TryApplyTightImagSuffixToEvalValue(n)
  return n
end function

private function ParsePower() as EvalValue
  dim n as EvalValue = ParseFactor()
  if parseError then return n
  SkipSpaces()

  if pStream[0] = CHAR_ASTERISK andalso pStream[1] = CHAR_ASTERISK then
    pStream += 2
    dim rhs as EvalValue
    rhs = ParseUnary()
    if parseError then return n
    ApplyBinaryParserOpInPlace(n, rhs, CHAR_CARET)
  end if
  return n
end function

private function TryConsumeMultiplicativeOp(byref op as UByte, byref useInt64 as Integer, byref intOp as OperatorBitNameId) as Boolean
  op = 0
  useInt64 = FALSE
  intOp = OP_BIT_NONE
  if pStream[0] = CHAR_ASTERISK andalso pStream[1] <> CHAR_ASTERISK then
    op = CHAR_ASTERISK
    pStream += 1
    return TRUE
  end if
  if pStream[0] = CHAR_DIVIDE then
    op = CHAR_DIVIDE
    pStream += 1
    return TRUE
  end if
  if pStream[0] = CHAR_PERCENT then
    useInt64 = TRUE
    intOp = OP_BIT_MOD
    pStream += 1
    return TRUE
  end if
  if IsImplicitMulStart() then
    op = CHAR_ASTERISK
    return TRUE
  end if
  return FALSE
end function

private sub ApplyMultiplicativeOpInPlace(byref leftV as EvalValue, byref rightV as EvalValue, byval useInt64 as Integer, byval intOp as OperatorBitNameId, byval op as UByte)
  if useInt64 then
    ApplyInt64ParserOpInPlace(leftV, rightV, intOp)
  else
    ApplyBinaryParserOpInPlace(leftV, rightV, op)
  end if
end sub

private const PLAB_KIND_INT64 as Integer = 1
private const PLAB_KIND_ADDITIVE as Integer = 2
private const PLAB_KIND_COMPARISON as Integer = 3
private const PLAB_KIND_MULTIPLICATIVE as Integer = 4

private function ParseUnary() as EvalValue
  SkipSpaces()
  if pStream[0] = CHAR_PLUS then
    pStream += 1
    return ParseUnary()
  elseif pStream[0] = CHAR_MINUS then
    pStream += 1
    dim v as EvalValue
    v = ParseUnary()
    if parseError then return v
    dim outV as EvalValue
    if TryNegateEvalScalarUnary(v, outV) then return outV
    if Parser_SupportComplexNumbers andalso v.kind = VK_SCALAR then
      ' Unary '-' on a complex-capable scalar must negate both components directly.
      ' This avoids NaN/Inf component loss in the generic *(-1) fallback.
      dim ar as Double, ai as Double
      ScalarLoadCartesian(v.scalarValue, ar, ai)
      dim outI as Double = -ai
      if IsNaNValue(ai) then outI = MakeNaN()
      ValueSetScalarComplexFromDoubles(outV, -ar, outI)
      return outV
    end if
    dim minusOne as EvalValue
    ValueSetInt64(minusOne, -1)
    if ApplyBinaryParserOp(v, minusOne, CHAR_ASTERISK, outV) = FALSE then return outV
    return outV
  elseif pStream[0] = CHAR_TILDE then
    pStream += 1
    dim v as EvalValue
    v = ParseUnary()
    if parseError then return v
    if Parser_SupportComplexNumbers andalso EvalValueHasNonzeroImaginary(v) then
      SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      return v
    end if
    dim outV as EvalValue
    dim minusOne as EvalValue
    ValueSetInt64(minusOne, -1)
    if ApplyInt64ParserOp(v, minusOne, OP_BIT_XOR, outV) = FALSE then return outV
    return outV
  elseif pStream[0] = CHAR_EXCLAMATION andalso pStream[1] <> CHAR_EQUALS then
    pStream += 1
    dim v as EvalValue
    v = ParseUnary()
    if parseError then return v
    ValueSetBoolResult(not EvalValueIsTruthy(v), v)
    return v
  elseif MatchKeywordOperator(OpName(OP_NOT)) then
    dim v as EvalValue = ParseLogicalNot()
    if parseError then return v
    ValueSetBoolResult(not EvalValueIsTruthy(v), v)
    return v
  end if

  dim n as EvalValue = ParsePower()
  if parseError then return n

  SkipSpaces()
  while pStream[0] = CHAR_LBRACKET
    dim indexed as EvalValue
    if TryParseArrayIndex(n, indexed) = FALSE then return n
    n = indexed
    SkipSpaces()
  wend

  SkipSpaces()
  if pStream[0] = CHAR_PERCENT then
    pStream += 1
    if IsPercentageTail() then
      dim divV as EvalValue, outV as EvalValue
      ValueSetScalar(divV, 100.0)
      if ValueApplyBinary(n, divV, CHAR_DIVIDE, outV) = FALSE then
        SetParseErrorById(PARSE_ERR_INCOMPATIBLE_OPERANDS)
      else
        n = outV
        wasPercentage = TRUE
      end if
    else
      pStream -= 1
    end if
  end if
  return n
end function

private function ParseMultiplicative() as EvalValue
  return ParseLeftAssocBinary(PLAB_KIND_MULTIPLICATIVE, 0)
end function

private function IsAdditiveTermBoundary() as Boolean
  return (pStream[0] = CHAR_NUL) orelse (pStream[0] = CHAR_RPAREN) orelse (pStream[0] = CHAR_PLUS) orelse (pStream[0] = CHAR_MINUS) orelse (pStream[0] = CHAR_COMMA) orelse (pStream[0] = CHAR_SEMICOLON) _
         orelse (pStream[0] = CHAR_LESS_THAN) orelse (pStream[0] = CHAR_GREATER_THAN) orelse (pStream[0] = CHAR_AMPERSAND) orelse (pStream[0] = CHAR_CARET) orelse (pStream[0] = CHAR_PIPE) _
         orelse (pStream[0] = CHAR_RBRACKET) orelse (pStream[0] = CHAR_RBRACE)
end function

private function TryConsumeAdditiveOperator(byref op as UByte) as Boolean
  if (pStream[0] = CHAR_PLUS) orelse (pStream[0] = CHAR_MINUS) then
    op = pStream[0]
    pStream += 1
    return TRUE
  end if
  return FALSE
end function

private sub ApplyPercentageRhsByContext(byref lhs as EvalValue, byref rhs as EvalValue)
  if wasPercentage = FALSE then exit sub
  SkipSpaces()
  if IsAdditiveTermBoundary() then
    dim pctV as EvalValue
    if ApplyBinaryParserOp(lhs, rhs, CHAR_ASTERISK, pctV) then rhs = pctV
  end if
end sub

private function ParseAdditive() as EvalValue
  return ParseLeftAssocBinary(PLAB_KIND_ADDITIVE, 0)
end function

private const PARSE_INT64_LEVEL_ADDITIVE as Integer = 1
private const PARSE_INT64_LEVEL_SHIFT as Integer = 2
private const PARSE_INT64_LEVEL_BITAND as Integer = 3
private const PARSE_INT64_LEVEL_BITXOR as Integer = 4

private function ParseInt64OperandLevel(byval levelId as Integer) as EvalValue
  select case levelId
    case PARSE_INT64_LEVEL_ADDITIVE: return ParseAdditive()
    case PARSE_INT64_LEVEL_SHIFT: return ParseShift()
    case PARSE_INT64_LEVEL_BITAND: return ParseBitwiseAnd()
    case PARSE_INT64_LEVEL_BITXOR: return ParseBitwiseXor()
  end select
  dim outV as EvalValue
  ValueSetInt64(outV, 0)
  SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
  return outV
end function

private function TryConsumeInt64BinaryOp(byval levelId as Integer, byref outOp as OperatorBitNameId) as Boolean
  select case levelId
    case PARSE_INT64_LEVEL_ADDITIVE
      if (pStream[0] = CHAR_LESS_THAN andalso pStream[1] = CHAR_LESS_THAN) orelse (pStream[0] = CHAR_GREATER_THAN andalso pStream[1] = CHAR_GREATER_THAN) then
        if pStream[0] = CHAR_LESS_THAN then outOp = OP_BIT_SHL else outOp = OP_BIT_SHR
        pStream += 2
        return TRUE
      end if
    case PARSE_INT64_LEVEL_SHIFT
      if pStream[0] = CHAR_AMPERSAND andalso pStream[1] <> CHAR_AMPERSAND then
        outOp = OP_BIT_AND
        pStream += 1
        return TRUE
      end if
    case PARSE_INT64_LEVEL_BITAND
      if pStream[0] = CHAR_CARET then
        outOp = OP_BIT_XOR
        pStream += 1
        return TRUE
      end if
    case PARSE_INT64_LEVEL_BITXOR
      if pStream[0] = CHAR_PIPE andalso pStream[1] <> CHAR_PIPE then
        outOp = OP_BIT_OR
        pStream += 1
        return TRUE
      end if
  end select
  return FALSE
end function

private function ParseShift() as EvalValue
  return ParseLeftAssocBinary(PLAB_KIND_INT64, PARSE_INT64_LEVEL_ADDITIVE)
end function

private function ParseBitwiseAnd() as EvalValue
  return ParseLeftAssocBinary(PLAB_KIND_INT64, PARSE_INT64_LEVEL_SHIFT)
end function

private function ParseBitwiseXor() as EvalValue
  return ParseLeftAssocBinary(PLAB_KIND_INT64, PARSE_INT64_LEVEL_BITAND)
end function

private function ParseBitwiseOr() as EvalValue
  return ParseLeftAssocBinary(PLAB_KIND_INT64, PARSE_INT64_LEVEL_BITXOR)
end function

private function TryConsumeComparisonOperator(byref outOp as OperatorCmpNameId) as Boolean
  if pStream[0] = CHAR_EQUALS then
    if pStream[1] = CHAR_EQUALS then
      outOp = OP_CMP_EQ
      pStream += 2
    else
      outOp = OP_CMP_EQ
      pStream += 1
    end if
    return TRUE
  end if
  if pStream[0] = CHAR_LESS_THAN then
    if pStream[1] = CHAR_GREATER_THAN then
      outOp = OP_CMP_NE
      pStream += 2
    elseif pStream[1] = CHAR_EQUALS then
      outOp = OP_CMP_LE
      pStream += 2
    elseif pStream[1] = CHAR_LESS_THAN then
      return FALSE
    else
      outOp = OP_CMP_LT
      pStream += 1
    end if
    return TRUE
  end if
  if pStream[0] = CHAR_GREATER_THAN then
    if pStream[1] = CHAR_EQUALS then
      outOp = OP_CMP_GE
      pStream += 2
    elseif pStream[1] = CHAR_GREATER_THAN then
      return FALSE
    else
      outOp = OP_CMP_GT
      pStream += 1
    end if
    return TRUE
  end if
  if pStream[0] = CHAR_EXCLAMATION andalso pStream[1] = CHAR_EQUALS then
    outOp = OP_CMP_NE
    pStream += 2
    return TRUE
  end if
  return FALSE
end function

private function ParseLeftAssocBinary(byval kind as Integer, byval int64LevelId as Integer) as EvalValue
  dim n as EvalValue
  dim termWasPercentage as Boolean = FALSE

  select case kind
    case PLAB_KIND_INT64
      n = ParseInt64OperandLevel(int64LevelId)
    case PLAB_KIND_ADDITIVE
      n = ParseMultiplicative()
    case PLAB_KIND_COMPARISON
      n = ParseBitwiseOr()
    case PLAB_KIND_MULTIPLICATIVE
      n = ParseUnary()
      termWasPercentage = wasPercentage
    case else
      ValueSetInt64(n, 0)
      SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
      return n
  end select

  SkipSpaces()
  while TRUE
    if parseError then exit while

    select case kind
      case PLAB_KIND_INT64
        dim intOp as OperatorBitNameId = OP_BIT_NONE
        if TryConsumeInt64BinaryOp(int64LevelId, intOp) = FALSE then exit while
        dim n2Int64 as EvalValue = ParseInt64OperandLevel(int64LevelId)
        ApplyInt64ParserOpInPlace(n, n2Int64, intOp)
      case PLAB_KIND_ADDITIVE
        dim addOp as UByte = 0
        if TryConsumeAdditiveOperator(addOp) = FALSE then exit while
        dim n2Add as EvalValue = ParseMultiplicative()
        ApplyPercentageRhsByContext(n, n2Add)
        ApplyBinaryParserOpInPlace(n, n2Add, addOp)
      case PLAB_KIND_COMPARISON
        dim cmpOp as OperatorCmpNameId = OP_CMP_NONE
        if TryConsumeComparisonOperator(cmpOp) = FALSE then exit while
        dim n2Cmp as EvalValue = ParseBitwiseOr()
        ApplyComparisonParserOpInPlace(n, n2Cmp, cmpOp)
      case PLAB_KIND_MULTIPLICATIVE
        dim mulOp as UByte = 0
        dim useInt64 as Integer = FALSE
        dim mulIntOp as OperatorBitNameId = OP_BIT_NONE
        if TryConsumeMultiplicativeOp(mulOp, useInt64, mulIntOp) = FALSE then exit while
        dim n2Mul as EvalValue = ParseUnary()
        ApplyMultiplicativeOpInPlace(n, n2Mul, useInt64, mulIntOp, mulOp)
        termWasPercentage = FALSE
      case else
        exit while
    end select
    SkipSpaces()
  wend

  if kind = PLAB_KIND_MULTIPLICATIVE then
    wasPercentage = termWasPercentage
  end if
  return n
end function

private function ParseComparison() as EvalValue
  return ParseLeftAssocBinary(PLAB_KIND_COMPARISON, 0)
end function

private function ParseLogicalNot() as EvalValue
  SkipSpaces()
  if MatchKeywordOperator(OpName(OP_NOT)) then
    SkipSpaces()
    dim rhs as EvalValue = ParseLogicalNot()
    ValueSetBoolResult(not EvalValueIsTruthy(rhs), rhs)
    return rhs
  end if
  return ParseComparison()
end function

private function TryConsumeLogicalBinaryOperator(byval keywordId as OperatorNameId, byval symbol as UByte) as Boolean
  if pStream[0] = symbol andalso pStream[1] = symbol then
    pStream += 2
    return TRUE
  end if
  if MatchKeywordOperator(OpName(keywordId)) then
    return TRUE
  end if
  return FALSE
end function

private function ParseLeftAssocLogical(byval keywordId as OperatorNameId, byval symbol as UByte, byval useOr as Boolean) as EvalValue
  dim n as EvalValue
  if useOr then
    n = ParseLogicalAnd()
  else
    n = ParseLogicalNot()
  end if
  SkipSpaces()
  while TRUE
    if parseError then exit while
    if TryConsumeLogicalBinaryOperator(keywordId, symbol) = FALSE then exit while

    dim n2 as EvalValue
    if useOr then
      n2 = ParseLogicalAnd()
    else
      n2 = ParseLogicalNot()
    end if
    if useOr then
      ValueSetBoolResult(EvalValueIsTruthy(n) orelse EvalValueIsTruthy(n2), n)
    else
      ValueSetBoolResult(EvalValueIsTruthy(n) andalso EvalValueIsTruthy(n2), n)
    end if
    SkipSpaces()
  wend
  return n
end function

private function ParseLogicalAnd() as EvalValue
  return ParseLeftAssocLogical(OP_AND, CHAR_AMPERSAND, FALSE)
end function

private function ParseLogicalOr() as EvalValue
  return ParseLeftAssocLogical(OP_OR, CHAR_PIPE, TRUE)
end function

private function ParseExpression() as EvalValue
  wasPercentage = FALSE
  return ParseLogicalOr()
end function

private function TryValidateUserFunctionBodyExpression(byref body as String, fnParams() as String, byref errText as String) as Boolean
  dim savedStream as ZString ptr = pStream
  dim savedExprStart as ZString ptr = exprStart
  dim savedParseError as Integer = parseError
  dim savedWasPercentage as Boolean = wasPercentage
  dim savedBaseCol as Integer = errorBaseCol
  dim savedLastErr as String = lastErrorText
  dim savedUnknownVars as String = unknownVarsText
  dim savedUnknownFuncs as String = unknownFuncsText

#ifdef __FB_FUNC_VARS_OVERRIDE_GLOBALS__
  dim savedFunctionVariableCount as Integer = functionVariableCount
  dim savedFunctionVariableNames() as String
  if savedFunctionVariableCount > 0 then
    redim savedFunctionVariableNames(0 to savedFunctionVariableCount - 1)
    for iSaved as Integer = 0 to savedFunctionVariableCount - 1
      savedFunctionVariableNames(iSaved) = functionVariableNames(iSaved)
    next iSaved
  end if

  dim paramCount as Integer = 0
  if ubound(fnParams) >= lbound(fnParams) then paramCount = ubound(fnParams) - lbound(fnParams) + 1
  if paramCount > 0 then
    redim functionVariableNames(0 to paramCount - 1)
    for iParam as Integer = 0 to paramCount - 1
      functionVariableNames(iParam) = fnParams(lbound(fnParams) + iParam)
    next iParam
    functionVariableCount = paramCount
  else
    erase functionVariableNames
    functionVariableCount = 0
  end if
#endif

  lastErrorText = ""
  unknownVarsText = ""
  unknownFuncsText = ""
  pStream = strptr(body)
  exprStart = pStream
  errorBaseCol = 1
  parseError = 0

  dim dummy as EvalValue
  dummy = ParseExpression()
  SkipSpaces()

  dim ok as Boolean = TRUE
  if parseError then
    ok = FALSE
    errText = lastErrorText
    if len(errText) = 0 then errText = FB_STR_FAILED_TO_PARSE_USER_FUNCTION_BODY
  elseif pStream[0] <> CHAR_NUL then
    ok = FALSE
    errText = FB_STR_UNEXPECTED_INPUT
  end if

  pStream = savedStream
  exprStart = savedExprStart
  parseError = savedParseError
  wasPercentage = savedWasPercentage
  errorBaseCol = savedBaseCol
  lastErrorText = savedLastErr
  unknownVarsText = savedUnknownVars
  unknownFuncsText = savedUnknownFuncs

#ifdef __FB_FUNC_VARS_OVERRIDE_GLOBALS__
  if savedFunctionVariableCount > 0 then
    redim functionVariableNames(0 to savedFunctionVariableCount - 1)
    for iSaved as Integer = 0 to savedFunctionVariableCount - 1
      functionVariableNames(iSaved) = savedFunctionVariableNames(iSaved)
    next iSaved
  else
    erase functionVariableNames
  end if
  functionVariableCount = savedFunctionVariableCount
#endif

  return ok
end function

private sub ResetTopLevelEvaluationState(byref exprInput as String)
  lastErrorText = ""
  unknownVarsText = ""
  unknownFuncsText = ""
  udfCallStackSp = 0
  errorBaseCol = 1
  rootInputExpr = exprInput
  parseError = 0
  pStream = 0
  exprStart = 0
  lastRawResultValid = FALSE
  RawResultClear(lastRawResult)
end sub

private sub RawCartesianFromScalarValue(byref sv as ScalarValue, byval imagPart as Boolean, byref outC as RawCartesianScalar)
  ScalarRepairExactMetadata(sv)
  outC.kind = RSK_FLOATING
  outC.floatValue = 0.0
  if imagPart = FALSE then
    if ScalarIsTime(sv) then
      outC.kind = RSK_TIME
      outC.intValue = TimeTotalMsFromScalarValue(sv)
      exit sub
    end if
    if ScalarHasRenderRational(sv) then
      if ScalarExactUInt64MetadataValid(sv) orelse sv.exactUInt64 <> 0 then
        RawCartesianAssignReducedRational(sv.exactInt64, sv.exactUInt64, outC)
        exit sub
      end if
    end if
    if (sv.flags and SVF_RENDER_INT_POWER) <> 0 then
      if sv.imagExactUInt64 > 1ull then
        outC.kind = RSK_INT_POWER
        outC.ratNum = sv.imagExactInt64
        outC.ratDen = sv.imagExactUInt64
        exit sub
      end if
    end if
    if ScalarExactInt64Valid(sv) then
      outC.kind = RSK_INT64
      outC.intValue = sv.exactInt64
      exit sub
    end if
    if ScalarExactUInt64Valid(sv) then
      outC.kind = RSK_UINT64
      outC.uintValue = sv.exactUInt64
      exit sub
    end if
    if sv.scalarStorageKind = SSK_INT64 then
      outC.kind = RSK_INT64
      outC.intValue = sv.exactInt64
      exit sub
    end if
    if sv.scalarStorageKind = SSK_UINT64 then
      outC.kind = RSK_UINT64
      outC.uintValue = sv.exactUInt64
      exit sub
    end if
    outC.kind = RSK_FLOATING
    outC.floatValue = sv.scalar
    exit sub
  end if
  if ScalarHasImagRenderRational(sv) then
    if ScalarImagExactUInt64MetadataValid(sv) orelse sv.imagExactUInt64 <> 0 then
      RawCartesianAssignReducedRational(sv.imagExactInt64, sv.imagExactUInt64, outC)
      exit sub
    end if
  end if
  if ScalarImagExactInt64Valid(sv) then
    outC.kind = RSK_INT64
    outC.intValue = sv.imagExactInt64
    exit sub
  end if
  if ScalarImagExactUInt64Valid(sv) then
    if sv.imagExactUInt64 <= FB_I64_MAX_U then
      outC.kind = RSK_INT64
      outC.intValue = CLngInt(sv.imagExactUInt64)
    else
      outC.kind = RSK_UINT64
      outC.uintValue = sv.imagExactUInt64
    end if
    exit sub
  end if
  if sv.imagExactInt64 <> 0 orelse sv.imagExactUInt64 <> 0 then
    if sv.imagExactInt64 <> 0 then
      outC.kind = RSK_INT64
      outC.intValue = sv.imagExactInt64
    elseif sv.imagExactUInt64 <= FB_I64_MAX_U then
      outC.kind = RSK_INT64
      outC.intValue = CLngInt(sv.imagExactUInt64)
    else
      outC.kind = RSK_UINT64
      outC.uintValue = sv.imagExactUInt64
    end if
    exit sub
  end if
  outC.kind = RSK_FLOATING
  outC.floatValue = sv.imag
end sub

private sub ScalarValueLoadFromRawCartesian(byref c as RawCartesianScalar, byref sv as ScalarValue, byval imagPart as Boolean)
  select case c.kind
  case RSK_TIME
    if imagPart then exit sub
    sv.scalarStorageKind = SSK_TIME
    sv.exactInt64 = c.intValue
    sv.scalar = CDbl(c.intValue) / 1000.0
    sv.exactInt64Valid = FALSE
    sv.exactUInt64Valid = FALSE
  case RSK_INT64
    if imagPart then
      sv.imag = CDbl(c.intValue)
      sv.imagExactInt64 = c.intValue
      ScalarSetImagExactInt64Valid(sv, TRUE)
    else
      sv.scalarStorageKind = SSK_INT64
      sv.scalar = CDbl(c.intValue)
      sv.exactInt64Valid = TRUE
      sv.exactInt64 = c.intValue
      if c.intValue >= 0 then
        sv.exactUInt64Valid = TRUE
        sv.exactUInt64 = CULngInt(c.intValue)
      else
        sv.exactUInt64Valid = FALSE
        sv.exactUInt64 = 0
      end if
    end if
  case RSK_UINT64
    if imagPart then
      sv.imag = CDbl(c.uintValue)
      if c.uintValue <= FB_I64_MAX_U then
        sv.imagExactInt64 = CLngInt(c.uintValue)
        ScalarSetImagExactInt64Valid(sv, TRUE)
      else
        sv.imagExactUInt64 = c.uintValue
        ScalarSetImagExactUInt64Valid(sv, TRUE)
      end if
    else
      sv.scalarStorageKind = SSK_UINT64
      sv.scalar = CDbl(c.uintValue)
      sv.exactUInt64Valid = TRUE
      sv.exactUInt64 = c.uintValue
      if c.uintValue <= FB_I64_MAX_U then
        sv.exactInt64Valid = TRUE
        sv.exactInt64 = CLngInt(c.uintValue)
      else
        sv.exactInt64Valid = FALSE
        sv.exactInt64 = 0
      end if
    end if
  case RSK_RATIONAL
    if imagPart then
      sv.flags or= SVF_IMAG_RENDER_RATIONAL
      sv.imagExactInt64 = c.ratNum
      sv.imagExactUInt64 = c.ratDen
      ScalarSetImagExactInt64Valid(sv, TRUE)
      ScalarSetImagExactUInt64Valid(sv, TRUE)
    else
      sv.flags or= SVF_RENDER_RATIONAL
      sv.exactInt64Valid = TRUE
      sv.exactInt64 = c.ratNum
      sv.exactUInt64Valid = TRUE
      sv.exactUInt64 = c.ratDen
      sv.scalar = CDbl(c.ratNum) / CDbl(c.ratDen)
    end if
  case else
    if imagPart then
      sv.imag = c.floatValue
    else
      sv.scalarStorageKind = SSK_FLOATINGPOINT
      sv.scalar = c.floatValue
      sv.exactInt64Valid = FALSE
      sv.exactUInt64Valid = FALSE
    end if
  end select
end sub

private sub ScalarValueFromRawScalar(byref s as RawScalar, byref sv as ScalarValue)
  sv.scalarStorageKind = SSK_FLOATINGPOINT
  sv.flags = 0
  sv.scalar = 0.0
  sv.exactInt64Valid = FALSE
  sv.exactInt64 = 0
  sv.exactUInt64Valid = FALSE
  sv.exactUInt64 = 0
  ScalarClearImag(sv)
  if s.kind = RSK_COMPLEX then
    ScalarValueLoadFromRawCartesian(s.real, sv, FALSE)
    ScalarValueLoadFromRawCartesian(s.imag, sv, TRUE)
    exit sub
  end if
  ScalarValueLoadFromRawCartesian(s.real, sv, FALSE)
end sub

function Parser_FormatRawCartesianRenderBase(byref c as RawCartesianScalar, byval renderBase as Integer, byval renderUnsigned as Boolean) as String
  if renderBase = 0 then return ""
  dim sv as ScalarValue
  ScalarValueLoadFromRawCartesian(c, sv, FALSE)
  dim outText as String
  if TryFormatScalarByRenderBase(sv, renderBase, renderUnsigned, outText) then return outText
  return ""
end function

function Parser_FormatRawScalarRenderBase(byref s as RawScalar) as String
  if s.renderBase = 0 then return ""
  dim sv as ScalarValue
  ScalarValueFromRawScalar(s, sv)
  dim outText as String
  if s.kind = RSK_COMPLEX then
    if TryFormatComplexScalarByRenderBase(sv, s.renderBase, s.renderUnsigned, outText) then return outText
  else
    if TryFormatScalarByRenderBase(sv, s.renderBase, s.renderUnsigned, outText) then return outText
  end if
  return ""
end function

private sub RawScalarFromScalarValue(byref sv as ScalarValue, byref outS as RawScalar, byval renderBase as UInteger, byval renderUnsigned as Boolean)
  outS.renderBase = renderBase
  outS.renderUnsigned = renderUnsigned
  if ScalarHasNonzeroImaginaryPart(sv) then
    outS.kind = RSK_COMPLEX
    RawCartesianFromScalarValue(sv, FALSE, outS.real)
    RawCartesianFromScalarValue(sv, TRUE, outS.imag)
    exit sub
  end if
  RawCartesianFromScalarValue(sv, FALSE, outS.real)
  outS.kind = outS.real.kind
  RawCartesianScalarClear(outS.imag)
end sub

private sub EvalValueToRawResult(byref v as EvalValue, byref outR as RawResult)
  RawResultClear(outR)
  if v.kind = VK_SCALAR then
    outR.kind = RRK_SCALAR
    RawScalarFromScalarValue(v.scalarValue, outR.scalar, v.renderBase, v.renderUnsigned)
    exit sub
  end if
  dim n as Integer = ValueArrayLen(v)
  if n <= 0 then exit sub
  outR.kind = RRK_ARRAY
  redim outR.arr(0 to n - 1)
  dim i as Integer
  for i = 0 to n - 1
    RawScalarFromScalarValue(v.arr(i), outR.arr(i), v.renderBase, v.renderUnsigned)
  next i
end sub

private sub CommitLastRawResult(byref v as EvalValue)
  EvalValueToRawResult(v, lastRawResult)
  lastRawResultValid = TRUE
end sub

private sub InvalidateLastRawResult()
  lastRawResultValid = FALSE
  RawResultClear(lastRawResult)
end sub

sub Parser_ClearVariables()
  erase variables
  erase userFunctions
  dim emptyExpr as String = ""
  ResetTopLevelEvaluationState(emptyExpr)
  dim probeDefault as EvalValue
  ValueSetInt64(probeDefault, 1)
  SetVariable(FB_STR_FORMAL_VALIDATION_PROBE, probeDefault)
  if Parser_SupportComplexNumbers then
    dim iu as EvalValue
    ValueSetImagUnit(iu)
    SetVariable(FB_STR_I, iu)
  end if
end sub

function Parser_TryEvaluate(byref sExpr as String, byref result as Double) as Boolean
  dim textResult as String, isArray as Boolean
  return Parser_TryEvaluateEx(sExpr, result, textResult, isArray)
end function

function Parser_TryEvaluateExRaw(byref sExpr as String, byref rawOut as RawResult) as Boolean
  dim result as Double
  dim resultText as String
  dim isArray as Boolean
  RawResultClear(rawOut)
  if Parser_TryEvaluateEx(sExpr, result, resultText, isArray) = FALSE then
    return FALSE
  end if
  if Parser_GetLastRawResult(rawOut) = FALSE then
    RawResultClear(rawOut)
  end if
  return TRUE
end function

private function IsTopLevelStatementSeparatorChar(byval ch as UByte, byval depthParen as Integer, byval depthBracket as Integer, byval depthBrace as Integer) as Boolean
  return (ch = CHAR_SEMICOLON) andalso (depthParen = 0) andalso (depthBracket = 0) andalso (depthBrace = 0)
end function

private sub UpdateNestingDepths(byval ch as UByte, byref depthParen as Integer, byref depthBracket as Integer, byref depthBrace as Integer)
  if ch = CHAR_LPAREN then
    depthParen += 1
  elseif ch = CHAR_RPAREN then
    if depthParen > 0 then depthParen -= 1
  elseif ch = CHAR_LBRACKET then
    depthBracket += 1
  elseif ch = CHAR_RBRACKET then
    if depthBracket > 0 then depthBracket -= 1
  elseif ch = CHAR_LBRACE then
    depthBrace += 1
  elseif ch = CHAR_RBRACE then
    if depthBrace > 0 then depthBrace -= 1
  end if
end sub

private function IsStmtUdfDefinitionAt(byref stmt as String) as Boolean
  if Len(stmt) = 0 then return FALSE
  dim save as ZString ptr = pStream
  pStream = StrPtr(stmt)
  SkipSpaces()
  if IsIdentStartChar(asc(pStream[0])) = FALSE then
    pStream = save
    return FALSE
  end if
  ConsumeIdentTokenFromStream()
  SkipSpaces()
  if pStream[0] <> CHAR_LPAREN then
    pStream = save
    return FALSE
  end if
  pStream += 1
  dim depth as Integer = 1
  while pStream[0] <> CHAR_NUL andalso depth > 0
    if pStream[0] = CHAR_LPAREN then
      depth += 1
    elseif pStream[0] = CHAR_RPAREN then
      depth -= 1
    end if
    pStream += 1
  wend
  if depth <> 0 then
    pStream = save
    return FALSE
  end if
  SkipSpaces()
  dim isUdfDef as Boolean = (pStream[0] = CHAR_EQUALS andalso pStream[1] <> CHAR_EQUALS)
  pStream = save
  return isUdfDef
end function

private function TryEvaluateTopLevelStatements(byref exprInput as String, byref result as Double, byref resultText as String, byref isArray as Boolean, byref handled as Boolean) as Boolean
  handled = FALSE
  if instr(exprInput, ";") <= 0 then return TRUE

  dim hasTopLevelSep as Integer = 0
  dim scanParen as Integer = 0
  dim scanBracket as Integer = 0
  dim scanBrace as Integer = 0
  dim scanP as ZString ptr = StrPtr(exprInput)
  while scanP[0] <> CHAR_NUL
    dim sch as UByte = scanP[0]
    if IsTopLevelStatementSeparatorChar(sch, scanParen, scanBracket, scanBrace) then
      hasTopLevelSep = 1
      exit while
    end if
    UpdateNestingDepths(sch, scanParen, scanBracket, scanBrace)
    scanP += 1
  wend

  if hasTopLevelSep = 0 then return TRUE

  dim stmtStart as Integer = 1
  dim depthParen as Integer = 0
  dim depthBracket as Integer = 0
  dim depthBrace as Integer = 0
  dim hasPrevStmtResult as Boolean = FALSE
  dim iStmt as Integer
  for iStmt = 1 to len(exprInput) + 1
    dim ch as String
    dim chByte as UByte
    if iStmt <= len(exprInput) then
      ch = mid(exprInput, iStmt, 1)
      chByte = asc(ch)
    else
      ch = ";"
      chByte = CHAR_SEMICOLON
    end if
    dim isStmtSep as Integer = 0
    if iStmt > len(exprInput) then
      isStmtSep = 1
    elseif IsTopLevelStatementSeparatorChar(chByte, depthParen, depthBracket, depthBrace) then
      isStmtSep = 1
    end if

    if isStmtSep then
      dim rawStmtLen as Integer = iStmt - stmtStart
      dim rawStmt as String
      if rawStmtLen > 0 then
        rawStmt = mid(exprInput, stmtStart, rawStmtLen)
      else
        rawStmt = ""
      end if
      dim stmt as String = trim(rawStmt)
      if stmt = "" then
        ' Trailing ';' already flushed the last statement; artificial EOF has nothing left.
        if iStmt > len(exprInput) andalso stmtStart > len(exprInput) then
          exit for
        end if
        SetEmptyStatementError()
        return FALSE
      end if
      dim leadWs as Integer = 0
      while leadWs < len(rawStmt)
        dim wsCh as String = mid(rawStmt, leadWs + 1, 1)
        if wsCh = " " orelse wsCh = chr(9) then
          leadWs += 1
        else
          exit while
        end if
      wend
      dim savedBaseCol as Integer = errorBaseCol
      errorBaseCol = stmtStart + leadWs
      dim isSemicolon as Boolean = iStmt <= len(exprInput) andalso chByte = CHAR_SEMICOLON
      if isSemicolon andalso TrimmedStmtIsBareBuiltinOrUdfName(stmt) then
        dim allowFormatterSugar as Boolean = FALSE
        if hasPrevStmtResult then
          dim fmtRewritten as String
          if TryRewriteTrailingFormatterStmt(stmt, fmtRewritten) then allowFormatterSugar = TRUE
        end if
        if allowFormatterSugar = FALSE then
          parseError = 0
          SetParseErrorAtColumn(FB_STR_UNEXPECTED_TOKEN, iStmt)
          return FALSE
        end if
      end if
      dim stmtToEval as String = stmt
      if hasPrevStmtResult then
        dim rewrittenStmt as String
        if TryRewriteTrailingFormatterStmt(stmt, rewrittenStmt) then stmtToEval = rewrittenStmt
      end if
      dim stmtParse as String = stmtToEval
      dim stmtSuppress as Boolean = FALSE
      if isSemicolon andalso iStmt <= len(exprInput) then
        if IsStmtUdfDefinitionAt(stmtToEval) = FALSE then
          stmtParse &= ";"
        end if
        if TrimmedStmtIsBareBuiltinOrUdfName(stmt) = FALSE then
          stmtSuppress = TRUE
        end if
      end if
      if TryEvaluateStatementCore(stmtParse, result, resultText, isArray, stmtSuppress) = FALSE then
        errorBaseCol = savedBaseCol
        return FALSE
      end if
      hasPrevStmtResult = TRUE
      errorBaseCol = savedBaseCol
      stmtStart = iStmt + 1
    else
      UpdateNestingDepths(chByte, depthParen, depthBracket, depthBrace)
    end if
  next iStmt

  handled = TRUE
  return TRUE
end function

private function FinishParserEvaluateEx(byval ok as Boolean) as Boolean
  evalDepth -= 1
  return ok
end function

private function TryEvaluateStatementCore(byref exprInput as String, byref result as Double, byref resultText as String, byref isArray as Boolean, byval suppressTailHint as Boolean) as Boolean
  dim savedSuppressTailHint as Boolean = suppressBareFunctionTailHint
  suppressBareFunctionTailHint = suppressTailHint
  dim i as Integer, hasNonSpace as Integer = 0
  for i = 1 to Len(exprInput)
    dim c as Integer = Asc(Mid(exprInput, i, 1))
    if not (c = CHAR_SPACE orelse c = CHAR_TAB orelse c = CHAR_LF orelse c = CHAR_CR) then
      hasNonSpace = 1
      exit for
    end if
  next i
  if hasNonSpace = 0 then
    suppressBareFunctionTailHint = savedSuppressTailHint
    return FALSE
  end if

  pStream = StrPtr(exprInput)
  exprStart = pStream
  parseError = 0
  isArray = FALSE
  resultText = ""
  result = 0

  SkipSpaces()
  if IsIdentStartChar(asc(pStream[0])) then
    dim stmtStart as ZString ptr = pStream
    if PeekIdentFollowedByAssignEquals(stmtStart) then
      dim varName as String = ConsumeIdentTokenFromStream()
      SkipSpaces()
      if pStream[0] = CHAR_EQUALS andalso pStream[1] <> CHAR_EQUALS then
        pStream += 1
        dim afterEq as ZString ptr = pStream
        if Parser_SupportLambdaFunctions then
          dim lamP() as string
          dim lamB as string = ""
          if PeekRhsMayBeLambdaSyntaxAt(afterEq) andalso TryParseLambdaAssignmentRhs(lamP(), lamB) then
          dim lamUdfErr as string = ""
          if TryValidateUserFunctionDefinition(varName, lamP(), lamB, lamUdfErr) = FALSE then
            SetValidationError(lamUdfErr)
            suppressBareFunctionTailHint = savedSuppressTailHint
            return FALSE
          end if
          SetUserFunction(varName, lamP(), lamB)
          dim sigL as String = varName & "("
          if ubound(lamP) >= lbound(lamP) then
            dim lk as Integer
            for lk = lbound(lamP) to ubound(lamP)
              if lk > lbound(lamP) then sigL &= FB_STR_COMMA
              sigL &= lamP(lk)
            next lk
          end if
          sigL &= ")"
          resultText = FB_STR_DEFINED & sigL
          isArray = FALSE
          result = 0
          InvalidateLastRawResult()
          suppressBareFunctionTailHint = savedSuppressTailHint
          return TRUE
          end if
        elseif PeekRhsMayBeLambdaSyntaxAt(afterEq) then
          SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
          suppressBareFunctionTailHint = savedSuppressTailHint
          return FALSE
        end if
        pStream = afterEq
        dim exprV as EvalValue
        exprV = ParseExpression()
        if parseError then
          suppressBareFunctionTailHint = savedSuppressTailHint
          return FALSE
        end if
        SkipSpaces()
        ApplyUnknownNameErrors()
        if pStream[0] = CHAR_NUL orelse pStream[0] = CHAR_SEMICOLON then
          if pStream[0] = CHAR_SEMICOLON then pStream += 1
          SkipSpaces()
          if pStream[0] = CHAR_NUL andalso parseError = 0 then
            dim assignNameErr as String
            if TryValidateAssignmentTargetName(varName, assignNameErr) = FALSE then
              SetValidationError(assignNameErr)
              suppressBareFunctionTailHint = savedSuppressTailHint
              return FALSE
            end if
            RemoveUserFunctionByName(varName)
            SetVariable(varName, exprV)
            SetAnsValue(exprV)
            resultText = ValueToString(exprV)
            isArray = (exprV.kind = VK_ARRAY)
            if exprV.kind = VK_SCALAR then result = exprV.scalar
            CommitLastRawResult(exprV)
            suppressBareFunctionTailHint = savedSuppressTailHint
            return TRUE
          end if
        end if
        if parseError = 0 then SetParseErrorById(PARSE_ERR_UNEXPECTED_TOKEN)
        suppressBareFunctionTailHint = savedSuppressTailHint
        return FALSE
      end if
      pStream = stmtStart
    end if
    if PeekIdentFollowedByChar(stmtStart, CHAR_LPAREN) then
      dim varName as String = ConsumeIdentTokenFromStream()
      SkipSpaces()
      if pStream[0] = CHAR_LPAREN then
      dim savedPos as ZString ptr = pStream
      pStream += 1
      SkipSpaces()
      dim fnParams() as String
      dim parseParamsOk as Integer = 1

      if pStream[0] <> CHAR_RPAREN then
        do
          if not IsIdentStartChar(asc(pStream[0])) then
            parseParamsOk = 0
            exit do
          end if
          dim parName as String = ConsumeIdentTokenFromStream()
          if ubound(fnParams) = -1 then
            redim fnParams(0)
          else
            redim preserve fnParams(ubound(fnParams) + 1)
          end if
          fnParams(ubound(fnParams)) = parName
          SkipSpaces()
          if pStream[0] = CHAR_COMMA then
            pStream += 1
            SkipSpaces()
          else
            exit do
          end if
        loop
      end if

      if parseParamsOk andalso pStream[0] = CHAR_RPAREN then
        pStream += 1
        SkipSpaces()
        if pStream[0] = CHAR_EQUALS andalso pStream[1] <> CHAR_EQUALS then
          pStream += 1
          SkipSpaces()
          dim udfValidationErr as String
          dim body as String = *pStream
          if TryValidateUserFunctionDefinition(varName, fnParams(), body, udfValidationErr) = FALSE then
            SetValidationError(udfValidationErr)
            suppressBareFunctionTailHint = savedSuppressTailHint
            return FALSE
          end if
          SetUserFunction(varName, fnParams(), body)
          dim sig as String = varName & "("
          if ubound(fnParams) >= lbound(fnParams) then
            dim k as Integer
            for k = lbound(fnParams) to ubound(fnParams)
              if k > lbound(fnParams) then sig &= FB_STR_COMMA
              sig &= fnParams(k)
            next k
          end if
          sig &= ")"
          resultText = FB_STR_DEFINED & sig
          isArray = FALSE
          result = 0
          InvalidateLastRawResult()
          suppressBareFunctionTailHint = savedSuppressTailHint
          return TRUE
        end if
      end if
      pStream = savedPos
      end if
    end if
  end if

  pStream = StrPtr(exprInput)
  exprStart = pStream
  parseError = 0
  dim outV as EvalValue
  outV = ParseExpression()
  if parseError then
    suppressBareFunctionTailHint = savedSuppressTailHint
    return FALSE
  end if
  SkipSpaces()
  if pStream[0] = CHAR_SEMICOLON then
    pStream += 1
    SkipSpaces()
  end if

  ApplyUnknownNameErrors()

  if pStream[0] <> CHAR_NUL andalso parseError = 0 then
    if pStream[0] = CHAR_COMMA then
      SetParseErrorById(PARSE_ERR_UNEXPECTED_COMMA)
    elseif pStream[0] = CHAR_RPAREN then
      SetParseErrorById(PARSE_ERR_MISMATCHED_CLOSING_PARENTHESIS)
    else
      SetMismatchedBracketBraceOrUnexpectedToken(asc(pStream[0]))
    end if
  end if
  if parseError = 1 then
    suppressBareFunctionTailHint = savedSuppressTailHint
    return FALSE
  end if
  resultText = ValueToString(outV)
  isArray = (outV.kind = VK_ARRAY)
  if outV.kind = VK_SCALAR then result = outV.scalar
  SetAnsValue(outV)
  CommitLastRawResult(outV)
  suppressBareFunctionTailHint = savedSuppressTailHint
  return TRUE
end function

function Parser_TryEvaluateEx(byref sExpr as String, byref result as Double, byref resultText as String, byref isArray as Boolean) as Boolean
  dim exprAfterLineComment as String = StripLineComment(sExpr)
  dim exprInput as String = exprAfterLineComment
  const PARSER_MAX_EXPR_LEN as Integer = 32760
  evalDepth += 1
  if evalDepth = 1 then
    ResetTopLevelEvaluationState(exprAfterLineComment)
  end if
  dim stripSuppressTailHint as Boolean = FALSE
  NormalizeTrailingStatementSemicolons(exprInput, stripSuppressTailHint)
  if Len(exprInput) = 0 then
    if Len(exprAfterLineComment) > 0 then
      SetEmptyStatementError()
    end if
    return FinishParserEvaluateEx(FALSE)
  end if
  if Len(exprInput) > PARSER_MAX_EXPR_LEN then
    SetExpressionTooLongError()
    return FinishParserEvaluateEx(FALSE)
  end if

  dim handledTopLevel as Boolean = FALSE
  if TryEvaluateTopLevelStatements(exprInput, result, resultText, isArray, handledTopLevel) = FALSE then
    return FinishParserEvaluateEx(FALSE)
  end if
  if handledTopLevel then
    return FinishParserEvaluateEx(TRUE)
  end if

  if TryEvaluateStatementCore(exprInput, result, resultText, isArray, stripSuppressTailHint) = FALSE then
    return FinishParserEvaluateEx(FALSE)
  end if
  return FinishParserEvaluateEx(TRUE)
end function

function Parser_GetLastRawResult(byref rawOut as RawResult) as Boolean
  if lastRawResultValid = FALSE then
    RawResultClear(rawOut)
    return FALSE
  end if
  rawOut = lastRawResult
  return TRUE
end function

function Parser_FormatTimeMs(byval totalMs as LongInt) as String
  return FormatTimeCanonicalFromMs(totalMs)
end function

function Parser_GetLastError() as String
  if lastErrorText <> "" then return lastErrorText
  return ""
end function

function Parser_IsFunctionHintError(byref sErr as String) as Boolean
  if Left(sErr, Len(FB_STR_HINT_PREFIX)) = FB_STR_HINT_PREFIX then return TRUE
  if Left(sErr, Len(FB_STR_USER_DEFINED_FUNCTION_COLON)) = FB_STR_USER_DEFINED_FUNCTION_COLON then return TRUE
  return FALSE
end function

sub Parser_SetShowErrorLine(byval showLine as Boolean)
  Parser_ShowErrorLine = showLine
end sub

function Parser_GetShowErrorLine() as Boolean
  return Parser_ShowErrorLine
end function

sub Parser_SetSupportComplexNumbers(byval enabled as Boolean)
  dim prev as Boolean = Parser_SupportComplexNumbers
  Parser_SupportComplexNumbers = enabled
  if enabled andalso prev = FALSE then
    dim iu as EvalValue
    ValueSetImagUnit(iu)
    SetVariable(FB_STR_I, iu)
  elseif (enabled = FALSE) andalso prev then
    dim vIdx as Integer = FindVariableIndex(FB_STR_I)
    if vIdx >= 0 then RemoveVariableAtIndex(vIdx)
  end if
end sub

function Parser_GetSupportComplexNumbers() as Boolean
  return Parser_SupportComplexNumbers
end function

sub Parser_SetSupportTimeValues(byval enabled as Boolean)
  Parser_SupportTimeValues = enabled
end sub

function Parser_GetSupportTimeValues() as Boolean
  return Parser_SupportTimeValues
end function

sub Parser_SetSupportLambdaFunctions(byval enabled as Boolean)
  Parser_SupportLambdaFunctions = enabled
end sub

function Parser_GetSupportLambdaFunctions() as Boolean
  return Parser_SupportLambdaFunctions
end function