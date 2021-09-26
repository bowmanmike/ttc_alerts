defmodule TtcAlertsWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :ttc_alerts

  @session_options [
    store: :cookie,
    key: "_ttc_alerts_key",
    signing_salt: "4koiRMAt"
  ]

  socket "/socket", TtcAlertsWeb.UserSocket,
    websocket: true,
    longpoll: false,
    check_origin: ["/ttc-alerts.bowmanmike.com", "//localhost"]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :ttc_alerts,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session, @session_options

  plug TtcAlertsWeb.Router

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    check_origin: [
      "//ttc-alerts.bowmanmike.com",
      "//localhost",
      "https://restless-waterfall-8970.fly.dev"
    ]
end
