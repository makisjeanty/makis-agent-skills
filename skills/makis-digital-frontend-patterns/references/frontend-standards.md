# Frontend Standards

Conventions for PHP views and frontend code in `makis-digital`.

## Template structure

```
views/
  layouts/
    default.php       (html, head, header, footer)
    admin.php         (admin layout)
  feature/
    index.php         (list)
    show.php          (detail)
    form.php          (create/edit form)
  partials/
    _pagination.php
    _flash-messages.php
    _form-errors.php
```

## View template example

```php
<?php $this->layout('layouts/default') ?>

<h1><?= $this->e($title) ?></h1>

<?php if ($errors): ?>
  <?php $this->partial('partials/_form-errors', ['errors' => $errors]) ?>
<?php endif ?>

<form method="POST" action="/feature/<?= $item['id'] ?>/edit">
  <input type="hidden" name="csrf_token" value="<?= $this->e($csrfToken) ?>">

  <label for="name">Name</label>
  <input id="name" name="name" value="<?= $this->e($item['name'] ?? '') ?>">
  <?php if (isset($errors['name'])): ?>
    <span class="error"><?= $this->e($errors['name']) ?></span>
  <?php endif ?>

  <button type="submit">Save</button>
</form>
```

## Escaping by context

| Context | Function | Example |
|---|---|---|
| HTML body | `htmlspecialchars($value, ENT_QUOTES)` | `<?= $this->e($value) ?>` |
| HTML attribute | `htmlspecialchars($value, ENT_QUOTES)` | `value="<?= $this->e($value) ?>"` |
| JavaScript string | `json_encode($value)` | `<script>const data = <?= json_encode($data) ?></script>` |
| URL | `urlencode($value)` | `href="/page?q=<?= urlencode($query) ?>"` |
| JSON API | `json_encode($value)` | Response body |

## JavaScript structure

```js
// assets/js/app.js
window.MakisDigital = {
    init: function() {
        this.initForms();
        this.initFlashMessages();
    },
    initForms: function() {
        // form enhancements
    },
    initFlashMessages: function() {
        // auto-dismiss flash messages
    }
};
document.addEventListener('DOMContentLoaded', function() {
    MakisDigital.init();
});
```

## BEM naming

```css
/* Block: component name */
.feature-form {}

/* Element: part of block */
.feature-form__input {}
.feature-form__error {}

/* Modifier: variant */
.feature-form--disabled {}
.feature-form__input--invalid {}
```
