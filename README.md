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
Crystal 1.10.0 (2023-10-09)

LLVM: 15.0.7
Default target: aarch64-apple-darwin23.0.0

    Nanoid.simple_generate(21)   3.93  (254.56ms) (± 0.67%)  76.4MB/op   3.38× slower
   Nanoid.complex_generate(21)   3.35  (298.92ms) (± 0.93%)  91.7MB/op   3.97× slower
Nanoid.non_secure_generate(21)  13.27  ( 75.37ms) (± 7.77%)  45.9MB/op        fastest
                       UUID v4   3.74  (267.40ms) (± 1.04%)   168MB/op   3.55× slower
    Nanoid.simple_generate(36)   3.48  (286.96ms) (± 0.70%)   107MB/op   2.32× slower
   Nanoid.complex_generate(36)   2.95  (339.27ms) (± 0.61%)   122MB/op   2.75× slower
Nanoid.non_secure_generate(36)   8.10  (123.45ms) (± 1.24%)  61.1MB/op        fastest
                       UUID v4   3.75  (266.92ms) (± 1.30%)   168MB/op   2.16× slower
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

Copyright: 2018-2023 Anton Maminov (anton.maminov@gmail.com)

This library is distributed under the MIT license. Please see the LICENSE file.
