defmodule Multibase.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/tyler-eon/multibase"

  def project do
    [
      app: :multibase,
      version: @version,
      elixir: "~> 1.18",
      description: "An Elixir implementation of the multibase specification for self-describing base encodings.",
      package: package(),
      deps: deps(),
      docs: docs(),
      source_url: @source_url
    ]
  end

  def package do
    [
      name: "multibase_ex",
      maintainers: ["Tyler Eon"],
      licenses: ["MPL-2.0"],
      links: %{
        "GitHub" => @source_url
      },
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE)
    ]
  end

  defp docs do
    [
      main: "readme",
      name: "Multibase",
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md", "LICENSE"]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
