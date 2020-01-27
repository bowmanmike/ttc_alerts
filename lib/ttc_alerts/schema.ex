defmodule TtcAlerts.Schema do
  @moduledoc """
  Module used as the base for defining schemas.
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Ecto.Query, warn: false
    end
  end
end
