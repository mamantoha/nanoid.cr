# nanoid.cr

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/3108082114df406abb95c38bf751c2f0)](https://app.codacy.com/app/mamantoha/nanoid.cr?utm_source=github.com&utm_medium=referral&utm_content=mamantoha/nanoid.cr&utm_campaign=Badge_Grade_Settings)
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
Crystal 1.16.2 (2025-04-29)

LLVM: 20.1.4
Default target: aarch64-apple-darwin24.5.0

    Nanoid.simple_generate(21)   3.94  (253.59ms) (± 0.63%)  76.3MB/op   3.51× slower
   Nanoid.complex_generate(21)   3.42  (292.32ms) (± 1.27%)  91.6MB/op   4.05× slower
Nanoid.non_secure_generate(21)  13.85  ( 72.22ms) (± 1.32%)  45.8MB/op        fastest
                       UUID v4   3.87  (258.36ms) (± 0.79%)   168MB/op   3.58× slower
    Nanoid.simple_generate(36)   3.55  (281.52ms) (± 0.58%)   107MB/op   2.28× slower
   Nanoid.complex_generate(36)   3.06  (327.20ms) (± 0.74%)   122MB/op   2.65× slower
Nanoid.non_secure_generate(36)   8.11  (123.26ms) (± 2.13%)  61.0MB/op        fastest
                       UUID v4   3.84  (260.71ms) (± 3.38%)   168MB/op   2.12× slower
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

Copyright: 2018-2025 Anton Maminov (anton.maminov@gmail.com)

This library is distributed under the MIT license. Please see the LICENSE file.
