defmodule ExCron.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :ex_cron,
      version: @version,
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      description: "Cron schedule generator for Elixir.",
      docs: [
        main: "ExCron",
        source_ref: "v#{@version}",
        source_url: "https://github.com/codestuffers/ex-cron"
      ],
      elixir: ">= 1.2.0",
      name: "ExCron",
      package: package,
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:credo,       "~> 0.5",  only: [:dev, :test]},
      {:earmark,     "~> 1.0",  only: [:dev, :docs]},
      {:ex_doc,      "~> 0.14", only: [:dev, :docs]},
      {:inch_ex,     "~> 0.5",  only: [:dev, :docs]}
    ]
  end

  defp package do
    %{
      maintainers: [
        "Andrew Benz"
      ],
      licenses: ["MIT License"],
      links: %{
        "GitHub" => "https://github.com/codestuffers/ex-cron"
      }
    }
  end
end
