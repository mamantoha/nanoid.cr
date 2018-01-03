require "./spec_helper"

describe Nanoid do
  it "has correct size" do
    count = 100

    count.times do
      id = Nanoid.generate

      (id.size).should eq(21)
    end
  end

  it "generates URL-friendly IDs" do
    count = 100

    count.times do
      id = Nanoid.generate

      (0...id.size).each do |j|
        (Nanoid::SAFE_ALPHABET.index(id[j])).should_not be_nil
      end
    end
  end

  it "has no collisions for million entries as 21 characters length" do
    count = 100_000
    generated = {} of String => Bool

    count.times do
      id = Nanoid.generate
      (id.size).should eq(21)

      (generated.has_key?(id)).should be_false
      generated[id] = true
    end
  end

  it "has no collisions for milion entries with 9 characters and base alphabet" do
    count = 100_000
    generated = {} of String => Bool

    count.times do
      id = Nanoid.generate(size: 9, alphabet: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
      (id.size).should eq(9)

      (generated.has_key?(id)).should be_false
      generated[id] = true
    end
  end

  it "generates with custom settings" do
    Nanoid.generate(size: 12, alphabet: "1234567890abcdef")
  end
end
