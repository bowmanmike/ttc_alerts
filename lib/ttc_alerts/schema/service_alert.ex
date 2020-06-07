defmodule TtcAlerts.Schema.ServiceAlert do
  @moduledoc """
  Represents TTC service disruptions
  """

  use TtcAlerts.Schema

  schema "service_alerts" do
    field(:raw_text, :string)
    field(:hashed_text, :string)
    field(:active, :boolean)
    field(:last_updated, :utc_datetime)

    timestamps()
  end

  def create_changeset(service_alert, attrs) do
    IO.inspect(attrs, label: :attrs)
    service_alert
    |> cast(attrs, ~w(raw_text active last_updated)a)
    |> IO.inspect()
    |> hash_text()
    |> validate_changeset()
  end

  def active(query \\ __MODULE__) do
    from(alert in query, where: alert.active == true)
  end

  def inactive(query \\ __MODULE__) do
    from(alert in query, where: alert.active == false)
  end

  def by_id(query \\ __MODULE__, id) do
    from(alert in query, where: alert.id == ^id)
  end

  def by_hashed_text(query \\ __MODULE__, text) do
    from(alert in query, where: alert.hashed_text == ^text)
  end

  defp validate_changeset(changeset) do
    changeset
    |> validate_required(~w(raw_text hashed_text active last_updated)a)
    |> unique_constraint(:hashed_text, name: :service_alerts_hashed_text_active_index)
  end

  defp hash_text(changeset) do
    case get_field(changeset, :raw_text) do
      nil ->
        changeset

      text ->
        hashed_value = :sha256 |> :crypto.hash(text) |> Base.encode16()
        put_change(changeset, :hashed_text, hashed_value)
    end
  end
end
