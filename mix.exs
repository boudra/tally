defmodule Tally.Mixfile do
  use Mix.Project

  def project do
    [app: :tally,
     version: "0.0.1",
     elixir: "~> 1.2",
     description: description,
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end

  defp description do
    """
    A reporting library for Elixir
    """
  end

  defp package do
    [
      name: :tally,
      files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      maintainers: ["Mohamed Boudra"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/boudra/tally"}
    ]
  end
end
