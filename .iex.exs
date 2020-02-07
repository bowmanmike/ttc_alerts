IEx.configure(colors: [eval_result: [:cyan, :bright]])

import Ecto.Query, warn: false
import Ecto.Changeset

alias TtcAlerts.{
  AlertParser,
  Repo,
  ServiceAlerts,
  Users
}

alias TtcAlerts.Schema.{
  ServiceAlert,
  User
}
