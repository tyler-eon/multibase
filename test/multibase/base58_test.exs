defmodule Multibase.Base58Test do
  use ExUnit.Case

  alias Multibase.Base58

  describe "encode/1" do
    test "encodes a simple string" do
      assert Base58.encode("hello") == "Cn8eVZg"
    end

    test "encodes binary with leading zero bytes" do
      # Leading zeros should produce leading '1' chars (the zero char in base58btc)
      encoded = Base58.encode(<<0, 0, 0, 1>>)
      assert String.starts_with?(encoded, "111")
    end
  end

  describe "decode!/1" do
    test "decodes a simple string" do
      assert Base58.decode!("Cn8eVZg") == "hello"
    end

    test "roundtrip" do
      data = "The quick brown fox jumps over the lazy dog"
      assert data == data |> Base58.encode() |> Base58.decode!()
    end

    test "roundtrip with binary data" do
      data = :crypto.strong_rand_bytes(32)
      assert data == data |> Base58.encode() |> Base58.decode!()
    end
  end

  describe "decode/1" do
    test "returns {:ok, binary} on success" do
      assert {:ok, "hello"} = Base58.decode("Cn8eVZg")
    end
  end
end
