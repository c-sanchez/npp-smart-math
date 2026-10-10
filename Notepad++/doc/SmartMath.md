# SmartMath Usage and Syntax

## What Is SmartMath?

SmartMath evaluates math expressions inside Notepad++.

- You type an expression in a line.
- SmartMath shows the result in the right margin.
- The result is not inserted into the file text.
- Double-click the result to copy a clean value/error string.

### Mini Glossary

- `scalar`: a single value - either a **plain number** (`42`, `3.5`) or a **duration** written like `1:30` (see **Time values**).
- `array`: a list of numbers in parentheses, for example `(1,2,3)`.
- `expression`: any calculable input, for example `2+3` or `sin(pi/2)`.
- `statement`: one top-level unit. Multiple statements can be separated with `;`.

## Quick Start

### Activate the Smart Math Plugin

To enable calculations in your current document, check "Smart Math" under the Smart Math menu.
SmartMath remembers which documents (tabs) have "Smart Math" checked.

### Copying Math Results to the Clipboard

Double-click the math result to copy it to the Clipboard.

### Copy/Paste Examples:

- `2+3*4` -> `14`
- `a=10; a*3` -> `30`
- `(1,2,3)+10` -> `(11, 12, 13)`
- `sum(1,2,3,10)` -> `16`
- `sort(3,1,2)` -> `(1, 2, 3)`
- `sortby((-3,-1,2), abs)` -> `(-1, 2, -3)`
- `ratio(0.5)` -> `1/2`
- `hex(255)` -> `0xFF`
- `uhex(-1)` -> `0xFFFFFFFFFFFFFFFF`
- `2+3; ans/10` -> `0.5`
- `f(x)=x*x+1; f(5)` -> `26`
- `clamp((1,9),0,7)` -> `(1, 7)`
- `1:30 + 2:45` -> `04:15`
- `seconds(2:00)` -> `120`

## Common Tasks

### Numeric Values

Decimal/scientific forms:

- `42`
- `3.1415`
- `1e6` -> `1000000`
- `2.5e-3` -> `0.0025`

Base-prefixed integer forms:

- `0x7FF` - hexadecimal
- `0b01110110011` - binary
- `0o64` - octal

### Percent Calculation

- Use postfix percent for percentage math:
  - `200 + 15%` -> `230`
  - `200 - 15%` -> `170`

### Time Values

A **duration** (time value) is kept in whole milliseconds. Results print with colons (`MM:SS`, `HH:MM:SS`, or `DD:HH:MM:SS` as needed) and milliseconds on the last field only when the fractional part is nonzero.

**Colon literals** - 2, 3, or 4 groups separated by `:`; digits only in each group; optional milliseconds only on the **last** group (`1:30.5` -> `01:30.500`). The count of groups fixes the meaning: **`MM:SS`**, **`HH:MM:SS`**, **`DD:HH:MM:SS`** (coarse to fine). So `1:30` is one minute thirty seconds, not ninety minutes; ninety minutes is `1:30:00` or a suffix form below. An empty group is an error (`1::0` -> `time literal: empty segment between colons`).

**Suffix literals** - non-negative integers with unit letters `d`, `h`, `m`, `s`, or `ms` (type `ms` so it is not read as `m` then `s`). Chain or space fields: `1d2h3m4s5ms` equals `1d 2h 3m 4s 5ms` (the same as `1:02:03:04.005`). Each unit at most once, in order **d**, **h**, **m**, **s**, **ms** (repeats or wrong order are errors). Values add and normalize like colon literals (`5000ms` -> `00:05`, `2h90m` -> `03:30:00`, `23h3600s` -> `1:00:00:00`). Fractions are not written inside suffix counts; use a factor (`1.5*day`, `1.5*1ms` etc.).

**Same span, either form**

| Colon | Suffix (examples) |
|-------|-------------------|
| `0:60` | `1m`, `60s` |
| `1:30:00` | `90m`, `1h30m` |
| `1:00:00:00` | `1d`, `24h` |
| `1:02:03:04.005` | `1d2h3m4s5ms` |

- `1:30 + 2:45` -> `04:15`
- `1:30.5` -> `01:30.500`
- `1:00 == 0:60` -> `1`
- `2*minute - 5*second` -> `01:55` (the same as `2m - 5s`)
- `1.5*minute - 0.5*second` -> `01:29.500` (the same as `1.5*1m - 0.5*1s`)
- `1d3m + 2h5ms + 4s` (with `+`) matches the span `1:02:03:04.005`

**Unit constants** (reserved like `pi`; cannot assign):
- `millisecond` (`00:00.001`, `1ms`)
- `second` (`00:01`, `1s`)
- `minute` (`01:00`, `1m`)
- `hour` (`01:00:00`, `1h`)
- `day` (`1:00:00:00`, `1d`)

**Plain number beside a duration**:
- with `+`, `-`, or comparisons the number is **seconds** (`second + 5` -> `00:06`, `1:00 + 5` -> `01:05`, `0:30 > 20` -> `1`).
- with `*` or `/` the number is **unitless** (`0:25 * 6` -> `02:30`, `1:30 / 0:30` -> `3`).

**Operators**:
- two durations: `+`, `-` -> duration; `/` -> numeric ratio.
- duration `*` duration is not allowed (`1:00*1:00`); use a plain factor (`0:25 * 6`).
- duration `*` plain or plain `*` duration -> scaled duration.
- plain `/` duration is not allowed.
- unary `-` flips sign (`-0:30`, `-1m 5s` is `-(1m5s)`).

