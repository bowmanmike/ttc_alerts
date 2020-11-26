defmodule TtcAlerts.ServiceAlertsTest do
  use TtcAlerts.DataCase, async: true

  alias TtcAlerts.ServiceAlerts

  test "list/0 returns all service alerts" do
    insert_list(5, :service_alert)

    assert Enum.count(ServiceAlerts.list()) == 5
  end

  describe "list/1" do
    test "returns the correct number of alerts given the corresponding flag" do
      insert(:service_alert, active: false)
      insert(:service_alert, active: false)
      insert(:service_alert, active: true)

      assert Enum.count(ServiceAlerts.list(:active)) == 1
      assert Enum.count(ServiceAlerts.list(:inactive)) == 2
    end
  end

  describe "find_outdated/1" do
    test "returns all active alerts not present in provided params" do
      %{id: old_id} = insert(:service_alert, active: true)
      current_alert = params_for(:service_alert, active: true)
      {:ok, _current} = ServiceAlerts.create(current_alert)
      new_alert_params = [params_for(:service_alert, active: true), current_alert]

      assert [%{id: ^old_id, active: false}] = ServiceAlerts.find_outdated(new_alert_params)
    end
  end
end
