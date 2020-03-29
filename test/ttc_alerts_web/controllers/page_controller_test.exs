defmodule TtcAlertsWeb.PageControllerTest do
  use TtcAlertsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "TTC"
  end
end
