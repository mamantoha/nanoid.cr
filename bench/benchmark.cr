require "benchmark"
require "../src/nanoid"
require "uuid"

n = 1_000_000
alphabet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

Benchmark.ips do |x|
  x.report("Nanoid.simple_generate(21)") do
    n.times do
      Nanoid.generate
    end
  end

  x.report("Nanoid.complex_generate(21)") do
    n.times do
      Nanoid.generate(size: 21, alphabet: alphabet)
    end
  end

  x.report("Nanoid.non_secure_generate(21)") do
    n.times do
      Nanoid.generate(size: 21, alphabet: alphabet, secure: false)
    end
  end

  x.report("UUID v4") do
    n.times do
      UUID.random
    end
  end
end

Benchmark.ips do |x|
  x.report("Nanoid.simple_generate(16)") do
    n.times do
      Nanoid.generate(size: 16)
    end
  end

  x.report("Nanoid.complex_generate(16)") do
    n.times do
      Nanoid.generate(size: 16, alphabet: alphabet)
    end
  end

  x.report("Nanoid.non_secure_generate(16)") do
    n.times do
      Nanoid.generate(size: 16, alphabet: alphabet, secure: false)
    end
  end

  x.report("UUID") do
    n.times do
      UUID.random
    end
  end
end
