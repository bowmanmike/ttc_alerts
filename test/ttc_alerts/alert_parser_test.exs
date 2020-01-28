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
    test "it accepts an HTML document and returns a list of ServiceAlert structs" do
      assert [
               {"li", [{"class", "person"}], _},
               {"li", [{"class", "person"}], _},
               {"li", [{"class", "person"}], _}
             ] = AlertParser.extract_alerts(@html_doc, ".person")
    end
  end
end
