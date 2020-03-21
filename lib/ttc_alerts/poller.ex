defmodule TtcAlerts.Poller do
  @moduledoc """
  Encapsulates logic for polling a given URL
  """

  def run(path) do
    {:ok, %{body: body, status_code: 200}} = client().get(path)

    body
  end

  defp client, do: Application.get_env(:ttc_alerts, __MODULE__)[:http_client]
end
