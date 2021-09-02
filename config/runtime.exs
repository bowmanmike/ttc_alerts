import Config

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") || raise "environment variable DATABASE_URL is missing!"

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") || raise "environment variable SECRET_KEY_BASE is missing!"

  app_name =
    System.get_env("FLY_APP_NAME") || raise "environment variable FLY_APP_NAME is missing!"

  config :ttc_alerts, TtcAlerts.Repo,
    url: database_url,
    socket_options: [:inet6],
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

  config :ttc_alerts, TtcAlertsWeb.Endpoint,
    server: true,
    url: [host: "#{app_name}.fly.dev", port: 80],
    http: [
      port: String.to_integer(System.get_env("PORT") || "4000"),
      transport_options: [socket_opts: [:inet6]]
    ],
    secret_key_base: secret_key_base
end
