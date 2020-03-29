defmodule TtcAlerts.Services.AlertHandler do
  @moduledoc """
  Handles parsing and saving alerts.
  """

  use GenServer

  alias TtcAlerts.{
    Extractor,
    Parser,
    ServiceAlerts
  }

  @ttc_alerts_selector "div.advisory-wrap > div.alert-content"

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def extract(alerts) do
    GenServer.cast(__MODULE__, {:extract, alerts})
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:extract, alerts}, state) do
    alerts
    |> Extractor.run(@ttc_alerts_selector)
    |> Parser.run()
    |> Enum.each(&ServiceAlerts.create/1)

    {:noreply, state}
  end
end
