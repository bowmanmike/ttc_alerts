defmodule TtcAlerts.Users do
  @moduledoc """
  Context module for interacting with User records.
  """
  use TtcAlerts.Context

  alias TtcAlerts.Accounts.Schema.User

  def all do
    Repo.all(User)
  end
end
