module Nanoid
  SAFE_ALPHABET = "_~0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  def self.generate(size = 21, alphabet = SAFE_ALPHABET) : String
    return simple_generate(size) if alphabet == SAFE_ALPHABET

    complex_generate(size: size, alphabet: alphabet)
  end

  private def self.simple_generate(size : Int32) : String
    bytes = random_bytes(size)

    (0...size).reduce("") do |acc, i|
      acc + SAFE_ALPHABET[bytes[i] & 63]
    end
  end

  private def self.complex_generate(size : Int32, alphabet : String) : String
    alphabet_size = alphabet.size
    mask = (2 << (Math.log(alphabet_size - 1) / Math.log(2)).to_i) - 1
    step = (1.6 * mask * size / alphabet_size).ceil.to_i

    result = ""

    loop do
      break if result.size == size

      bytes = random_bytes(size)
      (0...step).each do |i|
        byte = bytes[i]? ? (bytes[i] & mask) : false

        next unless byte.is_a?(Int)
        char = byte && alphabet[byte]?
        next unless char

        result = "#{result}#{char}"
        break if result.size == size
      end
    end

    return result
  end

  private def self.random_bytes(size)
    Random::Secure.random_bytes(size).map(&.to_i).to_a
  end
end
