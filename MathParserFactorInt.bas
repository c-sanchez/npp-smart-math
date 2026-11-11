' Factorint implementation (#included from MathParser.bas).
#ifndef __MATHPARSER_FACTORINT_BODY__
#define __MATHPARSER_FACTORINT_BODY__

const FACTORINT_SMALL_PRIME_COUNT as Integer = 1229
const FACTORINT_SMALL_MAX_PRIME as ULongInt = 10007ull
static shared factorintSmallPrimes(0 to FACTORINT_SMALL_PRIME_COUNT - 1) as ULong = { _
  3ul, 5ul, 7ul, 11ul, 13ul, 17ul, 19ul, 23ul, 29ul, 31ul, 37ul, 41ul, _
  43ul, 47ul, 53ul, 59ul, 61ul, 67ul, 71ul, 73ul, 79ul, 83ul, 89ul, 97ul, _
  101ul, 103ul, 107ul, 109ul, 113ul, 127ul, 131ul, 137ul, 139ul, 149ul, 151ul, 157ul, _
  163ul, 167ul, 173ul, 179ul, 181ul, 191ul, 193ul, 197ul, 199ul, 211ul, 223ul, 227ul, _
  229ul, 233ul, 239ul, 241ul, 251ul, 257ul, 263ul, 269ul, 271ul, 277ul, 281ul, 283ul, _
  293ul, 307ul, 311ul, 313ul, 317ul, 331ul, 337ul, 347ul, 349ul, 353ul, 359ul, 367ul, _
  373ul, 379ul, 383ul, 389ul, 397ul, 401ul, 409ul, 419ul, 421ul, 431ul, 433ul, 439ul, _
  443ul, 449ul, 457ul, 461ul, 463ul, 467ul, 479ul, 487ul, 491ul, 499ul, 503ul, 509ul, _
  521ul, 523ul, 541ul, 547ul, 557ul, 563ul, 569ul, 571ul, 577ul, 587ul, 593ul, 599ul, _
  601ul, 607ul, 613ul, 617ul, 619ul, 631ul, 641ul, 643ul, 647ul, 653ul, 659ul, 661ul, _
  673ul, 677ul, 683ul, 691ul, 701ul, 709ul, 719ul, 727ul, 733ul, 739ul, 743ul, 751ul, _
  757ul, 761ul, 769ul, 773ul, 787ul, 797ul, 809ul, 811ul, 821ul, 823ul, 827ul, 829ul, _
  839ul, 853ul, 857ul, 859ul, 863ul, 877ul, 881ul, 883ul, 887ul, 907ul, 911ul, 919ul, _
  929ul, 937ul, 941ul, 947ul, 953ul, 967ul, 971ul, 977ul, 983ul, 991ul, 997ul, 1009ul, _
  1013ul, 1019ul, 1021ul, 1031ul, 1033ul, 1039ul, 1049ul, 1051ul, 1061ul, 1063ul, 1069ul, 1087ul, _
  1091ul, 1093ul, 1097ul, 1103ul, 1109ul, 1117ul, 1123ul, 1129ul, 1151ul, 1153ul, 1163ul, 1171ul, _
  1181ul, 1187ul, 1193ul, 1201ul, 1213ul, 1217ul, 1223ul, 1229ul, 1231ul, 1237ul, 1249ul, 1259ul, _
  1277ul, 1279ul, 1283ul, 1289ul, 1291ul, 1297ul, 1301ul, 1303ul, 1307ul, 1319ul, 1321ul, 1327ul, _
  1361ul, 1367ul, 1373ul, 1381ul, 1399ul, 1409ul, 1423ul, 1427ul, 1429ul, 1433ul, 1439ul, 1447ul, _
  1451ul, 1453ul, 1459ul, 1471ul, 1481ul, 1483ul, 1487ul, 1489ul, 1493ul, 1499ul, 1511ul, 1523ul, _
  1531ul, 1543ul, 1549ul, 1553ul, 1559ul, 1567ul, 1571ul, 1579ul, 1583ul, 1597ul, 1601ul, 1607ul, _
  1609ul, 1613ul, 1619ul, 1621ul, 1627ul, 1637ul, 1657ul, 1663ul, 1667ul, 1669ul, 1693ul, 1697ul, _
  1699ul, 1709ul, 1721ul, 1723ul, 1733ul, 1741ul, 1747ul, 1753ul, 1759ul, 1777ul, 1783ul, 1787ul, _
  1789ul, 1801ul, 1811ul, 1823ul, 1831ul, 1847ul, 1861ul, 1867ul, 1871ul, 1873ul, 1877ul, 1879ul, _
  1889ul, 1901ul, 1907ul, 1913ul, 1931ul, 1933ul, 1949ul, 1951ul, 1973ul, 1979ul, 1987ul, 1993ul, _
  1997ul, 1999ul, 2003ul, 2011ul, 2017ul, 2027ul, 2029ul, 2039ul, 2053ul, 2063ul, 2069ul, 2081ul, _
  2083ul, 2087ul, 2089ul, 2099ul, 2111ul, 2113ul, 2129ul, 2131ul, 2137ul, 2141ul, 2143ul, 2153ul, _
  2161ul, 2179ul, 2203ul, 2207ul, 2213ul, 2221ul, 2237ul, 2239ul, 2243ul, 2251ul, 2267ul, 2269ul, _
  2273ul, 2281ul, 2287ul, 2293ul, 2297ul, 2309ul, 2311ul, 2333ul, 2339ul, 2341ul, 2347ul, 2351ul, _
  2357ul, 2371ul, 2377ul, 2381ul, 2383ul, 2389ul, 2393ul, 2399ul, 2411ul, 2417ul, 2423ul, 2437ul, _
  2441ul, 2447ul, 2459ul, 2467ul, 2473ul, 2477ul, 2503ul, 2521ul, 2531ul, 2539ul, 2543ul, 2549ul, _
  2551ul, 2557ul, 2579ul, 2591ul, 2593ul, 2609ul, 2617ul, 2621ul, 2633ul, 2647ul, 2657ul, 2659ul, _
  2663ul, 2671ul, 2677ul, 2683ul, 2687ul, 2689ul, 2693ul, 2699ul, 2707ul, 2711ul, 2713ul, 2719ul, _
  2729ul, 2731ul, 2741ul, 2749ul, 2753ul, 2767ul, 2777ul, 2789ul, 2791ul, 2797ul, 2801ul, 2803ul, _
  2819ul, 2833ul, 2837ul, 2843ul, 2851ul, 2857ul, 2861ul, 2879ul, 2887ul, 2897ul, 2903ul, 2909ul, _
  2917ul, 2927ul, 2939ul, 2953ul, 2957ul, 2963ul, 2969ul, 2971ul, 2999ul, 3001ul, 3011ul, 3019ul, _
  3023ul, 3037ul, 3041ul, 3049ul, 3061ul, 3067ul, 3079ul, 3083ul, 3089ul, 3109ul, 3119ul, 3121ul, _
  3137ul, 3163ul, 3167ul, 3169ul, 3181ul, 3187ul, 3191ul, 3203ul, 3209ul, 3217ul, 3221ul, 3229ul, _
  3251ul, 3253ul, 3257ul, 3259ul, 3271ul, 3299ul, 3301ul, 3307ul, 3313ul, 3319ul, 3323ul, 3329ul, _
  3331ul, 3343ul, 3347ul, 3359ul, 3361ul, 3371ul, 3373ul, 3389ul, 3391ul, 3407ul, 3413ul, 3433ul, _
  3449ul, 3457ul, 3461ul, 3463ul, 3467ul, 3469ul, 3491ul, 3499ul, 3511ul, 3517ul, 3527ul, 3529ul, _
  3533ul, 3539ul, 3541ul, 3547ul, 3557ul, 3559ul, 3571ul, 3581ul, 3583ul, 3593ul, 3607ul, 3613ul, _
  3617ul, 3623ul, 3631ul, 3637ul, 3643ul, 3659ul, 3671ul, 3673ul, 3677ul, 3691ul, 3697ul, 3701ul, _
  3709ul, 3719ul, 3727ul, 3733ul, 3739ul, 3761ul, 3767ul, 3769ul, 3779ul, 3793ul, 3797ul, 3803ul, _
  3821ul, 3823ul, 3833ul, 3847ul, 3851ul, 3853ul, 3863ul, 3877ul, 3881ul, 3889ul, 3907ul, 3911ul, _
  3917ul, 3919ul, 3923ul, 3929ul, 3931ul, 3943ul, 3947ul, 3967ul, 3989ul, 4001ul, 4003ul, 4007ul, _
  4013ul, 4019ul, 4021ul, 4027ul, 4049ul, 4051ul, 4057ul, 4073ul, 4079ul, 4091ul, 4093ul, 4099ul, _
  4111ul, 4127ul, 4129ul, 4133ul, 4139ul, 4153ul, 4157ul, 4159ul, 4177ul, 4201ul, 4211ul, 4217ul, _
  4219ul, 4229ul, 4231ul, 4241ul, 4243ul, 4253ul, 4259ul, 4261ul, 4271ul, 4273ul, 4283ul, 4289ul, _
  4297ul, 4327ul, 4337ul, 4339ul, 4349ul, 4357ul, 4363ul, 4373ul, 4391ul, 4397ul, 4409ul, 4421ul, _
  4423ul, 4441ul, 4447ul, 4451ul, 4457ul, 4463ul, 4481ul, 4483ul, 4493ul, 4507ul, 4513ul, 4517ul, _
  4519ul, 4523ul, 4547ul, 4549ul, 4561ul, 4567ul, 4583ul, 4591ul, 4597ul, 4603ul, 4621ul, 4637ul, _
  4639ul, 4643ul, 4649ul, 4651ul, 4657ul, 4663ul, 4673ul, 4679ul, 4691ul, 4703ul, 4721ul, 4723ul, _
  4729ul, 4733ul, 4751ul, 4759ul, 4783ul, 4787ul, 4789ul, 4793ul, 4799ul, 4801ul, 4813ul, 4817ul, _
  4831ul, 4861ul, 4871ul, 4877ul, 4889ul, 4903ul, 4909ul, 4919ul, 4931ul, 4933ul, 4937ul, 4943ul, _
  4951ul, 4957ul, 4967ul, 4969ul, 4973ul, 4987ul, 4993ul, 4999ul, 5003ul, 5009ul, 5011ul, 5021ul, _
  5023ul, 5039ul, 5051ul, 5059ul, 5077ul, 5081ul, 5087ul, 5099ul, 5101ul, 5107ul, 5113ul, 5119ul, _
  5147ul, 5153ul, 5167ul, 5171ul, 5179ul, 5189ul, 5197ul, 5209ul, 5227ul, 5231ul, 5233ul, 5237ul, _
  5261ul, 5273ul, 5279ul, 5281ul, 5297ul, 5303ul, 5309ul, 5323ul, 5333ul, 5347ul, 5351ul, 5381ul, _
  5387ul, 5393ul, 5399ul, 5407ul, 5413ul, 5417ul, 5419ul, 5431ul, 5437ul, 5441ul, 5443ul, 5449ul, _
  5471ul, 5477ul, 5479ul, 5483ul, 5501ul, 5503ul, 5507ul, 5519ul, 5521ul, 5527ul, 5531ul, 5557ul, _
  5563ul, 5569ul, 5573ul, 5581ul, 5591ul, 5623ul, 5639ul, 5641ul, 5647ul, 5651ul, 5653ul, 5657ul, _
  5659ul, 5669ul, 5683ul, 5689ul, 5693ul, 5701ul, 5711ul, 5717ul, 5737ul, 5741ul, 5743ul, 5749ul, _
  5779ul, 5783ul, 5791ul, 5801ul, 5807ul, 5813ul, 5821ul, 5827ul, 5839ul, 5843ul, 5849ul, 5851ul, _
  5857ul, 5861ul, 5867ul, 5869ul, 5879ul, 5881ul, 5897ul, 5903ul, 5923ul, 5927ul, 5939ul, 5953ul, _
  5981ul, 5987ul, 6007ul, 6011ul, 6029ul, 6037ul, 6043ul, 6047ul, 6053ul, 6067ul, 6073ul, 6079ul, _
  6089ul, 6091ul, 6101ul, 6113ul, 6121ul, 6131ul, 6133ul, 6143ul, 6151ul, 6163ul, 6173ul, 6197ul, _
  6199ul, 6203ul, 6211ul, 6217ul, 6221ul, 6229ul, 6247ul, 6257ul, 6263ul, 6269ul, 6271ul, 6277ul, _
  6287ul, 6299ul, 6301ul, 6311ul, 6317ul, 6323ul, 6329ul, 6337ul, 6343ul, 6353ul, 6359ul, 6361ul, _
  6367ul, 6373ul, 6379ul, 6389ul, 6397ul, 6421ul, 6427ul, 6449ul, 6451ul, 6469ul, 6473ul, 6481ul, _
  6491ul, 6521ul, 6529ul, 6547ul, 6551ul, 6553ul, 6563ul, 6569ul, 6571ul, 6577ul, 6581ul, 6599ul, _
  6607ul, 6619ul, 6637ul, 6653ul, 6659ul, 6661ul, 6673ul, 6679ul, 6689ul, 6691ul, 6701ul, 6703ul, _
  6709ul, 6719ul, 6733ul, 6737ul, 6761ul, 6763ul, 6779ul, 6781ul, 6791ul, 6793ul, 6803ul, 6823ul, _
  6827ul, 6829ul, 6833ul, 6841ul, 6857ul, 6863ul, 6869ul, 6871ul, 6883ul, 6899ul, 6907ul, 6911ul, _
  6917ul, 6947ul, 6949ul, 6959ul, 6961ul, 6967ul, 6971ul, 6977ul, 6983ul, 6991ul, 6997ul, 7001ul, _
  7013ul, 7019ul, 7027ul, 7039ul, 7043ul, 7057ul, 7069ul, 7079ul, 7103ul, 7109ul, 7121ul, 7127ul, _
  7129ul, 7151ul, 7159ul, 7177ul, 7187ul, 7193ul, 7207ul, 7211ul, 7213ul, 7219ul, 7229ul, 7237ul, _
  7243ul, 7247ul, 7253ul, 7283ul, 7297ul, 7307ul, 7309ul, 7321ul, 7331ul, 7333ul, 7349ul, 7351ul, _
  7369ul, 7393ul, 7411ul, 7417ul, 7433ul, 7451ul, 7457ul, 7459ul, 7477ul, 7481ul, 7487ul, 7489ul, _
  7499ul, 7507ul, 7517ul, 7523ul, 7529ul, 7537ul, 7541ul, 7547ul, 7549ul, 7559ul, 7561ul, 7573ul, _
  7577ul, 7583ul, 7589ul, 7591ul, 7603ul, 7607ul, 7621ul, 7639ul, 7643ul, 7649ul, 7669ul, 7673ul, _
  7681ul, 7687ul, 7691ul, 7699ul, 7703ul, 7717ul, 7723ul, 7727ul, 7741ul, 7753ul, 7757ul, 7759ul, _
  7789ul, 7793ul, 7817ul, 7823ul, 7829ul, 7841ul, 7853ul, 7867ul, 7873ul, 7877ul, 7879ul, 7883ul, _
  7901ul, 7907ul, 7919ul, 7927ul, 7933ul, 7937ul, 7949ul, 7951ul, 7963ul, 7993ul, 8009ul, 8011ul, _
  8017ul, 8039ul, 8053ul, 8059ul, 8069ul, 8081ul, 8087ul, 8089ul, 8093ul, 8101ul, 8111ul, 8117ul, _
  8123ul, 8147ul, 8161ul, 8167ul, 8171ul, 8179ul, 8191ul, 8209ul, 8219ul, 8221ul, 8231ul, 8233ul, _
  8237ul, 8243ul, 8263ul, 8269ul, 8273ul, 8287ul, 8291ul, 8293ul, 8297ul, 8311ul, 8317ul, 8329ul, _
  8353ul, 8363ul, 8369ul, 8377ul, 8387ul, 8389ul, 8419ul, 8423ul, 8429ul, 8431ul, 8443ul, 8447ul, _
  8461ul, 8467ul, 8501ul, 8513ul, 8521ul, 8527ul, 8537ul, 8539ul, 8543ul, 8563ul, 8573ul, 8581ul, _
  8597ul, 8599ul, 8609ul, 8623ul, 8627ul, 8629ul, 8641ul, 8647ul, 8663ul, 8669ul, 8677ul, 8681ul, _
  8689ul, 8693ul, 8699ul, 8707ul, 8713ul, 8719ul, 8731ul, 8737ul, 8741ul, 8747ul, 8753ul, 8761ul, _
  8779ul, 8783ul, 8803ul, 8807ul, 8819ul, 8821ul, 8831ul, 8837ul, 8839ul, 8849ul, 8861ul, 8863ul, _
  8867ul, 8887ul, 8893ul, 8923ul, 8929ul, 8933ul, 8941ul, 8951ul, 8963ul, 8969ul, 8971ul, 8999ul, _
  9001ul, 9007ul, 9011ul, 9013ul, 9029ul, 9041ul, 9043ul, 9049ul, 9059ul, 9067ul, 9091ul, 9103ul, _
  9109ul, 9127ul, 9133ul, 9137ul, 9151ul, 9157ul, 9161ul, 9173ul, 9181ul, 9187ul, 9199ul, 9203ul, _
  9209ul, 9221ul, 9227ul, 9239ul, 9241ul, 9257ul, 9277ul, 9281ul, 9283ul, 9293ul, 9311ul, 9319ul, _
  9323ul, 9337ul, 9341ul, 9343ul, 9349ul, 9371ul, 9377ul, 9391ul, 9397ul, 9403ul, 9413ul, 9419ul, _
  9421ul, 9431ul, 9433ul, 9437ul, 9439ul, 9461ul, 9463ul, 9467ul, 9473ul, 9479ul, 9491ul, 9497ul, _
  9511ul, 9521ul, 9533ul, 9539ul, 9547ul, 9551ul, 9587ul, 9601ul, 9613ul, 9619ul, 9623ul, 9629ul, _
  9631ul, 9643ul, 9649ul, 9661ul, 9677ul, 9679ul, 9689ul, 9697ul, 9719ul, 9721ul, 9733ul, 9739ul, _
  9743ul, 9749ul, 9767ul, 9769ul, 9781ul, 9787ul, 9791ul, 9803ul, 9811ul, 9817ul, 9829ul, 9833ul, _
  9839ul, 9851ul, 9857ul, 9859ul, 9871ul, 9883ul, 9887ul, 9901ul, 9907ul, 9923ul, 9929ul, 9931ul, _
  9941ul, 9949ul, 9967ul, 9973ul, 10007ul _
}

