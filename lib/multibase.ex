defmodule Multibase do
  @moduledoc """
  Multibase is a protocol for disambiguating the "base encoding" used to express binary data in text formats, as specified by [multiformats](https://github.com/multiformats/multibase).

  *Note*: Not all "official" multibase encodings are implemented here. Only those marked as "final" are guaranteed to be present.

  ## Adding encodings

  To add a new base encoding, define a module implementing the `Multibase.Codec`
  behaviour and add the corresponding `encode/2` and `decode!/1` function heads
  to this module.
  """

  alias Multibase.{Base16, Base32, Base36, Base58, Base64}

  @doc """
  Encodes binary data using a supported multibase encoding.

  The encoding is specified as an atom. The encoded string is prefixed with a
  single character identifying the encoding, per the multibase spec.

  ## Supported encodings

    * `:base16` / `:base16upper` — hexadecimal (lowercase / uppercase)
    * `:base32` / `:base32upper` — RFC 4648 base32 without padding
    * `:base32pad` / `:base32padupper` — RFC 4648 base32 with padding
    * `:base36` — base36 (lowercase)
    * `:base58btc` / `:base58flickr` — base58 (Bitcoin / Flickr alphabet)
    * `:base64` / `:base64pad` — standard base64 without/with padding
    * `:base64url` / `:base64urlpad` — URL-safe base64 without/with padding
  """
  @spec encode(binary(), atom()) :: binary()
  def encode(data, :base16), do: "f" <> Base16.encode(data, case: :lower)
  def encode(data, :base16upper), do: "F" <> Base16.encode(data, case: :upper)
  def encode(data, :base32), do: "b" <> Base32.encode(data, case: :lower, padding: false)
  def encode(data, :base32upper), do: "B" <> Base32.encode(data, case: :upper, padding: false)
  def encode(data, :base32pad), do: "c" <> Base32.encode(data, case: :lower, padding: true)
  def encode(data, :base32padupper), do: "C" <> Base32.encode(data, case: :upper, padding: true)
  def encode(data, :base36), do: "k" <> Base36.encode(data)
  def encode(data, :base58btc), do: "z" <> Base58.encode(data)
  def encode(data, :base58flickr), do: "Z" <> Base58.encode(data)
  def encode(data, :base64), do: "m" <> Base64.encode(data, padding: false)
  def encode(data, :base64pad), do: "M" <> Base64.encode(data, padding: true)
  def encode(data, :base64url), do: "u" <> Base64.encode(data, padding: false)
  def encode(data, :base64urlpad), do: "U" <> Base64.encode(data, padding: true)

  @doc """
  Attempts to decode a multibase-encoded binary string.

  Returns `{:ok, decoded_binary}` on success or `{:error, reason}` on failure.
  """
  @spec decode(binary()) :: {:ok, binary()} | {:error, any()}
  def decode(data) do
    {:ok, decode!(data)}
  rescue
    error ->
      {:error, error}
  end

  @doc """
  Decodes a multibase-encoded string. Returns the decoded binary data directly.

  Raises on invalid input.
  """
  @spec decode!(binary()) :: binary()
  def decode!("f" <> data), do: Base16.decode!(data, case: :lower)
  def decode!("F" <> data), do: Base16.decode!(data, case: :upper)
  def decode!("b" <> data), do: Base32.decode!(data, case: :lower, padding: false)
  def decode!("B" <> data), do: Base32.decode!(data, case: :upper, padding: false)
  def decode!("c" <> data), do: Base32.decode!(data, case: :lower, padding: true)
  def decode!("C" <> data), do: Base32.decode!(data, case: :upper, padding: true)
  def decode!("k" <> data), do: Base36.decode!(data)
  def decode!("z" <> data), do: Base58.decode!(data)
  def decode!("Z" <> data), do: Base58.decode!(data)
  def decode!("m" <> data), do: Base64.decode!(data, padding: false)
  def decode!("M" <> data), do: Base64.decode!(data, padding: true)
  def decode!("u" <> data), do: Base64.decode!(data, padding: false)
  def decode!("U" <> data), do: Base64.decode!(data, padding: true)
end
