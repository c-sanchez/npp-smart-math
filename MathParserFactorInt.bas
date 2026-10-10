' Factorint implementation (#included from MathParser.bas).
#ifndef __MATHPARSER_FACTORINT_BODY__
#define __MATHPARSER_FACTORINT_BODY__

const FACTORINT_SMALL_PRIME_COUNT as Integer = 1229
const FACTORINT_SMALL_MAX_PRIME as ULongInt = 10007ull
static shared factorintSmallPrimes(0 to FACTORINT_SMALL_PRIME_COUNT - 1) as ULongInt = { _
  3ull, 5ull, 7ull, 11ull, 13ull, 17ull, 19ull, 23ull, 29ull, 31ull, 37ull, 41ull, _
  43ull, 47ull, 53ull, 59ull, 61ull, 67ull, 71ull, 73ull, 79ull, 83ull, 89ull, 97ull, _
  101ull, 103ull, 107ull, 109ull, 113ull, 127ull, 131ull, 137ull, 139ull, 149ull, 151ull, 157ull, _
  163ull, 167ull, 173ull, 179ull, 181ull, 191ull, 193ull, 197ull, 199ull, 211ull, 223ull, 227ull, _
  229ull, 233ull, 239ull, 241ull, 251ull, 257ull, 263ull, 269ull, 271ull, 277ull, 281ull, 283ull, _
  293ull, 307ull, 311ull, 313ull, 317ull, 331ull, 337ull, 347ull, 349ull, 353ull, 359ull, 367ull, _
  373ull, 379ull, 383ull, 389ull, 397ull, 401ull, 409ull, 419ull, 421ull, 431ull, 433ull, 439ull, _
  443ull, 449ull, 457ull, 461ull, 463ull, 467ull, 479ull, 487ull, 491ull, 499ull, 503ull, 509ull, _
  521ull, 523ull, 541ull, 547ull, 557ull, 563ull, 569ull, 571ull, 577ull, 587ull, 593ull, 599ull, _
  601ull, 607ull, 613ull, 617ull, 619ull, 631ull, 641ull, 643ull, 647ull, 653ull, 659ull, 661ull, _
  673ull, 677ull, 683ull, 691ull, 701ull, 709ull, 719ull, 727ull, 733ull, 739ull, 743ull, 751ull, _
  757ull, 761ull, 769ull, 773ull, 787ull, 797ull, 809ull, 811ull, 821ull, 823ull, 827ull, 829ull, _
  839ull, 853ull, 857ull, 859ull, 863ull, 877ull, 881ull, 883ull, 887ull, 907ull, 911ull, 919ull, _
  929ull, 937ull, 941ull, 947ull, 953ull, 967ull, 971ull, 977ull, 983ull, 991ull, 997ull, 1009ull, _
  1013ull, 1019ull, 1021ull, 1031ull, 1033ull, 1039ull, 1049ull, 1051ull, 1061ull, 1063ull, 1069ull, 1087ull, _
  1091ull, 1093ull, 1097ull, 1103ull, 1109ull, 1117ull, 1123ull, 1129ull, 1151ull, 1153ull, 1163ull, 1171ull, _
  1181ull, 1187ull, 1193ull, 1201ull, 1213ull, 1217ull, 1223ull, 1229ull, 1231ull, 1237ull, 1249ull, 1259ull, _
  1277ull, 1279ull, 1283ull, 1289ull, 1291ull, 1297ull, 1301ull, 1303ull, 1307ull, 1319ull, 1321ull, 1327ull, _
  1361ull, 1367ull, 1373ull, 1381ull, 1399ull, 1409ull, 1423ull, 1427ull, 1429ull, 1433ull, 1439ull, 1447ull, _
  1451ull, 1453ull, 1459ull, 1471ull, 1481ull, 1483ull, 1487ull, 1489ull, 1493ull, 1499ull, 1511ull, 1523ull, _
  1531ull, 1543ull, 1549ull, 1553ull, 1559ull, 1567ull, 1571ull, 1579ull, 1583ull, 1597ull, 1601ull, 1607ull, _
  1609ull, 1613ull, 1619ull, 1621ull, 1627ull, 1637ull, 1657ull, 1663ull, 1667ull, 1669ull, 1693ull, 1697ull, _
  1699ull, 1709ull, 1721ull, 1723ull, 1733ull, 1741ull, 1747ull, 1753ull, 1759ull, 1777ull, 1783ull, 1787ull, _
  1789ull, 1801ull, 1811ull, 1823ull, 1831ull, 1847ull, 1861ull, 1867ull, 1871ull, 1873ull, 1877ull, 1879ull, _
  1889ull, 1901ull, 1907ull, 1913ull, 1931ull, 1933ull, 1949ull, 1951ull, 1973ull, 1979ull, 1987ull, 1993ull, _
  1997ull, 1999ull, 2003ull, 2011ull, 2017ull, 2027ull, 2029ull, 2039ull, 2053ull, 2063ull, 2069ull, 2081ull, _
  2083ull, 2087ull, 2089ull, 2099ull, 2111ull, 2113ull, 2129ull, 2131ull, 2137ull, 2141ull, 2143ull, 2153ull, _
  2161ull, 2179ull, 2203ull, 2207ull, 2213ull, 2221ull, 2237ull, 2239ull, 2243ull, 2251ull, 2267ull, 2269ull, _
  2273ull, 2281ull, 2287ull, 2293ull, 2297ull, 2309ull, 2311ull, 2333ull, 2339ull, 2341ull, 2347ull, 2351ull, _
  2357ull, 2371ull, 2377ull, 2381ull, 2383ull, 2389ull, 2393ull, 2399ull, 2411ull, 2417ull, 2423ull, 2437ull, _
  2441ull, 2447ull, 2459ull, 2467ull, 2473ull, 2477ull, 2503ull, 2521ull, 2531ull, 2539ull, 2543ull, 2549ull, _
  2551ull, 2557ull, 2579ull, 2591ull, 2593ull, 2609ull, 2617ull, 2621ull, 2633ull, 2647ull, 2657ull, 2659ull, _
  2663ull, 2671ull, 2677ull, 2683ull, 2687ull, 2689ull, 2693ull, 2699ull, 2707ull, 2711ull, 2713ull, 2719ull, _
  2729ull, 2731ull, 2741ull, 2749ull, 2753ull, 2767ull, 2777ull, 2789ull, 2791ull, 2797ull, 2801ull, 2803ull, _
  2819ull, 2833ull, 2837ull, 2843ull, 2851ull, 2857ull, 2861ull, 2879ull, 2887ull, 2897ull, 2903ull, 2909ull, _
  2917ull, 2927ull, 2939ull, 2953ull, 2957ull, 2963ull, 2969ull, 2971ull, 2999ull, 3001ull, 3011ull, 3019ull, _
  3023ull, 3037ull, 3041ull, 3049ull, 3061ull, 3067ull, 3079ull, 3083ull, 3089ull, 3109ull, 3119ull, 3121ull, _
  3137ull, 3163ull, 3167ull, 3169ull, 3181ull, 3187ull, 3191ull, 3203ull, 3209ull, 3217ull, 3221ull, 3229ull, _
  3251ull, 3253ull, 3257ull, 3259ull, 3271ull, 3299ull, 3301ull, 3307ull, 3313ull, 3319ull, 3323ull, 3329ull, _
  3331ull, 3343ull, 3347ull, 3359ull, 3361ull, 3371ull, 3373ull, 3389ull, 3391ull, 3407ull, 3413ull, 3433ull, _
  3449ull, 3457ull, 3461ull, 3463ull, 3467ull, 3469ull, 3491ull, 3499ull, 3511ull, 3517ull, 3527ull, 3529ull, _
  3533ull, 3539ull, 3541ull, 3547ull, 3557ull, 3559ull, 3571ull, 3581ull, 3583ull, 3593ull, 3607ull, 3613ull, _
  3617ull, 3623ull, 3631ull, 3637ull, 3643ull, 3659ull, 3671ull, 3673ull, 3677ull, 3691ull, 3697ull, 3701ull, _
  3709ull, 3719ull, 3727ull, 3733ull, 3739ull, 3761ull, 3767ull, 3769ull, 3779ull, 3793ull, 3797ull, 3803ull, _
  3821ull, 3823ull, 3833ull, 3847ull, 3851ull, 3853ull, 3863ull, 3877ull, 3881ull, 3889ull, 3907ull, 3911ull, _
  3917ull, 3919ull, 3923ull, 3929ull, 3931ull, 3943ull, 3947ull, 3967ull, 3989ull, 4001ull, 4003ull, 4007ull, _
  4013ull, 4019ull, 4021ull, 4027ull, 4049ull, 4051ull, 4057ull, 4073ull, 4079ull, 4091ull, 4093ull, 4099ull, _
  4111ull, 4127ull, 4129ull, 4133ull, 4139ull, 4153ull, 4157ull, 4159ull, 4177ull, 4201ull, 4211ull, 4217ull, _
  4219ull, 4229ull, 4231ull, 4241ull, 4243ull, 4253ull, 4259ull, 4261ull, 4271ull, 4273ull, 4283ull, 4289ull, _
  4297ull, 4327ull, 4337ull, 4339ull, 4349ull, 4357ull, 4363ull, 4373ull, 4391ull, 4397ull, 4409ull, 4421ull, _
  4423ull, 4441ull, 4447ull, 4451ull, 4457ull, 4463ull, 4481ull, 4483ull, 4493ull, 4507ull, 4513ull, 4517ull, _
  4519ull, 4523ull, 4547ull, 4549ull, 4561ull, 4567ull, 4583ull, 4591ull, 4597ull, 4603ull, 4621ull, 4637ull, _
  4639ull, 4643ull, 4649ull, 4651ull, 4657ull, 4663ull, 4673ull, 4679ull, 4691ull, 4703ull, 4721ull, 4723ull, _
  4729ull, 4733ull, 4751ull, 4759ull, 4783ull, 4787ull, 4789ull, 4793ull, 4799ull, 4801ull, 4813ull, 4817ull, _
  4831ull, 4861ull, 4871ull, 4877ull, 4889ull, 4903ull, 4909ull, 4919ull, 4931ull, 4933ull, 4937ull, 4943ull, _
  4951ull, 4957ull, 4967ull, 4969ull, 4973ull, 4987ull, 4993ull, 4999ull, 5003ull, 5009ull, 5011ull, 5021ull, _
  5023ull, 5039ull, 5051ull, 5059ull, 5077ull, 5081ull, 5087ull, 5099ull, 5101ull, 5107ull, 5113ull, 5119ull, _
  5147ull, 5153ull, 5167ull, 5171ull, 5179ull, 5189ull, 5197ull, 5209ull, 5227ull, 5231ull, 5233ull, 5237ull, _
  5261ull, 5273ull, 5279ull, 5281ull, 5297ull, 5303ull, 5309ull, 5323ull, 5333ull, 5347ull, 5351ull, 5381ull, _
  5387ull, 5393ull, 5399ull, 5407ull, 5413ull, 5417ull, 5419ull, 5431ull, 5437ull, 5441ull, 5443ull, 5449ull, _
  5471ull, 5477ull, 5479ull, 5483ull, 5501ull, 5503ull, 5507ull, 5519ull, 5521ull, 5527ull, 5531ull, 5557ull, _
  5563ull, 5569ull, 5573ull, 5581ull, 5591ull, 5623ull, 5639ull, 5641ull, 5647ull, 5651ull, 5653ull, 5657ull, _
  5659ull, 5669ull, 5683ull, 5689ull, 5693ull, 5701ull, 5711ull, 5717ull, 5737ull, 5741ull, 5743ull, 5749ull, _
  5779ull, 5783ull, 5791ull, 5801ull, 5807ull, 5813ull, 5821ull, 5827ull, 5839ull, 5843ull, 5849ull, 5851ull, _
  5857ull, 5861ull, 5867ull, 5869ull, 5879ull, 5881ull, 5897ull, 5903ull, 5923ull, 5927ull, 5939ull, 5953ull, _
  5981ull, 5987ull, 6007ull, 6011ull, 6029ull, 6037ull, 6043ull, 6047ull, 6053ull, 6067ull, 6073ull, 6079ull, _
  6089ull, 6091ull, 6101ull, 6113ull, 6121ull, 6131ull, 6133ull, 6143ull, 6151ull, 6163ull, 6173ull, 6197ull, _
  6199ull, 6203ull, 6211ull, 6217ull, 6221ull, 6229ull, 6247ull, 6257ull, 6263ull, 6269ull, 6271ull, 6277ull, _
  6287ull, 6299ull, 6301ull, 6311ull, 6317ull, 6323ull, 6329ull, 6337ull, 6343ull, 6353ull, 6359ull, 6361ull, _
  6367ull, 6373ull, 6379ull, 6389ull, 6397ull, 6421ull, 6427ull, 6449ull, 6451ull, 6469ull, 6473ull, 6481ull, _
  6491ull, 6521ull, 6529ull, 6547ull, 6551ull, 6553ull, 6563ull, 6569ull, 6571ull, 6577ull, 6581ull, 6599ull, _
  6607ull, 6619ull, 6637ull, 6653ull, 6659ull, 6661ull, 6673ull, 6679ull, 6689ull, 6691ull, 6701ull, 6703ull, _
  6709ull, 6719ull, 6733ull, 6737ull, 6761ull, 6763ull, 6779ull, 6781ull, 6791ull, 6793ull, 6803ull, 6823ull, _
  6827ull, 6829ull, 6833ull, 6841ull, 6857ull, 6863ull, 6869ull, 6871ull, 6883ull, 6899ull, 6907ull, 6911ull, _
  6917ull, 6947ull, 6949ull, 6959ull, 6961ull, 6967ull, 6971ull, 6977ull, 6983ull, 6991ull, 6997ull, 7001ull, _
  7013ull, 7019ull, 7027ull, 7039ull, 7043ull, 7057ull, 7069ull, 7079ull, 7103ull, 7109ull, 7121ull, 7127ull, _
  7129ull, 7151ull, 7159ull, 7177ull, 7187ull, 7193ull, 7207ull, 7211ull, 7213ull, 7219ull, 7229ull, 7237ull, _
  7243ull, 7247ull, 7253ull, 7283ull, 7297ull, 7307ull, 7309ull, 7321ull, 7331ull, 7333ull, 7349ull, 7351ull, _
  7369ull, 7393ull, 7411ull, 7417ull, 7433ull, 7451ull, 7457ull, 7459ull, 7477ull, 7481ull, 7487ull, 7489ull, _
  7499ull, 7507ull, 7517ull, 7523ull, 7529ull, 7537ull, 7541ull, 7547ull, 7549ull, 7559ull, 7561ull, 7573ull, _
  7577ull, 7583ull, 7589ull, 7591ull, 7603ull, 7607ull, 7621ull, 7639ull, 7643ull, 7649ull, 7669ull, 7673ull, _
  7681ull, 7687ull, 7691ull, 7699ull, 7703ull, 7717ull, 7723ull, 7727ull, 7741ull, 7753ull, 7757ull, 7759ull, _
  7789ull, 7793ull, 7817ull, 7823ull, 7829ull, 7841ull, 7853ull, 7867ull, 7873ull, 7877ull, 7879ull, 7883ull, _
  7901ull, 7907ull, 7919ull, 7927ull, 7933ull, 7937ull, 7949ull, 7951ull, 7963ull, 7993ull, 8009ull, 8011ull, _
  8017ull, 8039ull, 8053ull, 8059ull, 8069ull, 8081ull, 8087ull, 8089ull, 8093ull, 8101ull, 8111ull, 8117ull, _
  8123ull, 8147ull, 8161ull, 8167ull, 8171ull, 8179ull, 8191ull, 8209ull, 8219ull, 8221ull, 8231ull, 8233ull, _
  8237ull, 8243ull, 8263ull, 8269ull, 8273ull, 8287ull, 8291ull, 8293ull, 8297ull, 8311ull, 8317ull, 8329ull, _
  8353ull, 8363ull, 8369ull, 8377ull, 8387ull, 8389ull, 8419ull, 8423ull, 8429ull, 8431ull, 8443ull, 8447ull, _
  8461ull, 8467ull, 8501ull, 8513ull, 8521ull, 8527ull, 8537ull, 8539ull, 8543ull, 8563ull, 8573ull, 8581ull, _
  8597ull, 8599ull, 8609ull, 8623ull, 8627ull, 8629ull, 8641ull, 8647ull, 8663ull, 8669ull, 8677ull, 8681ull, _
  8689ull, 8693ull, 8699ull, 8707ull, 8713ull, 8719ull, 8731ull, 8737ull, 8741ull, 8747ull, 8753ull, 8761ull, _
  8779ull, 8783ull, 8803ull, 8807ull, 8819ull, 8821ull, 8831ull, 8837ull, 8839ull, 8849ull, 8861ull, 8863ull, _
  8867ull, 8887ull, 8893ull, 8923ull, 8929ull, 8933ull, 8941ull, 8951ull, 8963ull, 8969ull, 8971ull, 8999ull, _
  9001ull, 9007ull, 9011ull, 9013ull, 9029ull, 9041ull, 9043ull, 9049ull, 9059ull, 9067ull, 9091ull, 9103ull, _
  9109ull, 9127ull, 9133ull, 9137ull, 9151ull, 9157ull, 9161ull, 9173ull, 9181ull, 9187ull, 9199ull, 9203ull, _
  9209ull, 9221ull, 9227ull, 9239ull, 9241ull, 9257ull, 9277ull, 9281ull, 9283ull, 9293ull, 9311ull, 9319ull, _
  9323ull, 9337ull, 9341ull, 9343ull, 9349ull, 9371ull, 9377ull, 9391ull, 9397ull, 9403ull, 9413ull, 9419ull, _
  9421ull, 9431ull, 9433ull, 9437ull, 9439ull, 9461ull, 9463ull, 9467ull, 9473ull, 9479ull, 9491ull, 9497ull, _
  9511ull, 9521ull, 9533ull, 9539ull, 9547ull, 9551ull, 9587ull, 9601ull, 9613ull, 9619ull, 9623ull, 9629ull, _
  9631ull, 9643ull, 9649ull, 9661ull, 9677ull, 9679ull, 9689ull, 9697ull, 9719ull, 9721ull, 9733ull, 9739ull, _
  9743ull, 9749ull, 9767ull, 9769ull, 9781ull, 9787ull, 9791ull, 9803ull, 9811ull, 9817ull, 9829ull, 9833ull, _
  9839ull, 9851ull, 9857ull, 9859ull, 9871ull, 9883ull, 9887ull, 9901ull, 9907ull, 9923ull, 9929ull, 9931ull, _
  9941ull, 9949ull, 9967ull, 9973ull, 10007ull _
}

private function MulModU64AddDouble(byval a as ULongInt, byval b as ULongInt, byval modN as ULongInt) as ULongInt
  if modN <= 1ull then return 0ull
  dim res as ULongInt = 0
  a = a mod modN
  while b > 0ull
    if (b and 1ull) <> 0ull then
      res = (res + a) mod modN
    end if
    b = b shr 1
    if b = 0ull then exit while
    a = (a + a) mod modN
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
  dim y as ULongInt = (x + 1ull) \ 2ull
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
      x = (MulModU64(x, x, n) + c) mod n
      y = (MulModU64(y, y, n) + c) mod n
      y = (MulModU64(y, y, n) + c) mod n
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
    if valueU > CULngInt(FB_I64_MAX) then
      hasUInt = TRUE
      signedI = 0
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
