defmodule TtcAlerts.Repo do
  use Ecto.Repo,
    otp_app: :ttc_alerts,
    adapter: Ecto.Adapters.Postgres
end
