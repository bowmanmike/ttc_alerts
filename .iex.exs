IEx.configure(colors: [eval_result: [:cyan, :bright]])

import Ecto.Query, warn: false
import Ecto.Changeset
import_if_available(TtcAlerts.Factory)

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
