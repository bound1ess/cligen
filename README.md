# Cligen

Deadly simple CLI pages generator (experiment).

## Example

Check out `example` directory.

## Screenshots

![](http://i.imgur.com/VPArKjZ.png)

![](http://i.imgur.com/yciuKsG.png)

### Cligen format

```
// =text
Welcome to the documentation page!
I hope you will find it useful.
Use the menu above to navigate through the text.

// =section:"Installation"
// =text
The installation process is really simple:

// =code:bash
composer require --dev bound1ess/essence

// =text
Congrats, you're all set to go!

// =section:"Usage"
// =text
The simplest example:

// =code:php
expect("foobar")->to_have_length_of(6)->validate();

// =text
Thanks for your attention!
```

### YAML configuration

```yaml
main:
    packagist: "https://packagist.org/packages/bound1ess/essence"
    github: "https://github.com/bound1ess/essence"
    docs: "@docs"

docs:
    from: "docs.cligen"
    to: "docs.html"
```

## Rake

```shell
rake # => rake test
rake test server
rake build install-gem
rake install builds-dir
```
