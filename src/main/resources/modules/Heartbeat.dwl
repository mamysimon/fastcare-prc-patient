%dw 2.0
import p from Mule
import parseType from modules::ToolBox
output application/json
---
{
  status: "Healthy",
  name: p("app.name"),
  version: p("application.version"),
  env: p("mule.env"),
  layer: parseType(p("app.name"))
}