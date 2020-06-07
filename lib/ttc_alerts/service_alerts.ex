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

  def by_hashed_text(hash) do
    ServiceAlert
    |> ServiceAlert.by_hashed_text(hash)
    |> Repo.one()
  end

  def create(params) do
    %ServiceAlert{}
    |> ServiceAlert.create_changeset(params)
    |> Repo.insert()
  end

  def mark_inactive(ids) when is_list(ids) do
    Enum.map(ids, &mark_inactive/1)
  end

  def mark_inactive(id) do
    ServiceAlert
    |> ServiceAlert.by_id(id)
    |> IO.inspect()
    |> ServiceAlert.create_changeset(%{active: false})
  end

  # going to run into issues because the hashing is done on insert
  # Probably need to move that into it's own step
  # Might also need a function to get an alert by it's hash... but can that be unique?
  # would need an index and probably a uniqueness guarantee
  # Maybe the hashing isn't required at all
  def find_outdated(new_alerts) do
    existing_alerts_set =
      :active
      |> list()
      |> Enum.map(& &1.hashed_text)
      |> Enum.into(MapSet.new())

    new_alerts_set =
      new_alerts
      |> Enum.map(& &1.hashed_text)
      |> Enum.into(MapSet.new())

    # this doesn't quite work because the existing alerts are db structs and the
    # new records are just params
    deleted_alerts =
      existing_alerts_set
      |> MapSet.difference(new_alerts_set)
      |> Enum.map(&mark_inactive/1)
    require IEx; IEx.pry()
  end
end
