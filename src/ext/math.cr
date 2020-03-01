module Math
  extend self

  # Returns the number of leading zero bits in the 32-bit binary representation of a number.
  #
  # `clz32` is short for CountLeadingZeroes32.
  #
  # ```
  # Math.clz32(1)    # => 31
  # Math.clz32(4)    # => 29
  # Math.clz32(1000) # => 22
  # ```
  def clz32(x : Int32) : Int32
    total_bits = 32
    res = 0

    while ((x & (1 << (total_bits - 1))) == 0)
      x = (x << 1)
      res += 1
    end

    res
  end
end
