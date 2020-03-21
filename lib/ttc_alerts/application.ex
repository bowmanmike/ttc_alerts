defmodule TtcAlerts.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    mix_env = Mix.env()
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      TtcAlerts.Repo,
      # Start the endpoint when the application starts
      TtcAlertsWeb.Endpoint,
      # Starts a worker by calling: TtcAlerts.Worker.start_link(arg)
      # {TtcAlerts.Worker, arg},
    ]
    |> ttc_poller(mix_env)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TtcAlerts.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TtcAlertsWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp ttc_poller(children, mix_env) when mix_env == :test, do: children

  defp ttc_poller(children, _mix_env), do: children ++ [{TtcAlerts.Services.TtcPoller, []}]
end
