defmodule Rivet.Data.Adi.MixProject do
  use Mix.Project

  def project do
    [
      app: :rivet_data_auth,
      version: "2.0.0",
      package: package(),
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test
      ],
      deps: deps(),
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore.exs",
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      # lockfile: "../../mix.lock",
      aliases: aliases()
      # xref: [exclude: [AuthX.ApiKey, AuthX.Settings, AuthX.Token.Requests]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :postgrex, :ecto, :timex, {:ex_unit, :optional}]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "core.seeds"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"],
      # "ecto.seeds": ["core.seeds"],
      c: ["compile"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rivet, "~> 1.0.0", git: "git@github.com:srevenant/rivet", branch: "master"},
      {:rivet_utils, "~> 1.0.0", git: "git@github.com:srevenant/rivet-utils", branch: "master"},
      {:ecto_sql, "~> 3.7"},
      {:ecto_enum, "~> 1.0"},
      {:excoveralls, "~> 0.14", only: :test},
      {:ex_machina, "~> 2.7.0", only: :test},
      # {:ex_doc, "~> 0.18", only: :dev, runtime: false},
      {:faker, "~> 0.10"},
      {:postgrex, "~> 0.13"},
      {:yaml_elixir, "~> 2.8.0"},
      {:jason, "~> 1.0"},
      {:mix_test_watch, "~> 0.8", only: [:test, :dev], runtime: false},
      {:timex, "~> 3.6"},
      {:lazy_cache, "~> 0.1.0"},
      {:typed_ecto_schema, "~> 0.3.0 or ~> 0.4.1"},
      {:junit_formatter, "~> 3.1", only: [:test]}
      # {:random_password, "~> 1.1"}
    ]
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      licenses: ["AGPL-3.0-or-later"],
      links: %{"GitHub" => "https://github.com/srevenant/atom-data-auth"},
      source_url: "https://github.com/srevenant/atom-data-auth"
    ]
  end
end
