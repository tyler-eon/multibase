defmodule Multibase.Base58 do
  use Multibase.AnyBase,
    name: :base58,
    alphabet: "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"

  @behaviour Multibase.Codec
end

defmodule Multibase.Base58Flickr do
  use Multibase.AnyBase,
    name: :base58flickr,
    alphabet: "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"

  @behaviour Multibase.Codec
end

defmodule Multibase.Base58Ripple do
  use Multibase.AnyBase,
    name: :base58ripple,
    alphabet: "rpshnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCg65jkm8oFqi1tuvAxyz"

  @behaviour Multibase.Codec
end
