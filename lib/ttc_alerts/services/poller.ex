defmodule TtcAlerts.Services.Poller do
  @moduledoc """
  Periodically poll the TTC Service Alerts page.
  """

  use GenServer

  alias TtcAlerts.Poller

  alias TtcAlerts.Services.AlertHandler

  # 1 hour interval
  @poll_interval 1000 * 60 * 60
  @ttc_alerts_path "/Service_Advisories/all_service_alerts.jsp"

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
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

    @ttc_alerts_path
    |> Poller.run()
    |> AlertHandler.extract()

    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :poll, @poll_interval)
  end
end
