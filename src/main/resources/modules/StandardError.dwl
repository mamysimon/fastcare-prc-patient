output application/json
---
{
    correlationId: vars.metadata.correlationId,
    statusCode: vars.httpStatus,
    namespace: error.errorMessage.payload.namespace default error.errorType.namespace,
    identifier: error.errorMessage.payload.identifier default error.errorType.identifier,
    description: vars.description default error.errorMessage.payload.description default error.description
}