'' a and b must be < modN; avoids a + b wrapping when modN > 2^63.
private function AddModU64(byval a as ULongInt, byval b as ULongInt, byval modN as ULongInt) as ULongInt
  if a >= modN - b then return a - (modN - b)
  return a + b
end function

private function MulModU64AddDouble(byval a as ULongInt, byval b as ULongInt, byval modN as ULongInt) as ULongInt
  if modN <= 1ull then return 0ull
  dim res as ULongInt = 0
  a = a mod modN
  while b > 0ull
    if (b and 1ull) <> 0ull then
      res = AddModU64(res, a, modN)
    end if
    b = b shr 1
    if b = 0ull then exit while
    a = AddModU64(a, a, modN)
  wend
  return res
end function

private function MulModU64(byval a as ULongInt, byval b as ULongInt, byval modN as ULongInt) as ULongInt
  if modN <= 1ull then return 0ull
  a = a mod modN
  b = b mod modN
  if a = 0ull orelse b = 0ull then return 0ull
  if a > 0ull andalso b <= &hFFFFFFFFFFFFFFFFull \ a then
    return (a * b) mod modN
  end if
  return MulModU64AddDouble(a, b, modN)
end function

private function PowModU64(byval baseV as ULongInt, byval expV as ULongInt, byval modN as ULongInt) as ULongInt
  dim res as ULongInt = 1
  dim b as ULongInt = baseV mod modN
  dim e as ULongInt = expV
  while e > 0ull
    if (e and 1ull) <> 0ull then res = MulModU64(res, b, modN)
    b = MulModU64(b, b, modN)
    e = e shr 1
  wend
  return res
