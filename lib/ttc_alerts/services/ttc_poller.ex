defmodule TtcAlerts.Services.TtcPoller do
  @moduledoc """
  Periodically poll the TTC Service Alerts page.
  """

  use GenServer

  alias TtcAlerts.{
    Extractor,
    Parser,
    Poller,
    ServiceAlerts
  }

  # 1 hour interval
  @poll_interval 1000 * 60 * 60
  @ttc_alerts_path "/Service_Advisories/all_service_alerts.jsp"
  @ttc_alerts_selector "div.advisory-wrap > div.alert-content"

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

    @ttc_alerts_path
    |> Poller.run()
    |> Extractor.run(@ttc_alerts_selector)

    # |> Parser.run()
    # |> Enum.each(&ServiceAlerts.create/1)

    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :poll, @poll_interval)
  end
end
