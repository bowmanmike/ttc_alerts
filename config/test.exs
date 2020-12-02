use Mix.Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

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
  server: false,
  secret_key_base: "THNQOUPtDF7+85rM26uEEJ6IHHl5koy+AM/tYlemycyakPNB1aFyte+VYcunE7Nk"

config :ttc_alerts, TtcAlerts.Poller, http_client: TtcMock
# Print only warnings and errors during test
config :logger, level: :warn
