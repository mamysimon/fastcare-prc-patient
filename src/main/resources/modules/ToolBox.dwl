%dw 2.0
fun parseType(appName) =
    if (appName matches /^((.+-)*sys(-.*)?)$/) "system" else
    if (appName matches /^((.+-)*prc(-.*)?)$/) "process" else
    if (appName matches /^((.+-)*exp(-.*)?)$/) "experience" else "unknown"