defmodule Eggman.MixProject do
  use Mix.Project

  def project do
    [
      app: :eggman,
      version: "0.0.1.dev",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Eggman, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_aws, "~> 2.1"},
      {:ex_aws_cloudformation, "~> 2.0"},
      {:ex_aws_lambda, "~> 2.0"},
      {:ex_aws_s3, "~> 2.0"},
      {:poison, "~> 5.0"},
      {:hackney, "~> 1.9"},
      {:sweet_xml, "~> 0.6"},
    ]
  end
end
