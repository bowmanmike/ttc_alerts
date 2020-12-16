defmodule TtcAlerts.Parser do
  @moduledoc """
  Parses text into Elixir-native data structures
  """

  @last_updated_regex ~r/(?<date>[A-Z][a-z]{2} \d{2})?,? (?<time>\d{1,2}:\d{2} (?:AM|PM))$/

  def run(elements) when is_list(elements) do
    Enum.map(elements, &extract_fields/1)
  end

  def run(element), do: run([element])

  defp extract_fields(element) do
    last_updated = parse_field(element, :last_updated)
    [line, text] = element |> String.split(":", parts: 2) |> Enum.map(&String.trim/1)

    %{
      last_updated: last_updated,
      raw_text: element,
      active: true,
      line: line,
      text: text
    }
  end

  defp parse_field(element, :last_updated) do
    @last_updated_regex
    |> Regex.named_captures(element)
    |> case do
      %{"date" => date, "time" => time} when date == "" ->
        timestamp_for_today(time)

      %{"date" => date, "time" => time} ->
        (date <> ", " <> time)
        |> prepend_current_year_if_missing()
        |> Timex.parse("%Y %b %e, %l:%M %p", :strftime)
        |> case do
          {:ok, parsed_datetime} -> parsed_datetime
          error -> error
        end
    end
  end

  defp timestamp_for_today(time) do
    {:ok, date} =
      Timex.now()
      |> Timex.to_date()
      |> Timex.format("%Y %b %e", :strftime)

    {:ok, full_timestamp} =
      (date <> ", " <> time)
      |> Timex.parse("%Y %b %e, %l:%M %p", :strftime)

    full_timestamp
  end

  defp prepend_current_year_if_missing(string) do
    current_year_string = to_string(Timex.now().year)

    case String.starts_with?(string, current_year_string) do
      false -> current_year_string <> " " <> string
      true -> string
    end
  end
end
