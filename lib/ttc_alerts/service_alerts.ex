defmodule TtcAlerts.ServiceAlerts do
  @moduledoc """
  Context module for interacting with ServiceAlert records.
  """

  use TtcAlerts.Context

  alias TtcAlerts.Schema.ServiceAlert

  def list do
    Repo.all(ServiceAlert)
  end

  def list(:active) do
    ServiceAlert
    |> ServiceAlert.active()
    |> Repo.all()
  end

  def list(:inactive) do
    ServiceAlert
    |> ServiceAlert.inactive()
    |> Repo.all()
  end

  def create(params) do
    %ServiceAlert{}
    |> ServiceAlert.create_changeset(params)
    |> Repo.insert()
  end

  # going to run into issues because the hashing is done on insert
  # Probably need to move that into it's own step
  # Might also need a function to get an alert by it's hash... but can that be unique?
  # would need an index and probably a uniqueness guarantee
  def find_outdated(new_alerts) do
    existing_alerts_set = list(:active) |> Enum.into(MapSet.new())
    new_alerts_set = Enum.into(new_alerts, MapSet.new())
    # require IEx; IEx.pry()

    :ok
  end
end
