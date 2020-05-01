defmodule ScorePayWeb.Live.Hello do
  @moduledoc """
  LiveView testing ground
  """
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    Hello!
    """
  end

  def mount(_params, _assigns, socket) do
    {:ok, socket}
  end
end