end function

private const FACTORINT_ENTRIES_INIT_CAP as Integer = 8
private const FACTORINT_POLLARD_MAX_OUTER as Integer = 48
private const FACTORINT_RHO_MAX_ITERS as Integer = 400000
private const FACTORINT_RHO_MAX_ITERS_SMALL as Integer = 80000
private const FACTORINT_FERMAT_MAX_STEPS as Integer = 4096
private const FACTORINT_FERMAT_MAX_N as ULongInt = 100000000ull
private const FACTORINT_ODD_TRIAL_MAX_PRIME as ULongInt = 10000000ull

type FactorintPrimeEntry
  baseU as ULongInt
  expV as UInteger
end type

private function IsqrtU64(byval n as ULongInt) as ULongInt
  if n = 0ull then return 0ull
  dim x as ULongInt = n
  dim y as ULongInt = (x \ 2ull) + (x and 1ull)
  while y < x
    x = y
    y = (x + n \ x) \ 2ull
  wend
  return x
end function

private function IsPrimeU64(byval n as ULongInt) as Boolean
  if n < 2ull then return FALSE
  if n = 2ull orelse n = 3ull then return TRUE
  if (n and 1ull) = 0ull then return FALSE
  static tinyPrimes(0 to 10) as ULongInt = {3ull, 5ull, 7ull, 11ull, 13ull, 17ull, 19ull, 23ull, 29ull, 31ull, 37ull}
  static mrBases(0 to 6) as ULongInt = {2ull, 32544231ull, 2567547226ull, 4118087717ull, 6700417ull, 12917328ull, 1297059741ull}
  dim ti as Integer
  for ti = 0 to 10
    dim p as ULongInt = tinyPrimes(ti)
    if n = p then return TRUE
    if (n mod p) = 0ull then return FALSE
  next ti
  dim d as ULongInt = n - 1ull
  dim s as Integer = 0
  while (d and 1ull) = 0ull
    d = d shr 1
    s += 1
  wend
  dim i as Integer
  for i = 0 to 6
    dim a as ULongInt = mrBases(i)
    if n <= a then exit for
    dim x as ULongInt = PowModU64(a, d, n)
    if x = 1ull orelse x = n - 1ull then continue for
    dim composite as Boolean = TRUE
    dim r as Integer
    for r = 1 to s - 1
      x = MulModU64(x, x, n)
      if x = n - 1ull then
        composite = FALSE
        exit for
      end if
    next r
    if composite then return FALSE
  next i
  return TRUE
