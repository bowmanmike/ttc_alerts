# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ttc_alerts,
  ecto_repos: [TtcAlerts.Repo],
  mix_env: Mix.env()

# Configures the endpoint
config :ttc_alerts, TtcAlertsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CgA+jz3aDxCVf2IfW6s9VpxIV94wsfjdlPTTDZrFP+jcU4z7i8FBpXWb+nY+7NyT",
  render_errors: [view: TtcAlertsWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: TtcAlerts.PubSub,
  live_view: [
    signing_salt: "Hm4tOUanHepTkRk01GZlroW8EzC5+xuc"
  ],
  check_origin: [
    "//localhost",
    "https://ttc-alerts.bowmanmike.com",
    "https://restless-waterfall-8970.fly.dev"
  ]

config :ttc_alerts, TtcAlerts.Poller, http_client: TtcAlerts.HTTPClient

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
