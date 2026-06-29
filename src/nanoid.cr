module Nanoid
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

  URL_ALPHABET = "_-0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  def self.generate(size = 21, alphabet = URL_ALPHABET, secure = true) : String
    validate_size(size)
    validate_alphabet(alphabet)

    return non_secure_generate(size, alphabet) unless secure

    return simple_generate(size) if alphabet == URL_ALPHABET

    complex_generate(size: size, alphabet: alphabet)
  end

  def self.simple_generate(size : Int32) : String
    bytes = random_bytes(size)

    String.new(size) do |buffer|
      size.times do |i|
        # It is incorrect to use bytes exceeding the alphabet size.
        # The following mask reduces the random byte in the 0-255 value
        # range to the 0-63 value range. Therefore, adding hacks, such
        # as empty string fallback or magic numbers, is unneccessary because
        # the bitmask trims bytes down to the alphabet size.
        buffer[i] = URL_ALPHABET.byte_at(bytes[i] & 63)
      end

      {size, size}
    end
  end

  # Non-secure predictable random generator
  def self.non_secure_generate(size : Int32, alphabet : String) : String
    alphabet_size = alphabet.size
    return ascii_non_secure_generate(size: size, alphabet: alphabet) if alphabet.ascii_only?

    String.build do |str|
      size.times do
        str << alphabet[Random.rand(alphabet_size)]
      end
    end
  end

  # Generate secure URL-friendly unique ID
  def self.complex_generate(size : Int32, alphabet : String) : String
    alphabet_size = alphabet.size
    return alphabet * size if alphabet_size == 1
    return ascii_complex_generate(size: size, alphabet: alphabet) if alphabet.ascii_only?

    # First, a bitmask is necessary to generate the ID. The bitmask makes bytes
    # values closer to the alphabet size. The bitmask calculates the closest
    # `2^31 - 1` number, which exceeds the alphabet size.
    # For example, the bitmask for the alphabet size 30 is 31 (00011111).
    mask = (2 << Math.log2(alphabet_size - 1).to_i) - 1
    # Though, the bitmask solution is not perfect since the bytes exceeding
    # the alphabet size are refused. Therefore, to reliably generate the ID,
    # the random bytes redundancy has to be satisfied.

    # Next, a step determines how many random bytes to generate.
    # The number of random bytes gets decided upon the ID size, mask,
    # alphabet size, and magic number 1.6 (using 1.6 peaks at performance
    # according to benchmarks).
    step = ((1.6 * mask * size) / alphabet_size).ceil.to_i

    total = 0

    String.build do |str|
      while total < size
        bytes = random_bytes(step)

        step.times do |i|
          char = alphabet[bytes[i] & mask]?

          next unless char

          str << char

          break if (total += 1) == size
        end
      end
    end
  end

  # Generates random numbers from a secure source provided by the system
  private def self.random_bytes(size) : Slice(UInt8)
    Random::Secure.random_bytes(size)
  end

  private def self.ascii_non_secure_generate(size : Int32, alphabet : String) : String
    alphabet_size = alphabet.bytesize

    String.new(size) do |buffer|
      size.times do |i|
        buffer[i] = alphabet.byte_at(Random.rand(alphabet_size))
      end

      {size, size}
    end
  end

  private def self.ascii_complex_generate(size : Int32, alphabet : String) : String
    alphabet_size = alphabet.bytesize

    mask = (2 << Math.log2(alphabet_size - 1).to_i) - 1
    step = ((1.6 * mask * size) / alphabet_size).ceil.to_i
    total = 0

    String.new(size) do |buffer|
      while total < size
        bytes = random_bytes(step)

        step.times do |i|
          index = bytes[i] & mask

          next if index >= alphabet_size

          buffer[total] = alphabet.byte_at(index)

          break if (total += 1) == size
        end
      end

      {size, size}
    end
  end

  private def self.validate_size(size : Int) : Nil
    if size < 0
      raise ArgumentError.new("Size must be non-negative")
    end
  end

  private def self.validate_alphabet(alphabet : String) : Nil
    unless 1 <= alphabet.size <= 256
      raise ArgumentError.new("Alphabet must contain between 1 and 256 symbols")
    end
  end
end
