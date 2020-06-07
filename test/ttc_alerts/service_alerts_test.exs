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

  describe "mark_inactive/1" do
    test "it marks outdated alerts as inactive" do
      old_alert = insert(:service_alert, active: true)
      current_alert = params_for(:service_alert, active: true)
      {:ok, _current} = ServiceAlerts.create(current_alert)
      new_alert_params = [params_for(:service_alert, active: true), current_alert]

      # should pass only the new alert, and assert that the old is marked inactive
      result = ServiceAlerts.find_outdated(new_alert_params)
      require IEx; IEx.pry()
      assert false
    end
  end
end
