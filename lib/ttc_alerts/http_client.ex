defmodule TtcAlerts.HTTPClient do
  @moduledoc """
  Encapsulates HTTP functionality related to the TTC
  alerts page
  """

  use HTTPoison.Base

  def process_request_url(path) do
    %URI{
      scheme: "https",
      host: "www.ttc.ca",
      path: path
    }
    |> URI.to_string()
  end
end
