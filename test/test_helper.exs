ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(TtcAlerts.Repo, :manual)

{:ok, _} = Application.ensure_all_started(:ex_machina)
Faker.start()
