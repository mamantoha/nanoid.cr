require "benchmark"
require "../src/nanoid"
require "uuid"

n = 1_000_000

Benchmark.bm do |x|
  x.report("Nanoid.simple_generate") do
    n.times do
      Nanoid.generate
    end
  end

  x.report("Nanoid.simple_generatei(16)") do
    n.times do
      Nanoid.generate(16)
    end
  end

  x.report("Nanoid.complex_generate(21)") do
    n.times do
      Nanoid.generate(size: 21, alphabet: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    end
  end

  x.report("Nanoid.complex_generate(16)") do
    n.times do
      Nanoid.generate(size: 16, alphabet: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    end
  end

  x.report("UUID") do
    n.times do
      UUID.random
    end
  end
end
