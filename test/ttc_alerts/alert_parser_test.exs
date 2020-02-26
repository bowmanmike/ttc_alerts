defmodule TtcAlerts.AlertParserTest do
  use TtcAlerts.DataCase, async: true

  alias TtcAlerts.AlertParser

  @html_doc ~s(
  <html>
    <body>
      <div class="content">
        <ul id="people">
          <li class="person"><p>Mike!</p></li>
          <li class="person"><p>Jasmine!</p></li>
          <li class="person"><p>Dave!</p></li>
        </ul>
      </div>
    </body>
  </html>
  )

  describe "extract_alerts/1" do
    @tag :skip
    test "it accepts an HTML document and returns a list of ServiceAlert structs" do
      assert [
               {"li", [{"class", "person"}], _},
               {"li", [{"class", "person"}], _},
               {"li", [{"class", "person"}], _}
             ] = AlertParser.extract_alerts(@html_doc, ".person")
    end
  end

  describe "parse_timestamp/1" do
    test "it extracts the timestamp from a raw alert string" do
      test_str = "Queen's Park: Elevator out of service between concourse and Line 1 platform.Last updated Feb 8, 10:20 PM"

      assert ~N[2020-02-08 22:20:00] == AlertParser.parse_timestamp(test_str)
    end
  end
end
