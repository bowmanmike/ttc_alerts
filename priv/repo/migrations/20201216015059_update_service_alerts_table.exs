defmodule TtcAlerts.Repo.Migrations.UpdateServiceAlertsTable do
  use Ecto.Migration

  def change do
    alter table("service_alerts") do
      add :line, :string
      add :text, :string
    end
  end
end
