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
```

`Nanoid.generate` uses URL-friendly symbols (`A-Za-z0-9_-`) and returns an ID with 21 characters.

```crystal
Nanoid.generate
# => 3gFI8yZxcfXsXGhB0036l
```

If you want to reduce ID length (and increase collisions probability), you can pass the length as an argument.

```crystal
Nanoid.generate(size: 8, alphabet: "1234567890abcdef")
# => 86984b57
```

Non-secure API is also available.

```crystal
Nanoid.generate(secure: false)
# => no0MmiInNcBm9jR2_3sGt

Nanoid.generate(size: 10, alphabet: "1234567890abcdef", secure: false)
# => 2793b2351c
```

## Benchmark

```console
    Nanoid.simple_generate(21)   0.54  (  1.84s ) (±16.55%)  256191264 B/op   2.11× slower
   Nanoid.complex_generate(21)   0.41  (  2.44s ) (± 9.10%)  271892005 B/op   2.80× slower
Nanoid.non_secure_generate(21)   1.15  (869.66ms) (±27.32%)  224164459 B/op        fastest
                       UUID v4   0.87  (  1.15s ) (±19.43%)          0 B/op   1.32× slower
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
