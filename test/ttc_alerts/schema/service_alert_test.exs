defmodule TtcAlerts.Schema.ServiceAlertTest do
  use TtcAlerts.DataCase, async: true

  alias TtcAlerts.Schema.ServiceAlert

  describe "create_changeset/2" do
    test "returns a valid changeset when all fields are valid" do
      params = params_for(:service_alert, hashed_text: nil)

      changeset = ServiceAlert.create_changeset(%ServiceAlert{}, params)
      assert_valid_changeset(changeset)
    end
  end
end
