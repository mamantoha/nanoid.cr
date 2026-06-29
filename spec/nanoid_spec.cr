require "./spec_helper"

describe Nanoid do
  it "should have version" do
    Nanoid::VERSION.should_not be_empty
  end

  context "non-secure fast generator" do
    it "has correct size by default" do
      count = 100

      count.times do
        id = Nanoid.generate(secure: false)

        (id.size).should eq(21)
      end
    end

    it "accepts size and alphabet" do
      count = 100

      count.times do
        id = Nanoid.generate(size: 10, alphabet: "1234567890abcdef", secure: false)

        (id.size).should eq(10)
        id.should_not match(/z/)
      end
    end

    it "generates with non-ascii alphabet" do
      id = Nanoid.generate(size: 12, alphabet: "аб", secure: false)

      (id.size).should eq(12)
      id.each_char do |char|
        "аб".includes?(char).should be_true
      end
    end

    it "rejects empty alphabet" do
      expect_raises(ArgumentError, "Alphabet must contain between 1 and 256 symbols") do
        Nanoid.generate(size: 12, alphabet: "", secure: false)
      end
    end

    it "rejects alphabets with more than 256 symbols" do
      alphabet = (0..256).map(&.chr).join

      expect_raises(ArgumentError, "Alphabet must contain between 1 and 256 symbols") do
        Nanoid.generate(size: 12, alphabet: alphabet, secure: false)
      end
    end
  end

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
        (Nanoid::URL_ALPHABET.index(id[j])).should_not be_nil
      end
    end
  end

  it "has no collisions for million entries as 21 characters length" do
    count = 1_000_000
    generated = {} of String => Bool

    count.times do
      id = Nanoid.generate
      (id.size).should eq(21)

      (generated.has_key?(id)).should be_false
      generated[id] = true
    end
  end

  it "has no collisions for milion entries with 9 characters and base alphabet" do
    count = 1_000_000
    generated = {} of String => Bool

    count.times do
      id = Nanoid.generate(size: 9, alphabet: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
      (id.size).should eq(9)

      (generated.has_key?(id)).should be_false
      generated[id] = true
    end
  end

  it "generates with custom settings" do
    id = Nanoid.generate(size: 12, alphabet: "1234567890abcdef")
    (id.size).should eq(12)
  end

  it "generates with one-character alphabet" do
    id = Nanoid.generate(size: 12, alphabet: "a")
    id.should eq("a" * 12)
  end

  it "generates with non-ascii alphabet" do
    id = Nanoid.generate(size: 12, alphabet: "аб")

    (id.size).should eq(12)
    id.each_char do |char|
      "аб".includes?(char).should be_true
    end
  end

  it "rejects empty alphabet" do
    expect_raises(ArgumentError, "Alphabet must contain between 1 and 256 symbols") do
      Nanoid.generate(size: 12, alphabet: "")
    end
  end

  it "rejects alphabets with more than 256 symbols" do
    alphabet = (0..256).map(&.chr).join

    expect_raises(ArgumentError, "Alphabet must contain between 1 and 256 symbols") do
      Nanoid.generate(size: 12, alphabet: alphabet)
    end
  end
end
