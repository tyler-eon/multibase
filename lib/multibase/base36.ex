defmodule Multibase.Base36 do
  use Multibase.AnyBase,
    name: :base36,
    alphabet: "0123456789abcdefghijklmnopqrstuvwxyz"

  @behaviour Multibase.Codec
end
