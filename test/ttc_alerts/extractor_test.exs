defmodule TtcAlerts.ExtractorTest do
  use TtcAlerts.DataCase, async: true

  alias TtcAlerts.Extractor

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

  describe "run/2" do
    test "returns the text from inside each element" do
      assert ["Mike!", "Jasmine!", "Dave!"] = Extractor.run(@html_doc, ".person")
    end
  end
end