end function

private function FermatFactorU64(byval n as ULongInt) as ULongInt
  if (n and 1ull) = 0ull then return 2ull
  dim a as ULongInt = IsqrtU64(n)
  if a * a < n then a += 1ull
  dim b2 as ULongInt = a * a - n
  dim fermatIter as Integer
  for fermatIter = 0 to FACTORINT_FERMAT_MAX_STEPS - 1
    dim b as ULongInt = IsqrtU64(b2)
    if b * b = b2 then
      dim p as ULongInt = a - b
      dim q as ULongInt = a + b
      if p > 1ull andalso p < n then return p
      if q > 1ull andalso q < n then return q
    end if
    a += 1ull
    b2 = a * a - n
  next fermatIter
  return n
end function

private function PollardRhoMaxIters(byval n as ULongInt) as Integer
  if n < 4294967296ull then return FACTORINT_RHO_MAX_ITERS_SMALL
  return FACTORINT_RHO_MAX_ITERS
end function

private function PollardRhoU64(byval n as ULongInt) as ULongInt
  if (n and 1ull) = 0ull then return 2ull
  if (n mod 3ull) = 0ull then return 3ull
  dim maxIter as Integer = PollardRhoMaxIters(n)
  dim attempt as Integer
  for attempt = 0 to FACTORINT_POLLARD_MAX_OUTER - 1
    dim c as ULongInt = 1ull + CULngInt(attempt)
    dim y0 as ULongInt = 2ull + ((n mod 1000003ull) + CULngInt(attempt)) mod (n - 2ull)
    dim x as ULongInt = y0
    dim y as ULongInt = y0
    dim d as ULongInt = 1ull
    dim iter as Integer
    for iter = 1 to maxIter
      if d <> 1ull then exit for
      x = AddModU64(MulModU64(x, x, n), c mod n, n)
      y = AddModU64(MulModU64(y, y, n), c mod n, n)
      y = AddModU64(MulModU64(y, y, n), c mod n, n)
      dim diff as ULongInt
      if x >= y then diff = x - y else diff = y - x
      if diff = 0ull then continue for
      d = GcdULong(diff, n)
      if d = n then
        y = x
        d = 1ull
      end if
    next iter
    if d > 1ull andalso d < n then return d
  next attempt
  return n
