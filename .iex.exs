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

alias TtcAlerts.Account.Schema.User
alias TtcAlerts.Schema.ServiceAlert

alias TtcAlertsWeb.Router.Helpers, as: Routes
