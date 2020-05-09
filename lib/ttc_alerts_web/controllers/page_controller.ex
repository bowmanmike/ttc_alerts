defmodule TtcAlertsWeb.PageController do
  use TtcAlertsWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:users, [])
    |> render("index.html")
  end
end
