defmodule Multibase.MixProject do
  use Mix.Project

  def project do
    [
      app: :multibase,
      version: "0.1.0",
      elixir: "~> 1.18",
      description: "An Elixir implementation of the multibase specification for self-describing base encodings.",
      package: package(),
      deps: deps()
    ]
  end

  def package do
    [
      name: "multibase",
      maintainers: ["Tyler Eon"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/tyler-eon/multibase"
      }
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
