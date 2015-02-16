# Cligen

CLI site generator optimized for Github.io and PHP projects.

## 3rd party

Thanks to:
- [Highlight.js](https://highlightjs.org/)
- [Bootstrap](https://github.com/twbs/bootstrap)
- [cdnjs](https://cdnjs.com/)

## Configuration

All configuration is done via a single YAML file.

```yaml
main:
    links:
        github: https://github.com/bound1ess/essence
        packagist: https://packagist.org/packages/bound1ess/essence
        documentation: #docs

docs:
    from: ./docs.cligen
    to: ./docs.html
```
