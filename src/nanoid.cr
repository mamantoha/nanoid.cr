require "./ext/math"
require "./nanoid/**"

module Nanoid
  SAFE_ALPHABET = "_-0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  def self.generate(size = 21, alphabet = SAFE_ALPHABET, secure = true) : String
    return non_secure_generate(size, alphabet) unless secure

    return simple_generate(size) if alphabet == SAFE_ALPHABET

    complex_generate(size: size, alphabet: alphabet)
  end

  private def self.simple_generate(size : Int32) : String
    bytes = random_bytes(size)

    String.new(size) do |buffer|
      size.times do |i|
        buffer[i] = SAFE_ALPHABET[bytes[i] & 63].ord.to_u8
      end

      {size, size}
    end
  end

  # Non-secure predictable random generator
  private def self.non_secure_generate(size : Int32, alphabet : String) : String
    String.new(size) do |buffer|
      alphabet_size = alphabet.size

      size.times do |i|
        buffer[i] = alphabet[Random.rand(alphabet_size)].ord.to_u8
      end

      {size, size}
    end
  end

  # Generate secure URL-friendly unique ID
  private def self.complex_generate(size : Int32, alphabet : String) : String
    alphabet_size = alphabet.size

    # We can’t use bytes bigger than the alphabet. To make bytes values closer
    # to the alphabet, we apply bitmask on them. We look for the closest
    # `2 ** x - 1` number, which will be bigger than alphabet size. If we have
    # 30 symbols in the alphabet, we will take 31 (00011111).
    mask = (2 << 31 - Math.clz32((alphabet.size - 1) | 1)) - 1

    step = (1.6 * mask * size / alphabet_size).ceil.to_i

    total = 0

    String.new(size) do |buffer|
      run = true

      while total < size
        bytes = random_bytes(size)

        step.times do |i|
          byte = bytes[i]? ? (bytes[i] & mask) : nil

          next unless byte

          char = alphabet[byte]?

          next unless char

          buffer[total] = char.ord.to_u8

          break if (total += 1) == size
        end
      end

      {size, size}
    end
  end

  # Generates random numbers from a secure source provided by the system
  private def self.random_bytes(size) : Slice(UInt8)
    Random::Secure.random_bytes(size)
  end
end
