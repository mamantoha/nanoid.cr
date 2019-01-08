# nanoid.cr

[![Build Status](http://img.shields.io/travis/mamantoha/nanoid.cr.svg?style=flat)](https://travis-ci.org/mamantoha/nanoid.cr)
[![GitHub release](https://img.shields.io/github/release/mamantoha/nanoid.cr.svg)](https://github.com/mamantoha/nanoid.cr/releases)
[![License](https://img.shields.io/github/license/mamantoha/nanoid.cr.svg)](https://github.com/mamantoha/nanoid.cr/blob/master/LICENSE)

Crystal implementation of original [NanoID](https://github.com/ai/nanoid)

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
    Nanoid.simple_generate(21)   0.59  (  1.68s ) (± 1.13%)  257117984 B/op   4.25× slower
   Nanoid.complex_generate(21)   0.42  (  2.36s ) (± 0.23%)  271714640 B/op   5.97× slower
Nanoid.non_secure_generate(21)   2.53  (395.98ms) (± 1.25%)  224421143 B/op        fastest
                       UUID v4   0.87  (  1.14s ) (± 0.18%)          0 B/op   2.89× slower
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
