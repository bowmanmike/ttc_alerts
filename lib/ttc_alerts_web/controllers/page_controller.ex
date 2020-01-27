defmodule TtcAlertsWeb.PageController do
  use TtcAlertsWeb, :controller

  alias TtcAlerts.Users

  def index(conn, _params) do
    users = Users.all()

    conn
    |> assign(:users, users)
    |> render("index.html")
  end
end
