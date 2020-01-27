defmodule TtcAlerts.Context do
  @moduledoc """
  Base module for defining common concerns across schemas.
  """

  defmacro __using__(_) do
    quote do
      alias TtcAlerts.Repo
    end
  end
end
