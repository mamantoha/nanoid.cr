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
Crystal 1.0.0-dev [eb4609744] (2020-07-21)

LLVM: 8.0.0
Default target: x86_64-unknown-linux-gnu

    Nanoid.simple_generate(21) 483.93m (  2.07s ) (± 0.41%)  244MB/op   5.28× slower
   Nanoid.complex_generate(21) 329.91m (  3.03s ) (± 1.38%)  259MB/op   7.74× slower
Nanoid.non_secure_generate(21)   2.55  (391.51ms) (± 1.09%)  214MB/op        fastest
                       UUID v4 545.67m (  1.83s ) (± 0.91%)   0.0B/op   4.68× slower
    Nanoid.simple_generate(16) 483.35m (  2.07s ) (± 0.57%)  229MB/op   6.48× slower
   Nanoid.complex_generate(16) 357.36m (  2.80s ) (± 0.70%)  241MB/op   8.76× slower
Nanoid.non_secure_generate(16)   3.13  (319.43ms) (± 1.85%)  198MB/op        fastest
                          UUID 546.95m (  1.83s ) (± 0.62%)   0.0B/op   5.72× slower
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

Copyright: 2018-2020 Anton Maminov (anton.maminov@gmail.com)

This library is distributed under the MIT license. Please see the LICENSE file.
