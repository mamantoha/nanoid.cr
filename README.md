# nanoid.cr

[![Build Status](http://img.shields.io/travis/mamantoha/nanoid.cr.svg?style=flat)](https://travis-ci.org/mamantoha/nanoid.cr)
[![GitHub release](https://img.shields.io/github/release/mamantoha/nanoid.cr.svg)](https://github.com/mamantoha/nanoid.cr/releases)
[![License](https://img.shields.io/github/license/mamantoha/nanoid.cr.svg)](https://github.com/mamantoha/nanoid.cr/blob/master/LICENSE)

Crystal implementation of original NanoID https://github.com/ai/nanoid

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  nanoid:
    github: mamantoha/nanoid.cr
```

## Usage

```crystal
require "nanoid"

Nanoid.generate
# => 3gFI8yZxcfXsXGhB0036l

Nanoid.generate(size: 8, alphabet: "1234567890abcdef")
# => 86984b57
```

## Development

Clone this repository and install dependencies:

```
shards install
```

Run tests:

```
crystal spec
```

## Contributing

1. Fork it ( https://github.com/mamantoha/nanoid.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [mamantoha](https://github.com/mamantoha) Anton Maminov - creator, maintainer

## License

Copyright: 2018 Anton Maminov (anton.maminov@gmail.com)

This library is distributed under the MIT license. Please see the LICENSE file.
