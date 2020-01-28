use Mix.Config

# Configure your database
config :ttc_alerts, TtcAlerts.Repo,
  database: "ttc_alerts_test",
  hostname: "localhost",
  ownership_timeout: 999_999,
  password: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox,
  username: "postgres"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ttc_alerts, TtcAlertsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
