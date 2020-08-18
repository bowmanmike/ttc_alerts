import Config

config :ttc_alerts, TtcAlerts.Repo,
  username: System.fetch_env!("TTC_DB_USER"),
  password: System.fetch_env!("TTC_DB_PASS"),
  database: System.fetch_env!("TTC_DB_NAME"),
  hostname: System.fetch_env!("TTC_DB_HOST"),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :ttc_alerts, TtcAlertsWeb.Endpoint,
  secret_key_base: System.fetch_env!("TTC_SECRET_KEY_BASE"),
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")]
