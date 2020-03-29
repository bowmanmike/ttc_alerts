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
    test "it returns all active but outdated alerts" do
      old_alert = insert(:service_alert, active: true)
      new_alert_params = %{
        active: true,
        raw_text: Faker.Lorem.Shakespeare.hamlet()
      }

      # should pass only the new alert, and assert that the old is marked inactive
      assert ^old_alert = ServiceAlerts.find_outdated([new_alert_params])
    end
  end
end
