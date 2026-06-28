# Error Handling Standards

Patterns for consistent error handling in `makis-digital`.

## Base exception

```php
namespace App\Exceptions;

class AppException extends \RuntimeException
{
    public function __construct(
        string $message = '',
        protected array $context = [],
        int $code = 0,
        ?\Throwable $previous = null
    ) {
        parent::__construct($message, $code, $previous);
    }

    public function getContext(): array
    {
        return $this->context;
    }
}
```

## Typed exceptions

```php
class ValidationException extends AppException
{
    protected array $errors;

    public function __construct(array $errors)
    {
        parent::__construct('Validation failed', $errors, 400);
        $this->errors = $errors;
    }

    public function getErrors(): array
    {
        return $this->errors;
    }
}

class NotFoundException extends AppException
{
    public function __construct(string $resource, int|string $id)
    {
        parent::__construct(
            "{$resource} not found",
            ['resource' => $resource, 'id' => $id],
            404
        );
    }
}
```

## Controller pattern

```php
try {
    $result = $this->service->doSomething($requestData);
    $this->jsonResponse($result);
} catch (ValidationException $e) {
    $this->jsonResponse(['errors' => $e->getErrors()], 400);
} catch (NotFoundException $e) {
    $this->jsonResponse(['errors' => [['message' => 'Not found']]], 404);
} catch (AppException $e) {
    $this->logger->warning($e->getMessage(), $e->getContext());
    $this->jsonResponse(['errors' => [['message' => $e->getMessage()]]], $e->getCode());
} catch (\Throwable $e) {
    $this->logger->error('Unexpected error', [
        'message' => $e->getMessage(),
        'route' => $this->getRoute(),
    ]);
    $this->jsonResponse(['errors' => [['message' => 'Internal error']]], 500);
}
```

## What to log

| Level | When | What to include |
|---|---|---|
| debug | Unexpected but handled | Message, context |
| info | Operational error (404, 400) | Route, user id |
| warning | Recoverable failure (rate-limit) | Context, retry-after |
| error | Unexpected exception | Full exception, route, user |
| critical | System unavailable | Full exception, stack trace |

## What not to log

- API keys, tokens, passwords
- Full request bodies or database rows
- Session identifiers
- Personal identifiable information

## User-safe messages

| Exception | User message |
|---|---|
| ValidationException | Field-level errors |
| AuthenticationException | "Authentication required" |
| AuthorizationException | "You do not have permission" |
| NotFoundException | "Resource not found" |
| RateLimitException | "Too many requests, try later" |
| ExternalServiceException | "A dependent service is unavailable" |
| Unexpected | "An internal error occurred" |
