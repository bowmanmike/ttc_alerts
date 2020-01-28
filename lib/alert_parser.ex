defmodule TtcAlerts.AlertParser do
  @moduledoc """
  Contains functionality for parsing HTML documents and extracting
  relevant information.
  """

  @spec extract_alerts(String.t(), String.t()) :: list(tuple())
  def extract_alerts(document, selector) do
    with {:ok, parsed_doc} <- Floki.parse_document(document) do
      find_alerts(parsed_doc, selector)
    end
  end

  defp find_alerts(parsed_html, selector) do
    Floki.find(parsed_html, selector)
  end
end
