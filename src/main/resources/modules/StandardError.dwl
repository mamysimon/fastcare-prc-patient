output application/json
var actualError = if (error.errorType.identifier == "COMPOSITE_ROUTING") 
                    (error.errorMessage.payload.failures pluck ($))[0] 
                  else 
                    error
---
{
    correlationId: vars.metadata.correlationId,
    statusCode: vars.httpStatus,
    namespace: actualError.errorMessage.payload.namespace default actualError.errorType.namespace,
    identifier: actualError.errorMessage.payload.identifier default actualError.errorType.identifier,
    description: vars.description default actualError.errorMessage.payload.description default actualError.description
}