defmodule TtcAlertsWeb.AlertsLive do
  use Phoenix.LiveView

  alias TtcAlerts.ServiceAlerts

  def mount(_params, _session, socket) do
    {:ok, assign(socket, alerts: get_active_alerts())}
  end

  defp get_active_alerts do
    ServiceAlerts.list(:active)
  end
end
