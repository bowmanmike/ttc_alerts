defmodule TtcAlertsWeb.HelloLive do
  @moduledoc """
  LiveView testing ground
  """
  use Phoenix.LiveView, layout: {TtcAlertsWeb.LayoutView, "live.html"}

  def render(assigns) do
    ~L"""
    <p>Hello <%= @name %>!</p>
    <p>It is now <%= Timex.format!(@time, "%l:%M:%S %p", :strftime) %></p>
    <button phx-click="click">Click!</button>
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(500, self(), :tick)

    socket =
      socket
      |> assign(:name, "Mike")
      |> put_time()

    {:ok, socket}
  end

  def handle_info(:tick, socket) do
    {:noreply, put_time(socket)}
  end

  def handle_event("click", _session, socket) do
    {:noreply, socket}
  end

  defp put_time(socket) do
    assign(socket, :time, Timex.now())
  end
end