end function

private function FactorintOddTrialLimit(byval n as ULongInt) as ULongInt
  dim sqrtN as ULongInt = IsqrtU64(n)
  if sqrtN > FACTORINT_ODD_TRIAL_MAX_PRIME then return FACTORINT_ODD_TRIAL_MAX_PRIME
  return sqrtN
end function

private function FactorintExhaustiveTrialDone(byval n as ULongInt) as Boolean
  return IsqrtU64(n) <= FactorintOddTrialLimit(n)
end function

private function FactorintFindSplitFactor(byval n as ULongInt) as ULongInt
  if IsPrimeU64(n) then return n
  if n <= FACTORINT_FERMAT_MAX_N then
    dim factor as ULongInt = FermatFactorU64(n)
    if factor > 1ull andalso factor < n then return factor
  end if
  dim rhoFactor as ULongInt = PollardRhoU64(n)
  if rhoFactor > 1ull andalso rhoFactor < n then return rhoFactor
  return n
end function

private sub FactorintEntriesEnsure(entries() as FactorintPrimeEntry, byref cap as Integer, byval need as Integer)
  if need <= cap then exit sub
  if cap <= 0 then cap = FACTORINT_ENTRIES_INIT_CAP
  while cap < need
    cap *= 2
  wend
  redim preserve entries(0 to cap - 1)
