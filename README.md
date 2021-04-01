# nanoid.cr

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/3108082114df406abb95c38bf751c2f0)](https://app.codacy.com/app/mamantoha/nanoid.cr?utm_source=github.com&utm_medium=referral&utm_content=mamantoha/nanoid.cr&utm_campaign=Badge_Grade_Settings)
![Crystal CI](https://github.com/mamantoha/nanoid.cr/workflows/Crystal%20CI/badge.svg?branch=master)
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

`crystal run --release bench/benchmark.cr`

```console
Crystal 1.1.0-dev [e7b46c407] (2021-03-30)

LLVM: 10.0.0
Default target: x86_64-unknown-linux-gnu

    Nanoid.simple_generate(21)   2.01  (498.25ms) (± 5.03%)  76.3MB/op   3.11× slower
   Nanoid.complex_generate(21)   1.02  (983.07ms) (±11.12%)  91.6MB/op   6.13× slower
Nanoid.non_secure_generate(21)   6.24  (160.31ms) (± 5.53%)  45.8MB/op        fastest
                       UUID v4   2.17  (459.78ms) (±22.74%)    0.0B/op   2.87× slower
    Nanoid.simple_generate(16)   1.50  (665.50ms) (±29.37%)  61.3MB/op   5.62× slower
   Nanoid.complex_generate(16)   1.53  (652.78ms) (±14.02%)  61.1MB/op   5.51× slower
Nanoid.non_secure_generate(16)   8.44  (118.41ms) (± 4.69%)  30.5MB/op        fastest
                          UUID   1.77  (566.09ms) (±41.97%)    0.0B/op   4.78× slower
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

Copyright: 2018-2021 Anton Maminov (anton.maminov@gmail.com)

This library is distributed under the MIT license. Please see the LICENSE file.
