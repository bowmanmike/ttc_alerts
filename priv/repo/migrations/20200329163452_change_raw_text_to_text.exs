defmodule TtcAlerts.Repo.Migrations.ChangeRawTextToText do
  use Ecto.Migration

  def change do
    alter table(:service_alerts) do
      modify(:raw_text, :text, null: false)
    end
  end
end