end sub

private sub FactorintEntriesAdd(entries() as FactorintPrimeEntry, byref cnt as Integer, byref cap as Integer, byval baseU as ULongInt, byval expV as UInteger)
  if cnt > 0 andalso entries(cnt - 1).baseU = baseU then
    entries(cnt - 1).expV += expV
    exit sub
  end if
  FactorintEntriesEnsure(entries(), cap, cnt + 1)
  entries(cnt).baseU = baseU
  entries(cnt).expV = expV
  cnt += 1
end sub

private sub FactorintTrialDividePrime(byval p as ULongInt, byref n as ULongInt, entries() as FactorintPrimeEntry, byref cnt as Integer, byref cap as Integer)
  if n < p then exit sub
  if (n mod p) <> 0ull then exit sub
  dim e as UInteger = 0
  do
    n = n \ p
    e += 1
  loop while (n mod p) = 0ull
  FactorintEntriesAdd(entries(), cnt, cap, p, e)
end sub

private sub FactorintTrialDivideOdd(byref n as ULongInt, entries() as FactorintPrimeEntry, byref cnt as Integer, byref cap as Integer)
  dim d as ULongInt = FACTORINT_SMALL_MAX_PRIME + 2ull
  if (d and 1ull) = 0ull then d += 1ull
  dim limit as ULongInt = FactorintOddTrialLimit(n)
  while d <= limit
    FactorintTrialDividePrime(d, n, entries(), cnt, cap)
    if n <= 1ull then exit sub
    d += 2ull
  wend
