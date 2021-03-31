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

    String.build(capacity: size) do |io|
      size.times do |i|
        io << SAFE_ALPHABET[bytes[i] & 63]
      end
    end
  end

  # Non-secure predictable random generator
  private def self.non_secure_generate(size : Int32, alphabet : String) : String
    alphabet_size = alphabet.size

    String.build(capacity: size) do |io|
      size.times do
        io << alphabet[Random.rand(alphabet_size)]
      end
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

    String.build(capacity: size) do |io|
      loop do
        bytes = random_bytes(size)

        step.times do |i|
          byte = bytes[i]? ? (bytes[i] & mask) : nil

          next unless byte

          char = byte && alphabet[byte]?
          next unless char

          io << char

          return io.to_s if (total += 1) == size
        end
      end
    end
  end

  # Generates random numbers from a secure source provided by the system
  private def self.random_bytes(size) : Slice(UInt8)
    Random::Secure.random_bytes(size)
  end
end
