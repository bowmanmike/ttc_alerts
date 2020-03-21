defmodule TtcAlerts.Parser do
  @moduledoc """
  Parses text into Elixir-native data structures
  """

  # @last_updated_regex ~r<(([A-Z][a-z]{2} \d{1,2}, )?\d{1,2}:\d{1,2} (AM|PM))>
  @last_updated_regex ~r<[A-Z][a-z]{2} \d{2}, \d:\d{2} (?:AM|PM)$>

  def run(elements) when is_list(elements) do
    Enum.map(elements, &extract_fields/1)
  end

  def run(element), do: run([element])

  defp extract_fields(element) do
    last_updated = parse_field(element, :last_updated)

    %{
      last_updated: last_updated,
      raw_text: element,
      active: true
    }
  end

  defp parse_field(element, :last_updated) do
    @last_updated_regex
    |> Regex.run(element)
    |> List.first()
    |> prepend_current_year()
    |> Timex.parse("%Y %b %e, %l:%M %p", :strftime)
    |> case do
      {:ok, timestamp} -> timestamp
      error -> error
    end
  end

  defp prepend_current_year(string) do
    "#{Timex.now.year} #{string}"
  end
end
