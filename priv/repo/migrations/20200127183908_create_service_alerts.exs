defmodule TtcAlerts.Repo.Migrations.CreateServiceAlerts do
  use Ecto.Migration

  def change do
    create table(:service_alerts) do
      add(:raw_text, :string, null: false)
      add(:hashed_text, :string, null: false)
      add(:active, :boolean, default: true, null: false)
      add(:last_updated, :utc_datetime, null: false)

      timestamps()
    end

    create(unique_index(:service_alerts, [:hashed_text, :active]))
  end
end
