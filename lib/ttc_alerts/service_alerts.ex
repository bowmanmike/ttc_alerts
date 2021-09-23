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

  def mark_inactive(hashes) when is_list(hashes) do
    Enum.map(hashes, &mark_inactive/1)
  end

  def mark_inactive(hashed_text) do
    {:ok, alert} =
      hashed_text
      |> by_hashed_text()
      |> ServiceAlert.update_changeset(%{active: false})
      |> Repo.update()

    alert
  end

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
    # require IEx; IEx.pry()
    existing_alerts_set
    |> MapSet.difference(new_alerts_set)

    # |> Enum.map(&mark_inactive/1)
  end
end
