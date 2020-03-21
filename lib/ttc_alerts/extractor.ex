defmodule TtcAlerts.Extractor do
  @moduledoc """
  Encapsulates functionality to extract relevant data
  from an HTML document
  """

  def run(document, selector) do
    with {:ok, parsed_doc} <- parse_document(document) do
      find_alerts(parsed_doc, selector)
    end
  end

  defp parse_document(document), do: Floki.parse_document(document)

  defp find_alerts(document, selector) do
    document
    |> Floki.find(selector)
    |> Enum.map(&Floki.text/1)
  end
end
