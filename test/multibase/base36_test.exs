defmodule Multibase.Base36Test do
  use ExUnit.Case

  alias Multibase.Base36

  describe "roundtrip" do
    test "encodes and decodes a simple string" do
      data = "hello"
      assert data == data |> Base36.encode() |> Base36.decode!()
    end

    test "encodes and decodes binary data" do
      data = :crypto.strong_rand_bytes(32)
      assert data == data |> Base36.encode() |> Base36.decode!()
    end

    test "preserves leading zero bytes" do
      data = <<0, 0, 1, 2, 3>>
      assert data == data |> Base36.encode() |> Base36.decode!()
    end
  end
end
