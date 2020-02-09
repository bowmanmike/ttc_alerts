defmodule TtcAlerts.Services.TtcPoller do
  @moduledoc """
  Periodically poll the TTC Service Alerts page.
  """

  use GenServer

  alias TtcAlerts.AlertParser

  @poll_interval 1000 * 60 * 60
  @ttc_alerts_url "https://www.ttc.ca/Service_Advisories/all_service_alerts.jsp"

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg)
  end

  def poll(pid, _) do
    GenServer.call(pid, :poll)
  end

  @impl true
  def init(state) do
    schedule_work()
    handle_info(:poll, state)

    {:ok, state}
  end

  @impl true
  def handle_info(:poll, state) do
    schedule_work()

    get_alerts_page()

    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :poll, @poll_interval)
  end

  defp get_alerts_page do
    {:ok, %{body: body}} = HTTPoison.get(@ttc_alerts_url)

    AlertParser.extract_alerts(body)
  end
end
