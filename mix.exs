defmodule Alfred.Mixfile do
  use Mix.Project

  def project do
    [app: :alfred,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [ applications: [
        :logger,
        :exml, :romeo, :hedwig, :hedwig_hipchat,
        :conform, :exrm, :conform_exrm,
      ],
      mod: {Alfred, []}
    ]
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
      {:exml, github: "paulgray/exml", override: true},
      {:hedwig_hipchat, "~> 0.9"},
      {:romeo, "~> 0.4.0", override: true},
      {:conform, github: "bitwalker/conform", override: true},
      {:exrm, "~> 1.0"},
      {:conform_exrm, "~> 1.0"},
    ]
  end
end
