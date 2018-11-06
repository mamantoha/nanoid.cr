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

    String::Builder.build do |io|
      size.times do |i|
        io << SAFE_ALPHABET[bytes[i] & 63]
      end
    end.to_s
  end

  # Non-secure predictable random generator
  private def self.non_secure_generate(size : Int32, alphabet : String) : String
    alphabet_size = alphabet.size
    String::Builder.build do |io|
      while 0 <= (size -= 1)
        io << alphabet[Random.rand(alphabet_size)]
      end
    end.to_s
  end

  # Generate secure URL-friendly unique ID
  private def self.complex_generate(size : Int32, alphabet : String) : String
    alphabet_size = alphabet.size
    mask = (2 << (Math.log(alphabet_size - 1) / Math.log(2)).to_i) - 1
    step = (1.6 * mask * size / alphabet_size).ceil.to_i

    io = String::Builder.new
    total = 0

    loop do
      break if total >= size

      bytes = random_bytes(size)
      step.times do |i|
        byte = bytes[i]? ? (bytes[i] & mask) : false

        next unless byte.is_a?(Int)
        char = byte && alphabet[byte]?
        next unless char

        io << char
        total += 1
        break if total >= size
      end
    end

    io.to_s
  end

  # Generates random numbers from a secure source provided by the system
  private def self.random_bytes(size) : Slice(UInt8)
    Random::Secure.random_bytes(size)
  end
end
