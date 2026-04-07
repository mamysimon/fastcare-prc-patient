%dw 2.0
output application/json
---
{
    correlationId: vars.metadata.correlationId,
    statusCode: vars.httpStatus as Number default 200,
    dateTime: now() as DateTime {format: "yyyy-MM-dd'T'HH:mm:ss.SSS"},
    message: vars.customMessage default vars.metadata.endStep,
    (data: payload) if (!isEmpty(payload))
}