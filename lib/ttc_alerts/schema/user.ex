defmodule TtcAlerts.Schema.User do
  @moduledoc """
  Represents the main user entity
  """

  use TtcAlerts.Schema

  schema "users" do
    field(:name, :string)
    field(:phone_number, :string)

    timestamps()
  end

  def create_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :phone_number])
    |> validate_changeset()
  end

  defp validate_changeset(changeset) do
    validate_required(changeset, [:name, :phone_number])
  end
end
