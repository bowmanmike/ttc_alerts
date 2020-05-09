defmodule TtcAlertsWeb.UserSessionController do
  use TtcAlertsWeb, :controller

  alias TtcAlerts.Accounts
  alias TtcAlertsWeb.UserAuthController

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      UserAuthController.login_user(conn, user, user_params)
    else
      render(conn, "new.html", error_message: "Invalid e-mail or password")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuthController.logout_user()
  end
end
