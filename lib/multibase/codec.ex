defmodule Multibase.Codec do
  @moduledoc """
  A behaviour defining the contract for base encoding modules.

  The built-in base encoding modules (Base16, Base32, Base58, etc.) implement
  this behaviour. External libraries providing additional base encodings should
  also implement it for consistency.

  ## Example

      defmodule MyApp.Base45 do
        @behaviour Multibase.Codec

        @impl true
        def encode(data, _opts) do
          # ... your base45 encoding logic ...
        end

        @impl true
        def decode(data, _opts) do
          {:ok, decode!(data, [])}
        rescue
          e -> {:error, e}
        end

        @impl true
        def decode!(data, _opts) do
          # ... your base45 decoding logic ...
        end
      end
  """

  @doc """
  Encodes raw binary data into a base-encoded string.

  The second argument is a keyword list of options. When called via the
  registry, this will be an empty list `[]`.
  """
  @callback encode(data :: binary(), opts :: keyword()) :: binary()

  @doc """
  Decodes a base-encoded string back to raw binary.

  Returns `{:ok, binary()}` on success or `{:error, reason}` on failure.
  The second argument is a keyword list of options.
  """
  @callback decode(data :: binary(), opts :: keyword()) :: {:ok, binary()} | {:error, any()}

  @doc """
  Decodes a base-encoded string back to raw binary.

  Raises on invalid input. The second argument is a keyword list of options.
  When called via the registry, this will be an empty list `[]`.
  """
  @callback decode!(data :: binary(), opts :: keyword()) :: binary()
end
