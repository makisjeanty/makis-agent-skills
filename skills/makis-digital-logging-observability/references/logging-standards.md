# Logging Standards

Structured logging conventions for `makis-digital`.

## Configuration example (Monolog)

```php
use Monolog\Level;
use Monolog\Logger;
use Monolog\Handler\StreamHandler;
use Monolog\Handler\RotatingFileHandler;

$logger = new Logger('makis-digital');

// Production: rotating file handler
$logger->pushHandler(
    new RotatingFileHandler(
        __DIR__ . '/../var/log/app.log',
        30,  // keep 30 days
        Level::Warning
    )
);

// Development: stdout with debug level
if ($appEnv === 'dev') {
    $logger->pushHandler(
        new StreamHandler('php://stdout', Level::Debug)
    );
}
```

## Request logging middleware

```php
class RequestLogger
{
    public function __construct(private LoggerInterface $logger) {}

    public function __invoke(callable $next): void
    {
        $start = microtime(true);

        // Process request
        $response = $next();

        $duration = (microtime(true) - $start) * 1000;

        $this->logger->info('Request processed', [
            'method' => $_SERVER['REQUEST_METHOD'],
            'route' => $_SERVER['REQUEST_URI'],
            'status' => http_response_code(),
            'duration_ms' => round($duration, 2),
            'user_id' => $this->getUserId(),
        ]);
    }
}
```

## Security event logging

```php
// Login success
$this->logger->info('Login successful', [
    'user_id' => $user->id,
    'ip' => $request->ip(),
]);

// Login failure
$this->logger->warning('Login failed', [
    'username' => $input['username'],
    'ip' => $request->ip(),
    'reason' => 'invalid_password',
]);

// Permission denied
$this->logger->warning('Permission denied', [
    'user_id' => $userId,
    'route' => $_SERVER['REQUEST_URI'],
    'required_role' => 'admin',
]);
```

## Log review checklist

- [ ] No secrets or PII in log messages or context.
- [ ] Log level matches the event significance.
- [ ] Context is structured (key-value), not interpolated into message.
- [ ] Sensitive events (login, auth, permission) have security context.
- [ ] External API calls log duration and status for performance monitoring.
- [ ] Log rotation is configured in production.
