# Multibase

An Elixir implementation of the [multibase](https://github.com/multiformats/multibase) specification — a self-describing base encoding protocol.

Multibase prefixes a single character to encoded data so that the base encoding used can be unambiguously identified when decoding. This library handles the prefixing, encoding, and decoding steps for a set of commonly used base encodings.

## Supported Encodings

| Encoding | Prefix | Atom |
|----------|--------|------|
| Base16 (lowercase) | `f` | `:base16` |
| Base16 (uppercase) | `F` | `:base16upper` |
| Base32 (lowercase, no pad) | `b` | `:base32` |
| Base32 (uppercase, no pad) | `B` | `:base32upper` |
| Base32 (lowercase, padded) | `c` | `:base32pad` |
| Base32 (uppercase, padded) | `C` | `:base32padupper` |
| Base36 (lowercase) | `k` | `:base36` |
| Base58 BTC | `z` | `:base58btc` |
| Base58 Flickr | `Z` | `:base58flickr` |
| Base64 (no pad) | `m` | `:base64` |
| Base64 (padded) | `M` | `:base64pad` |
| Base64 URL-safe (no pad) | `u` | `:base64url` |
| Base64 URL-safe (padded) | `U` | `:base64urlpad` |

## Usage

### Encoding

```elixir
Multibase.encode("hello world", :base32)
# => "bnbswy3dpeb3w64tmmq"

Multibase.encode("hello world", :base58btc)
# => "zStV1DL6CwTryKyV"
```

### Decoding

Decoding automatically detects the encoding from the prefix character:

```elixir
Multibase.decode!("bnbswy3dpeb3w64tmmq")
# => "hello world"

Multibase.decode("zStV1DL6CwTryKyV")
# => {:ok, "hello world"}
```

### Using individual codecs directly

Each base encoding is also available as its own module if you want to encode or decode without the multibase prefix:

```elixir
Multibase.Base58.encode("hello world")
# => "StV1DL6CwTryKyV"

Multibase.Base58.decode!("StV1DL6CwTryKyV")
# => "hello world"
```

## Custom base encodings

The `Multibase.Codec` behaviour defines the contract that all base encoding modules implement. If you are building a custom base encoding, implementing this behaviour ensures your module follows the same interface as the built-in ones:

```elixir
defmodule MyApp.Base45 do
  @behaviour Multibase.Codec

  @impl true
  def encode(data, _opts), do: # ...

  @impl true
  def decode(data, _opts), do: # ...

  @impl true
  def decode!(data, _opts), do: # ...
end
```

The `Multibase.AnyBase` module can also be used to generate a base encoding module from a custom alphabet at compile time. See its documentation for details.

## Part of the multiformats ecosystem

This library is one component of a family of Elixir multiformats libraries. For runtime codec registration and cross-component composition, see the [multicodec](https://github.com/tyler-eon/multicodec) project.
