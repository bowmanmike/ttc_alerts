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
end