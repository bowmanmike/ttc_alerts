defmodule TtcAlerts.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string, null: false)
      add(:phone_number, :string, null: false)
      timestamps()
    end
  end
end
