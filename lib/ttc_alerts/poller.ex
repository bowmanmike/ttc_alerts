defmodule TtcAlerts.Poller do
  @moduledoc """
  Encapsulates logic for polling a given URL
  """

  def run(path) do
    case client().get(path, [], ssl: [versions: :"tlsv1.2"]) do
      {:ok, %{status_code: 200, body: body}} ->
        body

      err ->
        require IEx
        IEx.pry()
    end
  end

  defp client, do: Application.get_env(:ttc_alerts, __MODULE__)[:http_client]
end
