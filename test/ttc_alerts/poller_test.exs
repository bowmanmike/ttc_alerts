defmodule TtcAlerts.PollerTest do
  use TtcAlerts.DataCase, async: true

  import Mox

  alias TtcAlerts.Poller

  describe "run/1" do
    test "returns the response body for a successful response" do
      path = "/hello_test"

      expect(TtcMock, :get, fn ^path ->
        {:ok, %HTTPoison.Response{body: "hello", status_code: 200}}
      end)

      assert "hello" = Poller.run(path)
    end
  end
end
