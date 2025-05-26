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
Crystal 1.17.0-dev [bc46ac244] (2025-05-23)

LLVM: 18.1.8
Default target: x86_64-unknown-linux-gnu

    Nanoid.simple_generate(21)   8.17  (122.47ms) (± 5.45%)  76.3MB/op        fastest
   Nanoid.complex_generate(21)   5.35  (186.76ms) (± 1.85%)  91.6MB/op   1.52× slower
Nanoid.non_secure_generate(21)   6.22  (160.76ms) (± 4.00%)  45.8MB/op   1.31× slower
                       UUID v4   7.45  (134.28ms) (±11.95%)   168MB/op   1.10× slower
    Nanoid.simple_generate(36)   5.39  (185.52ms) (± 3.19%)   107MB/op   1.59× slower
   Nanoid.complex_generate(36)   3.43  (291.62ms) (± 3.02%)   122MB/op   2.50× slower
Nanoid.non_secure_generate(36)   3.93  (254.70ms) (± 2.29%)  61.0MB/op   2.18× slower
                       UUID v4   8.56  (116.80ms) (± 2.34%)   168MB/op        fastest
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