end sub

private sub FactorizeU64IntoEntries(byval n as ULongInt, entries() as FactorintPrimeEntry, byref cnt as Integer, byref cap as Integer)
  if n <= 1ull then exit sub
  dim twoExp as UInteger = 0
  while (n and 1ull) = 0ull
    twoExp += 1
    n = n shr 1
  wend
  if twoExp > 0 then FactorintEntriesAdd(entries(), cnt, cap, 2ull, twoExp)
  if n <= 1ull then exit sub
  dim lo as Integer = 0
  dim hi as Integer = FACTORINT_SMALL_PRIME_COUNT
  while lo < hi
    dim trialMid as Integer = lo + (hi - lo) \ 2
    dim pMid as ULongInt = factorintSmallPrimes(trialMid)
    if pMid <= n \ pMid then
      lo = trialMid + 1
    else
      hi = trialMid
    end if
  wend
  dim trialLimit as Integer = lo
  dim si as Integer
  for si = 0 to trialLimit - 1
    FactorintTrialDividePrime(factorintSmallPrimes(si), n, entries(), cnt, cap)
    if n <= 1ull then exit sub
  next si
  if n <= 1ull then exit sub
  if IsqrtU64(n) > FACTORINT_ODD_TRIAL_MAX_PRIME andalso IsPrimeU64(n) then
    FactorintEntriesAdd(entries(), cnt, cap, n, 1)
    exit sub
  end if
  FactorintTrialDivideOdd(n, entries(), cnt, cap)
  if n <= 1ull then exit sub
  if FactorintExhaustiveTrialDone(n) orelse IsPrimeU64(n) then
    FactorintEntriesAdd(entries(), cnt, cap, n, 1)
    exit sub
  end if
  dim factor as ULongInt = FactorintFindSplitFactor(n)
  if factor <= 1ull orelse factor >= n then
    FactorintEntriesAdd(entries(), cnt, cap, n, 1)
    exit sub
  end if
  FactorizeU64IntoEntries(factor, entries(), cnt, cap)
  FactorizeU64IntoEntries(n \ factor, entries(), cnt, cap)
end sub

private sub SortFactorintEntries(entries() as FactorintPrimeEntry, byref cnt as Integer)
  if cnt <= 1 then exit sub
  dim i as Integer
  dim j as Integer
  for i = 0 to cnt - 2
    for j = i + 1 to cnt - 1
      if entries(j).baseU < entries(i).baseU then
        dim t as FactorintPrimeEntry = entries(i)
        entries(i) = entries(j)
        entries(j) = t
      end if
    next j
  next i
  i = 1
  while i < cnt
    if entries(i).baseU = entries(i - 1).baseU then
      entries(i - 1).expV += entries(i).expV
      for j = i to cnt - 2
        entries(j) = entries(j + 1)
      next j
      cnt -= 1
    else
      i += 1
    end if
  wend
end sub

private function TryGetFactorintInput(byref v as EvalValue, byref isNegative as Boolean, byref absU as ULongInt) as Boolean
  if v.kind <> VK_SCALAR then return FALSE
  dim sv as ScalarValue = v.scalarValue
  ScalarRepairExactMetadata(sv)
  if ScalarExactInt64Valid(sv) then
    if sv.exactInt64 < 0 then
      isNegative = TRUE
      if sv.exactInt64 = FB_I64_MIN then
        absU = 9223372036854775808ull
      else
        absU = CULngInt(-sv.exactInt64)
      end if
      return TRUE
    end if
    isNegative = FALSE
    absU = CULngInt(sv.exactInt64)
    return TRUE
  end if
  if ScalarExactUInt64Valid(sv) orelse sv.scalarStorageKind = SSK_UINT64 then
    isNegative = FALSE
    absU = sv.exactUInt64
    return TRUE
  end if
  dim li as LongInt
  if TryGetExactInt64FromDouble(sv.scalar, li) = FALSE then return FALSE
  if li < 0 then
    isNegative = TRUE
    if li = FB_I64_MIN then
      absU = 9223372036854775808ull
    else
      absU = CULngInt(-li)
    end if
    return TRUE
  end if
  isNegative = FALSE
  absU = CULngInt(li)
  return TRUE
