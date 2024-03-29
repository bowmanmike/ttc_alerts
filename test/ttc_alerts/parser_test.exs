defmodule TtcAlerts.ParserTest do
  use TtcAlerts.DataCase, async: true

  alias TtcAlerts.Parser

  describe "run/1" do
    test "it returns a list of maps containing the correct attributes" do
      elements = [
        ~s(Bathurst: Elevator out of service between Bathurst St east side entrance, concourse and Line 2 westbound platform.Last updated Mar 16, 4:06 PM),
        ~s(Line 1: This weekend, there will be no subway service between Lawrence and St Clair due to ATC signal upgrades. Shuttle buses will run.Last updated Mar 20, 6:41 AM)
      ]

      result = Parser.run(elements)

      assert is_list(result)
      assert Enum.all?(result, &is_map/1)
    end

    test "it parses all the correct attributes" do
      element =
        ~s(Line 1: This weekend, there will be no subway service between Lawrence and St Clair due to ATC signal upgrades. Shuttle buses will run.Last updated Mar 20, 6:41 AM)

      current_year = Timex.today() |> Map.get(:year)
      expected_timestamp = NaiveDateTime.new!(current_year, 3, 20, 6, 41, 0)

      assert [
               %{
                 active: true,
                 last_updated: ^expected_timestamp,
                 raw_text:
                   "Line 1: This weekend, there will be no subway service between Lawrence and St Clair due to ATC signal upgrades. Shuttle buses will run.Last updated Mar 20, 6:41 AM"
               }
             ] = Parser.run(element)
    end

    test "it adds the current date when none is provided" do
      element =
        ~s(110 Islington South: Detour via Norseman St, Kipling Ave and The Queensway due to a Hydro Pole down.Last updated 1:20 PM)

      expected_timestamp =
        Timex.now()
        |> Timex.to_date()
        |> Timex.to_naive_datetime()
        |> Timex.shift(hours: 13, minutes: 20)

      assert [
               %{
                 last_updated: ^expected_timestamp
               }
             ] = Parser.run(element)
    end
  end
end
