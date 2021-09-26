defmodule TtcAlerts.MixProject do
  use Mix.Project

  def project do
    [
      app: :ttc_alerts,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      dialyzer: [
        plt_core_path: "priv/plts",
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        plt_add_deps: :app_tree
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {TtcAlerts.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:dev), do: ["lib", "test/support/factories", "test/support/factory.ex"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:bcrypt_elixir, "~> 2.0"},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0", only: [:dev], runtime: false},
      {:ecto_sql, "~> 3.1"},
      {:ecto_psql_extras, "~> 0.2"},
      {:esbuild, "~> 0.2", runtime: Mix.env() == :dev},
      {:ex_machina, "~> 2.3", only: [:dev, :test]},
      {:faker, "~> 0.13", only: [:dev, :test]},
      {:floki, "~> 0.25.0"},
      {:gettext, "~> 0.11"},
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.0"},
      {:mox, "~> 0.5", only: [:dev, :test]},
      {:phoenix, "~> 1.6.0"},
      {:phoenix_ecto, "~> 4.2"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_dashboard, "~> 0.5"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.16.4"},
      {:phoenix_pubsub, "~> 2.0"},
      {:plug_cowboy, "~> 2.1"},
      {:postgrex, ">= 0.0.0"},
      {:telemetry_poller, "~> 0.5"},
      {:telemetry_metrics, "~> 0.6"},
      {:timex, "~> 3.6"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.migrate": ["ecto.migrate", &ecto_dump/1],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.rollback": ["ecto.rollback", &ecto_dump/1],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      lint: ["format --check-formatted", "credo --strict"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"],
      "assets.deploy": [
        "cmd -- npm run deploy --prefix assets",
        "esbuild default --minify",
        "phx.digest"
      ]
    ]
  end

  defp ecto_dump(_args) do
    if Mix.env() == :dev, do: Mix.Task.run("ecto.dump")
  end
end
