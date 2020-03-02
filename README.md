# nanoid.cr

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/3108082114df406abb95c38bf751c2f0)](https://app.codacy.com/app/mamantoha/nanoid.cr?utm_source=github.com&utm_medium=referral&utm_content=mamantoha/nanoid.cr&utm_campaign=Badge_Grade_Settings)
[![Build Status](https://img.shields.io/travis/mamantoha/nanoid.cr.svg?style=flat)](https://travis-ci.org/mamantoha/nanoid.cr)
![Crystal CI](https://github.com/mamantoha/nanoid.cr/workflows/Crystal%20CI/badge.svg?branch=master)
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

`crystal bench/benchmark.cr --release`

```console
Crystal 0.34.0-dev [c4d70bc4e] (2020-03-01)

LLVM: 8.0.0
Default target: x86_64-unknown-linux-gnu

    Nanoid.simple_generate(21) 596.08m (  1.68s ) (± 9.72%)  244MB/op   2.50× slower
   Nanoid.complex_generate(21) 517.15m (  1.93s ) (± 8.54%)  259MB/op   2.88× slower
Nanoid.non_secure_generate(21)   1.16  (859.21ms) (±22.61%)  214MB/op   1.28× slower
                       UUID v4   1.49  (671.57ms) (± 3.73%)   0.0B/op        fastest
    Nanoid.simple_generate(16) 815.82m (  1.23s ) (±10.06%)  229MB/op   1.85× slower
   Nanoid.complex_generate(16) 612.54m (  1.63s ) (± 8.70%)  241MB/op   2.46× slower
Nanoid.non_secure_generate(16)   1.50  (665.54ms) (±13.96%)  198MB/op   1.00× slower
                          UUID   1.51  (664.34ms) (± 1.81%)   0.0B/op        fastest
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
