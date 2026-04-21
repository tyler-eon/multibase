defmodule MultibaseTest do
  use ExUnit.Case

  @test_data "hello world"

  describe "encode/2 and decode!/1 roundtrip" do
    for encoding <- [
      :base16, :base16upper,
      :base32, :base32upper, :base32pad, :base32padupper,
      :base36,
      :base58btc, :base58flickr,
      :base64, :base64pad, :base64url, :base64urlpad
    ] do
      test "roundtrip with #{encoding}" do
        encoded = Multibase.encode(@test_data, unquote(encoding))
        assert is_binary(encoded)
        assert Multibase.decode!(encoded) == @test_data
      end
    end
  end

  describe "encode/2 prefixes" do
    test "base16 uses 'f' prefix" do
      assert "f" <> _ = Multibase.encode("hi", :base16)
    end

    test "base16upper uses 'F' prefix" do
      assert "F" <> _ = Multibase.encode("hi", :base16upper)
    end

    test "base32 uses 'b' prefix" do
      assert "b" <> _ = Multibase.encode("hi", :base32)
    end

    test "base32upper uses 'B' prefix" do
      assert "B" <> _ = Multibase.encode("hi", :base32upper)
    end

    test "base32pad uses 'c' prefix" do
      assert "c" <> _ = Multibase.encode("hi", :base32pad)
    end

    test "base32padupper uses 'C' prefix" do
      assert "C" <> _ = Multibase.encode("hi", :base32padupper)
    end

    test "base36 uses 'k' prefix" do
      assert "k" <> _ = Multibase.encode("hi", :base36)
    end

    test "base58btc uses 'z' prefix" do
      assert "z" <> _ = Multibase.encode("hi", :base58btc)
    end

    test "base58flickr uses 'Z' prefix" do
      assert "Z" <> _ = Multibase.encode("hi", :base58flickr)
    end

    test "base64 uses 'm' prefix" do
      assert "m" <> _ = Multibase.encode("hi", :base64)
    end

    test "base64pad uses 'M' prefix" do
      assert "M" <> _ = Multibase.encode("hi", :base64pad)
    end

    test "base64url uses 'u' prefix" do
      assert "u" <> _ = Multibase.encode("hi", :base64url)
    end

    test "base64urlpad uses 'U' prefix" do
      assert "U" <> _ = Multibase.encode("hi", :base64urlpad)
    end
  end

  describe "decode/1" do
    test "returns {:ok, binary} on success" do
      encoded = Multibase.encode("test", :base32)
      assert {:ok, "test"} = Multibase.decode(encoded)
    end

    test "returns {:error, _} on invalid input" do
      assert {:error, _} = Multibase.decode("!")
    end
  end

  describe "encode/2 known values" do
    test "base16 lowercase encoding" do
      assert Multibase.encode("hello", :base16) == "f" <> Base.encode16("hello", case: :lower)
    end

    test "base16 uppercase encoding" do
      assert Multibase.encode("hello", :base16upper) == "F" <> Base.encode16("hello", case: :upper)
    end

    test "base64 encoding without padding" do
      assert Multibase.encode("hello", :base64) == "m" <> Base.encode64("hello", padding: false)
    end

    test "base64pad encoding with padding" do
      assert Multibase.encode("hello", :base64pad) == "M" <> Base.encode64("hello", padding: true)
    end
  end

  describe "binary data with leading zeros" do
    test "base58btc preserves leading zero bytes" do
      data = <<0, 0, 0, 1, 2, 3>>
      encoded = Multibase.encode(data, :base58btc)
      decoded = Multibase.decode!(encoded)
      assert decoded == data
    end

    test "base36 preserves leading zero bytes" do
      data = <<0, 0, 1, 2>>
      encoded = Multibase.encode(data, :base36)
      decoded = Multibase.decode!(encoded)
      assert decoded == data
    end
  end

  describe "empty-ish data" do
    test "single byte encoding roundtrips" do
      for encoding <- [:base16, :base32, :base58btc, :base64] do
        encoded = Multibase.encode(<<42>>, encoding)
        assert Multibase.decode!(encoded) == <<42>>
      end
    end
  end
end
