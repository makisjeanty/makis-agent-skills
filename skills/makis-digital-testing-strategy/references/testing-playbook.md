# Testing Playbook

Practical testing patterns for `makis-digital`.

## Test structure

```
tests/
  Unit/
    Services/
    Validators/
    Security/
  Integration/
    Controllers/
    Repositories/
    Api/
  E2e/
    CriticalPaths/
```

## Unit test example

```php
public function test_validation_rejects_empty_name(): void
{
    $validator = new ProjectValidator();
    $errors = $validator->validate(['name' => '']);
    $this->assertNotEmpty($errors);
    $this->assertArrayHasKey('name', $errors);
}
```

## Integration test example

```php
public function test_create_project_requires_auth(): void
{
    $response = $this->post('/api/projects', ['name' => 'Test']);
    $this->assertEquals(401, $response->getStatusCode());
}

public function test_create_project_succeeds_with_auth(): void
{
    $user = $this->createUser();
    $response = $this->actingAs($user)->post('/api/projects', [
        'name' => 'New Project',
    ]);
    $this->assertEquals(201, $response->getStatusCode());
    $this->assertEquals('New Project', $response->getData()['name']);
}
```

## What to mock

| Scenario | Mock |
|---|---|
| External HTTP API | Mock HTTP client |
| Email sending | Mock mailer |
| File upload | Fake file upload |
| Database | Use test database (do not mock) |
| Session | Use test session driver |
| Current time | Mock DateTime/clock |

## Anti-patterns

- Testing private methods — test through public API instead.
- Mocking the class under test — test the real implementation.
- Asserting implementation details — assert behavior, not method calls.
- One giant test method — split by behavior.
- Sleep-based timing — use clock mocking or polling with timeout.
