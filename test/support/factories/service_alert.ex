defmodule TtcAlerts.Factories.ServiceAlert do
  @moduledoc false

  alias TtcAlerts.Schema.ServiceAlert

  defmacro __using__(_opts) do
    quote do
      def service_alert_factory do
        raw_text = Faker.Lorem.Shakespeare.hamlet()
        hashed_text = :sha256 |> :crypto.hash(raw_text) |> Base.encode16()

        %ServiceAlert{
          raw_text: raw_text,
          hashed_text: hashed_text,
          active: Faker.Util.pick([true, false]),
          last_updated: Timex.now()
        }
      end
    end
  end
end
