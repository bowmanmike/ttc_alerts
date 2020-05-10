defmodule TtcAlertsWeb.PageController do
  use TtcAlertsWeb, :controller

  alias TtcAlerts.Accounts

  def index(conn, _params) do
    conn
    |> assign(:users, Accounts.list_users())
    |> render("index.html")
  end
end
