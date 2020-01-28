defmodule TtcAlerts.Services.TtcPoller do
  @moduledoc """
  Periodically poll the TTC Service Alerts page.
  """

  use GenServer

  @poll_interval 1000 * 60
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

    {:ok, state}
  end

  @impl true
  def handle_info(:poll, state) do
    schedule_work()

    # msg = "#{Timex.now()} #{__MODULE__} Working!"
    # IO.puts(msg)

    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :poll, @poll_interval)
  end

  defp get_alerts_page do
    {:ok, %{body: body}} = HTTPoison.get(@ttc_alerts_url)
    body
  end
end
