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

  # Should improve the HTML parsing. The main text and the timestamp both come in separate tags
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
    created =
      alerts
      |> Extractor.run(@ttc_alerts_selector)
      |> Parser.run()
      |> Enum.map(&ServiceAlerts.create/1)

    # ServiceAlerts.create() returns success/error tuples with changesets,
    # I need the records themselves

    # trouble may also be because the hashes don't include last_updated
    # the alert text changes or the hash includes the timestamp
    # so we need a way to track the text of an alert across potential changes
    # for now, lets assume that the alert text will never change.
    # need to hash ONLY the raw text, not the timestamp
    # require IEx; IEx.pry()
    created
    |> ServiceAlerts.find_outdated()
    |> ServiceAlerts.mark_inactive()

    {:noreply, state}
  end
end
