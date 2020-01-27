# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TtcAlerts.Repo.insert!(%TtcAlerts.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TtcAlerts.Repo
alias TtcAlerts.Schema.User

mike_phone_num = System.fetch_env!("MIKE_PHONE_NUM")
jasmine_phone_num = System.fetch_env!("JASMINE_PHONE_NUM")

users = [
  %{name: "Mike", phone_number: mike_phone_num},
  %{name: "Jasmine", phone_number: jasmine_phone_num}
]

Enum.map(users, fn user_attrs ->
  %User{}
  |> User.create_changeset(user_attrs)
  |> Repo.insert!()
end)
