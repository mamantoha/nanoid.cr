# nanoid.cr

[![Crystal CI](https://github.com/mamantoha/nanoid.cr/actions/workflows/crystal.yml/badge.svg)](https://github.com/mamantoha/nanoid.cr/actions/workflows/crystal.yml)
[![GitHub release](https://img.shields.io/github/release/mamantoha/nanoid.cr.svg)](https://github.com/mamantoha/nanoid.cr/releases)
[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://mamantoha.github.io/nanoid.cr/)
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

`crystal run --release ./bench/benchmark.cr`

```console
Crystal 1.20.2 (2026-05-15)

LLVM: 22.1.6
Default target: aarch64-apple-darwin25.5.0

    Nanoid.simple_generate(21)   4.02  (248.69ms) (± 0.48%)  76.3MB/op   2.40× slower
   Nanoid.complex_generate(21)   3.27  (306.11ms) (± 2.61%)  91.6MB/op   2.96× slower
Nanoid.non_secure_generate(21)   9.65  (103.58ms) (± 1.75%)  45.8MB/op        fastest
                       UUID v4   3.87  (258.20ms) (± 1.28%)   168MB/op   2.49× slower
    Nanoid.simple_generate(36)   4.05  (246.65ms) (± 2.05%)   107MB/op   1.62× slower
   Nanoid.complex_generate(36)   3.06  (326.75ms) (± 0.98%)   122MB/op   2.14× slower
Nanoid.non_secure_generate(36)   6.55  (152.59ms) (± 1.58%)  61.0MB/op        fastest
                       UUID v4   3.82  (261.80ms) (± 1.85%)   168MB/op   1.72× slower
```

## Development

Clone this repository and install dependencies:

```console
shards install
```

Run tests:

```console
crystal spec
```

## Contributing

1. Fork it (<https://github.com/mamantoha/nanoid.cr/fork>)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [mamantoha](https://github.com/mamantoha) Anton Maminov - creator, maintainer

## License

Copyright: 2018-2026 Anton Maminov (anton.maminov@gmail.com)

This library is distributed under the MIT license. Please see the LICENSE file.
