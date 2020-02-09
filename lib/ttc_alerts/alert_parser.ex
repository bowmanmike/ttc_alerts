defmodule TtcAlerts.AlertParser do
  @moduledoc """
  Contains functionality for parsing HTML documents and extracting
  relevant information.
  """

  alias TtcAlerts.ServiceAlerts

  @default_selector "div.advisory-wrap > div.alert-content"
  @last_updated_regex ~r<(([A-Z][a-z]{2} \d{1,2}, )?\d{1,2}:\d{1,2} (AM|PM))>

  @spec extract_alerts(String.t(), String.t()) :: list(tuple())
  def extract_alerts(document, selector \\ @default_selector) do
    with {:ok, parsed_doc} <- Floki.parse_document(document) do
      parsed_doc
      |> find_alerts(selector)
      |> Enum.map(&extract_data/1)
      |> Enum.map(&ServiceAlerts.create/1)
    end
  end

  defp extract_data(alert) do
    last_updated = extract_text_from_element(:last_updated, alert)
    raw_text = extract_text_from_element(:raw_text, alert)

    %{}
    |> Map.put(:last_updated, last_updated)
    |> Map.put(:raw_text, raw_text)
    |> Map.put(:active, true)
  end

  defp extract_text_from_element(:last_updated, element) do
    element
    |> Floki.find(".alert-updated")
    |> Floki.text()
    |> parse_timestamp()
  end

  defp parse_timestamp(timestamp) do
    @last_updated_regex
    |> Regex.run(timestamp)
    |> List.first()
    |> Timex.parse("%b %e, %l:%M %p", :strftime)
    |> case do
      {:ok, timestamp} -> timestamp
      error -> error
    end
  end

  defp extract_text_from_element(:raw_text, element) do
    Floki.text(element)
  end

  defp find_alerts(parsed_html, selector) do
    Floki.find(parsed_html, selector)
  end
end