end function

private sub ScalarClearIntPowerRender(byref sv as ScalarValue)
  sv.flags and= not CUInt(SVF_RENDER_INT_POWER)
  sv.imagExactInt64 = 0
  sv.imagExactUInt64 = 0
end sub

private sub ScalarSetFactorintTermValue(byref sv as ScalarValue, byval valueI as LongInt, byval valueU as ULongInt, byval hasUIntValue as Boolean)
  ScalarClearIntPowerRender(sv)
  sv.scalar = CDbl(IIf(hasUIntValue, valueU, valueI))
  if hasUIntValue then
    ScalarSyncExactUInt64WithIntMirror(sv, valueU)
    sv.scalarStorageKind = SSK_UINT64
  else
    ScalarSyncExactInt64WithUIntMirror(sv, valueI)
    sv.scalarStorageKind = SSK_INT64
  end if
end sub

private sub ScalarSetFactorintPowerTerm(byref sv as ScalarValue, byval baseU as ULongInt, byval expV as Integer, byval signedValueI as LongInt, byval valueU as ULongInt, byval hasUIntValue as Boolean)
  ScalarSetFactorintTermValue(sv, signedValueI, valueU, hasUIntValue)
  if expV <= 1 then exit sub
  sv.flags or= SVF_RENDER_INT_POWER
  dim displayBase as LongInt = CLngInt(baseU)
  if signedValueI < 0 andalso baseU <= CULngInt(FB_I64_MAX) then displayBase = -CLngInt(baseU)
  sv.imagExactInt64 = displayBase
  sv.imagExactUInt64 = CULngInt(expV)
end sub

private sub FactorintAppendScalarTerm( _
  outArr() as ScalarValue, _
  byref outCount as Integer, _
  byval baseU as ULongInt, _
  byval expV as Integer, _
  byref applySign as Boolean _
)
  dim valueU as ULongInt = baseU
  if expV > 1 then
    if TryPowULong(baseU, CULngInt(expV), valueU) = FALSE then exit sub
  end if
  dim signedI as LongInt = CLngInt(valueU)
  dim hasUInt as Boolean = FALSE
  if applySign then
    applySign = FALSE
    '' A negative input has magnitude <= 2^63, so the signed term always fits.
    if valueU = FB_I64_MIN_MAG_U then
      signedI = FB_I64_MIN
    else
      signedI = -CLngInt(valueU)
    end if
  elseif valueU > FB_I64_MAX_U then
    hasUInt = TRUE
    signedI = 0
  end if
  outCount += 1
  redim preserve outArr(0 to outCount - 1)
  if expV > 1 then
    ScalarSetFactorintPowerTerm(outArr(outCount - 1), baseU, expV, signedI, valueU, hasUInt)
  else
    ScalarSetFactorintTermValue(outArr(outCount - 1), signedI, valueU, hasUInt)
  end if
end sub

function TryApplyFactorint(byref v as EvalValue, byref outV as EvalValue) as Boolean
  if v.kind = VK_ARRAY then return FALSE
  dim isNegative as Boolean
  dim absU as ULongInt
  if TryGetFactorintInput(v, isNegative, absU) = FALSE then return FALSE

  dim terms() as ScalarValue
  dim termCount as Integer = 0

  if absU = 0ull then
    redim terms(0 to 0)
    ScalarSetFactorintTermValue(terms(0), 0, 0ull, FALSE)
    termCount = 1
  elseif absU = 1ull then
    redim terms(0 to 0)
    if isNegative then
      ScalarSetFactorintTermValue(terms(0), -1, 1ull, FALSE)
    else
      ScalarSetFactorintTermValue(terms(0), 1, 1ull, FALSE)
    end if
    termCount = 1
  else
    dim entries() as FactorintPrimeEntry
    dim entryCount as Integer = 0
    dim entryCap as Integer = 0
    FactorizeU64IntoEntries(absU, entries(), entryCount, entryCap)
    if entryCount = 0 then return FALSE
    SortFactorintEntries(entries(), entryCount)
    dim ei as Integer
    for ei = 0 to entryCount - 1
      dim applySign as Boolean = (isNegative andalso ei = 0)
      dim expV as Integer = CInt(entries(ei).expV)
      FactorintAppendScalarTerm(terms(), termCount, entries(ei).baseU, expV, applySign)
    next ei
  end if

  if termCount <= 0 then return FALSE
  ValueSetArrayFromScalarValues(outV, terms())
  return TRUE
end function

#endif