**Converters** (see **Time Conversion** under [Function Reference](#function-reference); argument must be a duration):
- `seconds(2:00)` -> `120`, `seconds(2m)` -> `120`
- `milliseconds(minute + 30*second)` -> `90000`
- `seconds((0:30,1:00))` -> `(30, 60)` (here `1:00` is `MM:SS`).

**Rounding** - fractional seconds in a colon literal round to the nearest millisecond. `milliseconds` returns integers (or an int array); `seconds`, `minutes`, `hours` and `days` return floats (or same-shape arrays).

**Arrays** - do not mix durations and plain numbers in one literal:
- `(0:30, 1:00)` and `(30s, 1m)` are fine;
- `sum(0:30,1:00)` -> `01:30`;
- `(1:45, 2)` -> `time values cannot be mixed with non-time values`.

**Not allowed with durations** (typical errors: `incompatible operands`, or text with `expects a time value`):
- postfix `%`;
- `sin`, `hex`, `pow`, and similar on a duration;
- `1:00*1:00` (a duration multiplied by a duration);
- `1/1:00` (a number divided by a duration);
- `product` with a duration;
- `milliseconds(5)` (converter needs a duration; in case of an array, each array element must be a duration too).

### Complex Numbers

Complex numbers are not supported by default.
Be sure to call `Parser_SetSupportComplexNumbers` to enable them (refer to "Parser runtime flags").

Complex numbers can be specified in the following forms:
- `10+5i`
- `10+5*i`

Use parentheses for operations with complex numbers:
- `(1+2i)*(3+4i)` -> `-5+10i`
- `(1+2i)/2` -> `0.5+i`

Notes:
- `1/2i` means `1/(2i)`, unlike `(1/2)i` and `1/2*i`;
- `2**7i` means `2**(7i)`, unlike `(2**7)i` and `2**7*i`;
- `(1+2)i` means `((1+2)i)`;
- `func(1+2)i` means `(func(1+2)i)`.

### Arrays

- Make arrays with commas in parentheses:
  - `(1,2,3)`
- A single value in parentheses without commas is not an array; it’s just grouping:
  - `(5)` behaves like scalar `5`
  - `((5))` also behaves like scalar `5` (still just grouping)
- Use element-wise math:
  - `(1,2,3)*10` -> `(10, 20, 30)`
  - `6/(10,20,30)` -> `(0.6, 0.3, 0.2)`
  - `(1,2,3)+(10,20,30)` -> `(11, 22, 33)`
  - `2**(3,5,6)` -> `(8, 32, 64)`
- Index arrays with `[index]`:
  - `(10,20,30)[0]` -> `10` (first element)
  - `(10,20,30)[-1]` -> `30` (last element)
- Slice arrays with Python-style `[start:stop:step]` (half-open; empty slice returns `()`):
  - `(1,2,3,4,5,6,7,8,9)[2:7]` -> `(3, 4, 5, 6, 7)`
  - `(1,2,3,4,5,6,7,8,9)[3:-3]` -> `(4, 5, 6)`
  - `(1,2,3,4,5,6,7,8,9)[:3]` -> `(1, 2, 3)` (omitted start)
  - `(1,2,3,4,5,6,7,8,9)[3:]` -> `(4, 5, 6, 7, 8, 9)` (omitted stop)
  - `(1,2,3,4,5,6,7,8,9)[::2]` -> `(1, 3, 5, 7, 9)`
  - `(1,2,3,4,5,6,7,8,9)[::-1]` -> `(9, 8, 7, 6, 5, 4, 3, 2, 1)`
  - `(1,2,3,4,5,6,7,8,9)[1:1]` -> `()` (empty)
  - Bounds and step must be integers; step must not be `0`
  - Inside `[...]`, `:` is slice syntax (not a time literal): `a[1:30]` slices from index 1 to 30
- Pass array to functions:
  - `sqrt((9,25,36))` -> `(3, 5, 6)`
  - `pow((3,2), 4)` -> `(81, 16)`
  - `sin((pi/4,pi/2))` -> `(0.707107, 1)`
- Use array utilities:
  - `reverse((1,2,3),(4,5))` -> `(5, 4, 3, 2, 1)`

### Variables and `ans`

- Assign with `=`:
  - `a = 10`
- Reserved names cannot be assignment targets:
  - function names (for example `hex`, `random`, `sin`)
  - built-in constants (`pi`, `e`, `inf`, `nan`, and time units `second`, `minute`, `hour`, `day`)
- Reuse values:
  - `a*3` -> `30`
- `ans` is the last successful result:
  - `2+3; ans*10` -> `50`
- Assign and use arrays:
  - `v = (2,1,3)`
  - `v/3` -> `(0.666667, 0.333333, 1)`
  - `sum(v)` -> `6`
  - `sort(v)` -> `(1, 2, 3)`
  - `(v[-1],v[-2])` -> `(3, 1)`
  - `v=(1,2,3); exp(v)` -> `(2.718282, 7.389056, 20.085537)`

### Formatting Output

- Decimal is default.
- Use helper functions for base formatting:
  - `hex(12)` -> `0xC`
  - `oct(12)` -> `0o14`
  - `bin(5,7)` -> `(0b101, 0b111)`
  - `uhex(-1)` -> `0xFFFFFFFFFFFFFFFF`
- Trailing formatter sugar after `;` is supported:
  - `0xAA; hex` -> `0xAA` (same as `0xAA; hex(ans)`)
  - `(8,9,10); oct` -> `(0o10, 0o11, 0o12)` (same as `(8,9,10); oct(ans)`)

### User-Defined Functions

- Define:
  - `f(x)=x*x+1`
- Call:
  - `f(5)` -> `26`
  - `f((10,20))` -> `(101, 401)`
- Multiple args:
  - `mix(a,b)=a*2+b*3; mix(2,4)` -> `16`
  - `f(a,b,c)=a+b*c; f(2,3,4)` -> `14`
  - `f(a,b,c)=a+b*c; v=(2,3,4); f(unpack(v))` -> `14`
- Array result:
  - `d(x)=(ratio(x), x-ratio(x))`
  - `d(seconds(20ms))` -> `(1/50, 0)`
  - `f(x)=x*(2,3,4); f(10)` -> `(20, 30, 40)`
  - `rev(x,y)=(y,x); rev(10,20)` -> `(20, 10)`
  - `f(a)=(a[0],a[-1]); f((1,2,3,4))` -> `(1, 4)`
- Define lambda-style:
  - `f=x:x*x+1` (same arity and body rules as `f(x)=...`; spaces optional)
  - Wrapped form: `f=(x:1/x)`, `f=(x):1/x`, or nested `f=((x):(1/x))`
  - Zero parameters: `f=():42` then call `f()`
- Reserved names cannot be used for function names:
  - `hex(x)=x` -> error (`reserved function name`)
  - `e(x)=x` -> error (`reserved constant name`)
  - `ans(x)=x` or `_(x)=x` -> error (`reserved built-in variable name`) - these names are reserved for the last-result variable `ans` and the formal-validation probe variable `_` (see below)
  - `nan=1` -> error (`reserved constant name`)
- Recursive functions are not supported.

#### Late Binding of Referenced Functions

- User-defined functions use late binding (runtime name resolution) for referenced function names.
- If a dependency is missing at call time, evaluation fails with an unknown-function error.
- If that dependency is defined later, the original function starts working without redefinition.
- Example:
  - `f(x)=x*g(x)`
  - `f(2)` -> `unknown function: g`
  - `g(x)=x+5; f(10)` -> `150`
  - `g(x)=x**(1/3); f(8)` -> `16`

#### User-Defined Functions Validation

When you define a function, the body is evaluated once with **dummy** arguments so obvious errors are caught early. Every parameter is replaced by the scalar variable **`_`** with the default value of **`1`**. Real calls still use the arguments you pass.

With the default **`_` = `1`**, validation can fail even when the function would work for other inputs:

- `f(x)=(x/2)<<2` -> error `bitwise operands must be integer values` (dummy gives `(1/2)<<2`, a float on the left of `<<`).
- `f(x,y)=x%(y-1)` -> error `incompatible operands` (dummy gives `1%0`).

Set **`_`** before the definition so the check uses a better dummy, e.g. **`_=2`**:

- `_=2; f(x)=(x/2)<<2` -> OK (`(2/2)<<2`).
- `_=2; f(x,y)=x%(y-1)` -> OK (`2%(2-1)`).

For a body that calls time converters on a parameter (for example `rd(t)=ratio(days(t))`), set **`_`** to a duration before the definition so validation sees a duration dummy:

- `_=0:00; rd(t)=ratio(days(t)); rd(1h)` -> `1/24`.

### Comments

- Line comments are supported with `#` or `//`.
- Everything after the comment marker is ignored.
- Useful for keeping notes next to expressions.

Examples:
- `2+3 # comment` -> `5`
- `hex(255) // display as hex` -> `0xFF`

## Core Language Rules

### Operators

- Exponent: `**`
- Unary: `+x`, `-x`, `~x`, `!x`, `not x`
- Multiplicative: `*`, `/`, `%` (modulo)
- Additive: `+`, `-`
- Shifts: `<<`, `>>`
- Bitwise: `&`, `^`, `|`
- Comparisons: `=`, `==`, `<>`, `!=`, `>`, `>=`, `<`, `<=`
- Logical: `&&`/`and`, `||`/`or`
- Postfix percent: `x%`

#### Time Value Operators

- Unary `+t`, `-t`, `!t`, `not t` (not applicable: `~t`)
- Multiplicative: `n*t`, `t/n`, `t/t` (not applicable: `t*t`, `n/t`, modulo)
- Additive: `t+n`, `t+t`, `t-n`, `t-t`
- Comparisons: `=`, `==`, `<>`, `!=`, `>`, `>=`, `<`, `<=`
- Logical: `t&&t`, `t||t`

**Not** applicable:
- Exponent
- Bitwise operations
- Postfix percent

#### Complex Number Operators

- Exponent: `c**n`, `n**c`, `c**c`
- Unary `+c`, `-c`, `!c`, `not c` (not applicable: `~c`)
- Multiplicative: `n*c`, `c*c` `c/n`, `n/c`, `c/c` (not applicable: modulo)
- Additive: `c+n`, `c+c`, `c-n`, `c-c`
- Equality: `c==c`, `c<>c` (not applicable: `>`, `>=`, `<`, `<=`)
- Logical: `c&&c`, `c||c`

**Not** applicable:
- Bitwise operations
- Postfix percent

### Precedence (High -> Low)

1. `**` (power)
2. unary `+`, `-`, `~`, `!`
3. postfix `%` (percentage form `x%`)
4. `*`, `/`, `%` (modulo `x % y`)
5. `+`, `-`
6. `<<`, `>>` (bitwise shift)
7. `&` (bitwise and)
8. `^` (bitwise xor)
9. `|` (bitwise or)
10. `=`, `==`, `<>`, `!=`, `>`, `>=`, `<`, `<=`
11. `not` (logical not)
12. `&&`, `and` (logical and)
13. `||`, `or` (logical or)

Use parentheses to make intent explicit.

### Mini Guide: `=` vs `==`

- `x = ...` at statement start is assignment.
- `==` is always comparison.
- Single `=` can still be comparison when not in assignment form.

Examples:

- `a=10` -> assignment
- `a==10` -> comparison
- `5=5` -> comparison (`1`)
- `(x)=(x)` -> comparison
- `x+y=x` -> comparison

Recommendation: use `==` for equality checks to avoid confusion.

### Mini Guide: `%` Means Two Different Things

- Binary modulo:
  - `17%5` -> `2`
- Postfix percent:
  - `200+15%` -> `230`
- Percentage math and precedence:
  - `5 + 2*3%` means `5 + (2*3%)` -> `5 + 0.06` -> `5.06`.
  - `5 + (2*3)%` means `5 + 6%` -> `5 + (5*0.06)` -> `5.3`.
- Tricky examples:
  - `5 % -20` means `(5%) - 20` -> `0.05 - 20` -> `-19.5`.
  - `-20 + 5%` means `-20 + (-20*0.05)` -> `-21`.
  - `5 % (-20)` means `mod(5, -20)` -> `5`.

### Mini Guide: `!` vs `not`

- `!` has high precedence.
- `not` has lower precedence.
- They are not interchangeable in mixed expressions.

Logical note (scalar vs array):
- `!x` / `not x` are logical NOT and always return a scalar (`1` or `0`).
- Non-empty arrays are always treated as truthy in logical operators, so `!(0,0)`, as well as `not (0,0)`, evaluates to `0`.
- Precedence contrast (only in mixed expressions):
  - `!2==1` -> `0`
  - `not 2==1` -> `1`
- These happen because of precedence:
  - `!2==1` parses like `(!2)==1` -> `0`
  - `not 2==1` parses like `not (2==1)` -> `1`

Recommendation: parenthesize when using `not` in complex expressions.

### Arrays in Logical and Bitwise Operators (With Arrays)

- `x && y` and `x || y` are logical and return a scalar (`1` or `0`). If an operand is a non-empty array, that operand is considered truthy.
  - `(0,0) && 1` -> `1`
  - `0 || (0,0)` -> `1`
- `x & y`, `x ^ y`, and `x | y` are bitwise and work element-wise:
  - If an operand is an array, the result is an array.
  - If both operands are arrays and their shapes/lengths are incompatible, you may get `incompatible operands`.
  - Bitwise operators require integer inputs (use `int(...)` to convert floats).
  - Example: `(1,2,3) & 1` -> `(1, 0, 1)`
  - Example: `(1,2,3) | 1` -> `(1, 3, 3)`

### Arrays and Comparisons

- Arrays are compared item by item, until the first mismatch or until the end of an array.
  - Example: `(10,20) > 20` -> `0` because the first item `10` < `20`.
  - Example: `(1,2,3) < (1,3)` -> `1` because the second item `2` < `3`.
  - Example: `(1,2,0) >= (1,2)` -> `1` because the values are equal until the end of the 2nd array.
  - Example: `(1,2) == sort(2,1)` -> `1` because the arrays are equal after sorting.

### Chained Comparisons Warning

- Chained comparisons are evaluated left-to-right.
- `2<3<4` is interpreted as `(2<3)<4`.
- That means `2<3` becomes `1`, then `1<4` is evaluated.

This differs from Python-style chained comparison logic.

## Function Reference

Quick index (alphabetical):

| Function(s) | Category |
|---|---|
| `abs(value)` | [Numeric Utilities](#numeric-utilities) |
| `acos/arccos(value)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `acosh(value)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `asin/arcsin(value)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `asinh(value)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `atan/arctan(value)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `atan2(y, x)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `atanh(value)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `avg/mean(...)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `bin(...)` | [Output Formatting](#output-formatting) |
| `cart(value)` | [Complex Utilities](#complex-utilities) |
| `ceil(value)` | [Numeric Utilities](#numeric-utilities) |
| `clamp(value, min, max)` | [Numeric Utilities](#numeric-utilities) |
| `conj(value)` | [Complex Utilities](#complex-utilities) |
| `cos(angle)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `cosh(value)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `days(t)` | [Time Conversion](#time-conversion) |
| `deg(...)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `exp(value)` | [Logarithmic and Exponential](#logarithmic-and-exponential) |
| `fact/factorial(n)` | [Numeric Utilities](#numeric-utilities) |
| `factorint(n)` | [Numeric Utilities](#numeric-utilities) |
| `flat(...)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `floor(value)` | [Numeric Utilities](#numeric-utilities) |
| `frac/fract(value)` | [Numeric Utilities](#numeric-utilities) |
| `gcd(a, b)` | [Numeric Utilities](#numeric-utilities) |
| `hex(...)` | [Output Formatting](#output-formatting) |
| `hours(t)` | [Time Conversion](#time-conversion) |
| `hypot(x, y)` | [Power and Root](#power-and-root) |
| `imag(value)` | [Complex Utilities](#complex-utilities) |
| `int(value)` | [Numeric Utilities](#numeric-utilities) |
| `lcm(a, b)` | [Numeric Utilities](#numeric-utilities) |
| `len/length(x)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `ln(value)` | [Logarithmic and Exponential](#logarithmic-and-exponential) |
| `log(value, base)` | [Logarithmic and Exponential](#logarithmic-and-exponential) |
| `log10(value)` | [Logarithmic and Exponential](#logarithmic-and-exponential) |
| `max(...)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `median(...)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `milliseconds(t)` | [Time Conversion](#time-conversion) |
| `min(...)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `minutes(t)` | [Time Conversion](#time-conversion) |
| `mod(value, divisor)` | [Numeric Utilities](#numeric-utilities) |
| `ncr(n, r)` | [Numeric Utilities](#numeric-utilities) |
| `npr(n, r)` | [Numeric Utilities](#numeric-utilities) |
| `oct(...)` | [Output Formatting](#output-formatting) |
| `phase(value)` | [Complex Utilities](#complex-utilities) |
| `polar(value)` | [Complex Utilities](#complex-utilities) |
| `pow(value, power)` | [Power and Root](#power-and-root) |
| `product/prod(...)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `rad(...)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `rand()` | [Random](#random) |
| `random(min, max)` | [Random](#random) |
| `range(start, stop [, step])` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `ratio(value)` | [Rational Display](#rational-display) |
| `real(value)` | [Complex Utilities](#complex-utilities) |
| `repeat(x, n)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `reverse/reversed(...)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `round(value)` | [Numeric Utilities](#numeric-utilities) |
| `seconds(t)` | [Time Conversion](#time-conversion) |
| `sign(value)` | [Numeric Utilities](#numeric-utilities) |
| `sin(angle)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `sinh(value)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `sort/sorted(...)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `sortby(array, func)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `sqrt(value)` | [Power and Root](#power-and-root) |
| `sqr(value)` | [Power and Root](#power-and-root) |
| `stddev(...)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `sum(...)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `tan(angle)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `tanh(value)` | [Trigonometric and Hyperbolic](#trigonometric-and-hyperbolic) |
| `trunc(value)` | [Numeric Utilities](#numeric-utilities) |
| `ubin(...)` | [Output Formatting](#output-formatting) |
| `uhex(...)` | [Output Formatting](#output-formatting) |
| `unique(...)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `unpack(...)` | [Arrays and Aggregation](#arrays-and-aggregation) |
| `uoct(...)` | [Output Formatting](#output-formatting) |
| `variance(...)` | [Arrays and Aggregation](#arrays-and-aggregation) |

### Trigonometric and Hyperbolic

Purpose: angle and trig math.

- Key functions:
- `sin(angle)` - sine of an angle (radians)
- `cos(angle)` - cosine of an angle (radians)
- `tan(angle)` - tangent of an angle (radians)
- `asin(value)`, `arcsin(value)` - inverse sine
- `acos(value)`, `arccos(value)` - inverse cosine
- `atan(value)`, `arctan(value)` - inverse tangent
- `atan2(y, x)` - angle of vector `(x,y)` in radians
- `sinh(value)` - hyperbolic sine: `(exp(x) - exp(-x))/2`
- `cosh(value)` - hyperbolic cosine: `(exp(x) + exp(-x))/2`
- `tanh(value)` - hyperbolic tangent: `sinh(x)/cosh(x)`
- `asinh(value)` - inverse hyperbolic sine
- `acosh(value)` - inverse hyperbolic cosine
- `atanh(value)` - inverse hyperbolic tangent
- `deg(...)` - convert radians to degrees
- `rad(...)` - convert degrees to radians
- Examples:
  - `sin(pi/2)` -> `1`
  - `atan2(1,1)` -> `0.7853981633974483`
  - `deg(pi)` -> `180`
  - `rad(180)` -> `pi`
  - `cos(rad(30,45,60))` -> `(0.866025, 0.707107, 0.5)`
  - `acos((sqrt(3)/2, sqrt(2)/2, 1/2)); deg` -> `(30, 45, 60)`

#### Trigonometric and Hyperbolic With Complex Numbers

With complex numbers, the meaning of functions is different:
- `sin(a + b*i)`: `sin(a)*cosh(b) + i*cos(a)*sinh(b)`
- `cos(a + b*i)`: `cos(a)*cosh(b) - i*sin(a)*sinh(b)`
- `tan(a + b*i)`: `(sin(2*a) + i*sinh(2*b))/(cos(2*a) + cosh(2*b))`
- `sinh(a + b*i)`: `sinh(a)*cos(b) + i*cosh(a)*sin(b)`
- `cosh(a + b*i)`: `cosh(a)*cos(b) + i*sinh(a)*sin(b)`
- `tanh(a + b*i)`: `(sinh(2*a) + i*sin(2*b))/(cosh(2*a) + cos(2*b))`

### Logarithmic and Exponential

Purpose: growth/scale and logarithm operations.

- Key functions:
- `exp(value)` - Euler exponential (`e**x`)
- `ln(value)` - natural logarithm
- `log(value, base)` - logarithm in a chosen base
- `log10(value)` - base-10 logarithm
- Examples:
  - `ln(exp(3))` -> `3`
  - `log(8,2)` -> `3`
  - `log10(1000)` -> `3`

#### Logarithmic and Exponential With Complex Numbers

With complex numbers, the meaning of functions is different:
- `exp(a + b*i)`: `exp(a)*(cos(b) + i*sin(b))`
- `ln(c)`: `ln(abs(c)) + i*phase(c)`
- `log(c, base)`: `ln(c)/ln(base)`

### Power and Root

Purpose: power (`**`) and root operations.

- Key functions:
- `pow(value, power)` - raise value to a power (same as `value ** power`)
- `sqrt(value)` - square root (same as `value ** (1/2)`)
- `sqr(value)` - square: `value * value`
- `hypot(x, y)` - hypotenuse: `sqrt(x*x + y*y)`
- Examples:
  - `pow(27,1/3)` -> `3`
  - `2**63` -> `9223372036854775808`
  - `sqrt(25)` -> `5`
  - `hypot(3,4)` -> `5`

#### Power and Root With Complex Numbers

With complex numbers, the meaning of functions is different:
- `pow(c, p)`: `exp(p*ln(c))`
- `sqrt(c)`: `sqrt(abs(c))*exp(i*phase(c)/2)`
- `sqr(a + b*i)`: `(a + b*i)*(a + b*i) = a*a - b*b + 2*a*b*i`

### Numeric Utilities

Purpose: rounding, bounds, integer helpers, factorial.

- Key functions:
- `floor(value)` - largest integer less than or equal to value
- `ceil(value)` - smallest integer greater than or equal to value
- `trunc(value)` - drop fractional part toward zero
- `int(value)` - integer part toward zero (same as `trunc`)
- `frac(value)`, `fract(value)` - fractional part (`value - int(value)`)
- `round(value)` - nearest integer
- `abs(value)` - absolute value
- `sign(value)` - sign as `-1`, `0`, or `1`
- `clamp(value, min, max)` - limit value to `[min, max]`
- `gcd(a, b)` - greatest common divisor
- `lcm(a, b)` - least common multiple
- `mod(value, divisor)` - modulo as a function form of `value % divisor`
- `ncr(n, r)` - combinations (`n` choose `r`)
- `npr(n, r)` - permutations (`n` permute `r`)
- `fact(n)`, `factorial(n)` - factorial for non-negative integers
- `factorint(n)` - prime factorization of integer `n` as an array
- Examples:
  - `round(2.5)` -> `3`
  - `clamp(15,0,10)` -> `10`
  - `gcd(84,30)` -> `6`
  - `ncr(5,2)` -> `10`
  - `npr(5,2)` -> `20`
  - `fact(21)` -> `5.109094217170944e+019`
  - `factorint(40)` -> `(2**3, 5)`
  - `factorint(-3333)` -> `(-3, 11, 101)`

#### Numeric Utilities With Complex Numbers

With complex numbers, the meaning of some utilities is different:
- `abs(c)` - absolute value (magnitude): `sqrt(sqr(real)+sqr(imag))`
- `sign(c)` - complex sign (signum function): `c/abs(c)`
- `fact(c)` - factorial to the complex plane using the Gamma Function
- Examples:
  - `abs(1+2i)` -> `2.236068`
  - `sqrt(sqr(1)+sqr(2))` -> `2.236068`
  - `sign(1+2i)` -> `0.447214+0.894427i`
  - `(1+2i)/abs(1+2i)` -> `0.447214+0.894427i`
  - `fact(1+2i)` -> `0.112294+0.323613i`

### Rational Display

Purpose: show a plain numeric value as a reduced fraction when it is (or is close to) rational.

- Key functions:
- `ratio(x)` - reduced `n/m` with `m > 0` and sign in `n`
- Examples:
  - `ratio(-0.5)` -> `-1/2`
  - `ratio(1/3)` and `ratio(0.3333333333333333)` -> `1/3`
  - `ratio(15m/1h)` -> `1/4`
  - `ratio(hours(1:00))` -> `1/60` (argument of `ratio` must be a plain number, not a duration)
  - `ratio(0.5+0.25i)` -> `1/2+1/4*i`
- Notes:
  - `nan` / `inf` pass through;
  - duration arguments are rejected (`ratio(1:00)` -> `incompatible operands`);
  - non-exact values use the best reduced fraction `n/m` with `m <= 10_000_000` (for example `ratio(sqrt(2))` -> `13250218/9369319`);
  - exact decimal powers of ten may use a larger denominator (for example `ratio(7.73e-8)` -> `773/10000000000`).

### Arrays and Aggregation

Purpose: aggregate and transform values/lists.

- Key functions:
- `sum(...)` - sum all inputs
- `product(...)`, `prod(...)` - multiply all inputs
- `avg(...)`, `mean(...)` - average of all inputs
- `median(...)` - median of flattened inputs
- `variance(...)` - population variance
- `stddev(...)` - population standard deviation
- `min(...)` - smallest value
- `max(...)` - largest value
- `sort(...)`, `sorted(...)` - sorted flattened values
- `sortby(array, func)` - stable sort of `array` by `func(value)` per element
- `reverse(...)`, `reversed(...)` - reversed flattened values
- `unique(...)` - first-occurrence unique values
- `flat(...)` - concatenate scalars and arrays into one flat array
- `unpack(...)` - expand arrays into positional arguments
- `len(x)`, `length(x)` - flattened array length
- `range(start, stop [, step])` - integer sequence from `start` up to but not including `stop`; optional `step` defaults to `1` (Python-style); result length is capped at 1000
- `repeat(x, n)` - repeat scalar or array `x` exactly `n` times (concatenated); result length is capped at 1000
- Examples:
  - `sum(1,2,3,10)` -> `16`
  - `product(18446744073709551615,1)` -> `18446744073709551615`
  - `avg(1,2,3,4)` -> `2.5`
  - `sort(3,1,2)` -> `(1, 2, 3)`
  - `sort(nan,inf,2,-inf,nan,-2)` -> `(NaN, NaN, -Inf, -2, 2, Inf)`
  - `sortby((-3,-1,2), abs)` -> `(-1, 2, -3)` (stable on equal keys)
  - `sortby((2,1), polar)` -> `(1, 2)` (tuple keys `(r, angle)`, lexicographic order)
  - `f(x)=x*(10,20); sortby((3,1,2), f)` -> `(1, 2, 3)`
  - `f(x)=1/x; sortby((1,-1,-2,0,2), f)` -> `(-1, -2, 2, 1, 0)`
  - `sortby((3,1,2), x:-x)` -> `(3, 2, 1)` (anonymous lambda key; parentheses optional around the lambda)
  - `sortby((1,2), (x):(1/x))` -> `(2, 1)` (parenthesized lambda body; keys `0.5`, `1`; ascending order)
  - `sortby((5,1), ():1)` -> error (`sortby expects a function that takes 1 parameter`; zero-parameter lambdas are not allowed as the sort key)
  - `unique(3,1,3,2,1,2)` -> `(3, 1, 2)`
  - `a=(1,2); b=(4,5); flat(a,3,b,6)` -> `(1, 2, 3, 4, 5, 6)`
  - `a=(5,2); pow(unpack(a))` -> `25`
  - `len(1,2,3)` -> `3`
  - `len(range(0,10))` -> `10`
  - `range(1, 4)` -> `(1, 2, 3)`
  - `range(1, 10, 3)` -> `(1, 4, 7)`
  - `range(10, 0, -2)` -> `(10, 8, 6, 4, 2)`
  - `repeat(0, 3)` -> `(0, 0, 0)`
  - `repeat((10, 20), 2)` -> `(10, 20, 10, 20)`

Notes:

- Aggregation functions flatten array inputs.
- `variance` and `stddev` use population formulas (`N`, not `N-1`).
- With complex support enabled (see **Complex Numbers**):
  - `sum`, `product`, `avg`, `reverse`, `repeat`, `unique`, `flat`, `unpack`, and `len`/`length` accept complex scalars and arrays;
  - `min`, `max`, `sort`, `median`, `variance`, and `stddev` do not;
  - `sortby` accepts complex arrays when the key function supports complex scalars (for example `abs`).

### Output Formatting

Purpose: render values in hex/oct/bin.

- Key functions:
- `hex(...)` - format output in hexadecimal
- `oct(...)` - format output in octal
- `bin(...)` - format output in binary
- `uhex(...)` - unsigned-style hexadecimal formatting
- `uoct(...)` - unsigned-style octal formatting
- `ubin(...)` - unsigned-style binary formatting
- Examples:
  - `hex(12)` -> `0xC`
  - `bin(5,11)` -> `(0b101, 0b1011)`
  - `uhex(-1)` -> `0xFFFFFFFFFFFFFFFF`
  - `170; hex` -> `0xAA`
  - `(0x5,0x10); oct` -> `(0o5, 0o20)`
  - `0xFFFFFFFF & ~0x123; uhex` -> `0xFFFFFEDC`

Notes:

- Formatting functions require integer values.
- `uhex/uoct/ubin` show unsigned 64-bit style for negatives.

### Time Conversion

Purpose: turn a **duration** into a plain numeric length.

- Key functions:
- `milliseconds(t)` - length in whole milliseconds (integer scalar, or integer array when `t` is a duration array)
- `seconds(t)` - length in seconds (floating-point scalar or array)
- `minutes(t)` - length in minutes (floating-point scalar or array)
- `hours(t)` - length in hours (floating-point scalar or array)
- `days(t)` - length in days (floating-point scalar or array)
- Notes:
  - `t` must be a duration (literal, `second` / `minute` / etc., or an expression that evaluates to a duration), or an array of durations of any length, in which case the converter applies **element-wise** and returns an array of the same shape.
  - a plain number such as `5` is not accepted, and an array may not mix durations with non-durations.
- Examples:
  - `seconds(1:00)` -> `60`
  - `minutes(0:45)` -> `0.75`
  - `hours(12:00:00)` -> `12`
  - `days(12:00:00)` -> `0.5`
  - `milliseconds((0:01:00,0:02:00))` -> `(60000, 120000)`
  - `seconds((0:30,1:00))` -> `(30, 60)`
  - `hours((1:00,0:30)*60)` -> `(1, 0.5)`

For concepts and mixed-operator rules, see **Time values** under Common Tasks.

### Complex Utilities

Purpose: complex numbers utilities.

- Key functions:
- `real(c)` - real part of a complex number `c`
- `imag(c)` - imaginary part of a complex number `c`
- `phase(c)` - phase (angle) of a complex number `c`: `atan2(imag, real)`
- `polar(c)` - converts the complex number `c` to polar form: `r*exp(i*angle)`
- `cart((r,angle))`, `cart(r,angle)` - converts the complex number `(r,angle)` to cartesian form
- `conj(c)` - complex conjugate
- Examples:
  - `real(1+2i)` -> `1`
  - `imag(1+2i)` -> `2`
  - `phase(1+2i)` -> `1.107149`
  - `c=1+2i; atan2(imag(c), real(c))` -> `1.107149`
  - `c=1+2i; (abs(c), phase(c))` -> `(2.236068, 1.107149)`
  - `polar(1+2i)` -> `(2.236068, 1.107149)`
  - `p=polar(1+2i); r=p[0]; angle=p[1]; r*exp(i*angle)` -> `1+2i`
  - `cart(polar(1+2i))` -> `1+2i`
  - `cart((2.236068, 1.107149))` -> `0.999999+2i`
  - `cart(2.236068, 1.107149)` -> `0.999999+2i`
  - `conj(1+2i)` -> `1-2i`

- See also:
  - [Complex Number Operators](#complex-number-operators)
  - [Trigonometric and Hyperbolic With Complex Numbers](#trigonometric-and-hyperbolic-with-complex-numbers)
  - [Logarithmic and Exponential With Complex Numbers](#logarithmic-and-exponential-with-complex-numbers)
  - [Power and Root With Complex Numbers](#power-and-root-with-complex-numbers)
  - [Numeric Utilities With Complex Numbers](#numeric-utilities-with-complex-numbers)

### Random

Purpose: random values.

- Key functions:
- `rand()` - random scalar in `[0,1)`
- `random(min, max)` - random scalar in `[min,max)` (or exact bound if equal)
- Examples:
  - `rand()` -> random value in `[0,1)`
  - `random(10,20)` -> random value in `[10,20)`
  - `random(5,5)` -> `5`

## Advanced Numeric Behavior

### Advanced Behavior: Integer Accuracy (Int64/UInt64)

- SmartMath tries to keep exact signed 64-bit integer semantics when possible.
- It falls back to floating-point when required (for example division or overflow path).
- Integer-only operators are checked in a defined signed 64-bit domain.
- Shift count must be in `0..63`.

Advanced examples:

- `(2**63 - 3)/5` -> `1844674407370955161`
- `(-2**52 + 1)/5` -> `-900719925474099`
- `hex(int((9007199254740992+2)/1))` -> `0x20000000000002`
- `a=(4611686018427387903,5)<<1; hex(a[0])` -> `0x7FFFFFFFFFFFFFFE`
- `a=(9223372036854775806,9223372036854775805); b=a>>2; hex(b[0])` -> `0x1FFFFFFFFFFFFFFF`

### Advanced Behavior: NaN / Inf

- Rendering:
  - `nan`, `inf`, `-inf`
- Truthiness:
  - finite nonzero and infinities are truthy (`1`)
  - `0` and `nan` are falsy (`0`)
- Integer-only operations reject `nan`/`inf`.

### Compatibility Behavior (Current)

- `nan == nan` evaluates to `0` (IEEE unordered: NaN is not equal to any value, including another NaN).
- `nan != nan` is `1`.

These behaviors may differ from other tools/languages.

### Literals

- Decimal: `42`, `3.1415`, `1e6`
- Hex: `0x7FF`
- Binary: `0b1011`
- Octal: `0o64`
- Invalid prefixes alone are errors (for example `0x`, `0b`, `0o`).
- Time (clock-like): `MM:SS`, `HH:MM:SS`, or `DD:HH:MM:SS`; optional fraction on the **last** segment only. See **Time values** under Common Tasks.

## Errors and Troubleshooting

### Common Errors and Fixes

- `unexpected token`
  - Usually caused by malformed syntax.
  - Example: `1 + * 2`
  - Fix: check operators, commas, and parentheses.

- `bitwise operands must be integer values`
  - Example: `1.5 & 1`
  - Fix: use integer inputs.

- `modulo operands must be integer values`
  - Example: `5.2 % 2`
  - Fix: use integer inputs.

- `... expects N argument(s)`
  - Example: `pow(2)`
  - Fix: match the function signature.

- `incompatible operands`
  - Often array length mismatch (operators and two-argument array builtins such as `gcd`, `pow`, `mod`).
  - Example: `(1,2,3) + (10,20)`
  - Example: `gcd((1,2),(3,4,5))`
  - Fix: use same-length arrays or scalar broadcasting where supported.

- `array index is out of range`
  - Example: `(10,20)[5]`
  - Fix: use a valid index (`0..len-1` or negative within bounds).

- `slice step must not be zero`
  - Example: `(1,2,3)[::0]`
  - Fix: use a non-zero integer step.

- `time literal: empty segment between colons` / `time literal: invalid segment`
  - Example: `1::0` (empty segment)
  - Fix: use a valid colon pattern (`MM:SS`, `HH:MM:SS`, or `DD:HH:MM:SS`).

- `time values cannot be mixed with non-time values`
  - Fix: keep an array all-time or all non-time.

- `... expects a time value` (for example on `milliseconds(...)`)
  - Fix: pass a time value, not a plain number.

### Diagnostics Format

- Errors are one line and include location context (`col`, optional `line`).
- Current builds usually include an excerpt with `|` near the position.
- With `Parser_SetShowErrorLine(TRUE)`, location text includes line info.

Example:

- `unexpected token at col 5:  5*5 |: 25`

### Parser runtime flags (plugin / reference API)

- **Complex number support (off by default):** `Parser_SetSupportComplexNumbers` / `Parser_GetSupportComplexNumbers` in the FreeBASIC plugin parser. Default is off: behavior stays real-only (non-real domains yield `NaN` or an error as they do today). When set on, the parser registers the imaginary unit as the reserved constant **`i`** (lowercase), accepts Cartesian-style complex literals and expressions such as `10+5i`, `-1+3i`, `2-3*i`, and `-i+5`.
A tight `i` suffix on a numeric literal (decimal/scientific or `0x`/`0b`/`0o`, no space) is parsed as a pure imaginary value before any operator binds, including `**`: `3i`, `0x10i`, `2/3i` -> `2/(3i)`, `7**20i` -> `7**(20i)`. The same tight `i` after a closing `)` multiplies the parenthesized value: `(1+2)i` is the same as `((1+2)*i)`, and `1/(1+2)i` -> `1/((1+2)i)`. Spaced forms such as `3 i` are not valid (no operator between the tokens). An explicit `*` before `i` keeps the usual grouping (`2*i`, `1/(1+2)*i`, `7**20*i` -> `(7**20)*i`).

- **Time value support (on by default):** `Parser_SetSupportTimeValues` / `Parser_GetSupportTimeValues`. Default is on: colon and compact unit-suffix duration literals (`1:30`, `1d2h3m4s5ms`), duration constants (`millisecond`, `second`, `minute`, `hour`, `day`), and duration-aware arithmetic, comparisons, aggregates, and converter builtins (`milliseconds`, `seconds`, etc.) are active. When set off, the parser skips time-literal parsing and time-specific evaluation paths (plain numeric parsing only), and duration constants/converters are unavailable.

- **Lambda function support (on by default):** `Parser_SetSupportLambdaFunctions` / `Parser_GetSupportLambdaFunctions`. Default is on: lambda-style user function definitions (`f=x,x+1`, `f=(x,y):(x+y)`, etc.) and anonymous lambda keys in `sortby` (`sortby((3,1,2), x:-x)`) are active. When set off, the parser skips lambda parse and evaluation paths; any input that uses lambda definition syntax fails with `unexpected token`, while ordinary `sortby` with a named function reference (for example `sortby((-3,-1,2), abs)`) still works.

## SmartMath Settings

SmartMath Settings are stored in "SmartMath.ini" under the "plugins\Config" folder.

Manual formatting options:

```ini
[Output]
DecimalSeparatorChar=.
ThousandsSeparatorChar='
ArrayOutputSeparatorChar=,
```

Rules:

- Each of these keys uses one character (extra characters are ignored).
- Missing/empty key falls back to defaults.
- To use a space as a separator character, specify it in quotes:
  - ThousandsSeparatorChar=" "
- Input expression argument separator stays comma (`,`).
- If array output separator is changed, double-click copy normalizes array output back to comma for valid parser input.
