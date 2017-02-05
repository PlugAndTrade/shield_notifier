defmodule Shield.Notifier.Mixfile do
  use Mix.Project

  def project do
    [app: :shield_notifier,
     version: "0.2.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:logger, :bamboo],
     mod: {Shield.Notifier, []}]
  end

  defp deps do
    [{:bamboo, "~> 0.7 or ~> 0.8"},
     {:credo, "~> 0.6.1", only: [:dev, :test]},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp description do
    """
    Shield.Notifier is an external package for Shield package notifications.
    """
  end

  defp package do
    [name: :shield_notifier,
     files: ["lib", "mix.exs", "README.md"],
     maintainers: ["Mustafa Turan"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/mustafaturan/shield_notifier"}]
  end
end
