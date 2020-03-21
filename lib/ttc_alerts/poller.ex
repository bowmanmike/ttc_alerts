defmodule TtcAlerts.Poller do
  @moduledoc """
  Encapsulates logic for polling a given URL
  """

  alias TtcAlerts.HTTPClient

  def run(path) do
    {:ok, %{body: body, status_code: 200}} = HTTPClient.get(path)

    body
  end
end
