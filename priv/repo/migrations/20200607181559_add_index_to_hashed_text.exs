defmodule TtcAlerts.Repo.Migrations.AddIndexToHashedText do
  use Ecto.Migration

  def change do
    create index("service_alerts", [:hashed_text])
  end
end
