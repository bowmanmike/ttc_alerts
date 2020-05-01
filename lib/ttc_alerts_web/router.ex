defmodule TtcAlertsWeb.Router do
  use TtcAlertsWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {TtcAlertsWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TtcAlertsWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/hello", HelloLive
  end

  if Mix.env() == :dev do
    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TtcAlertsWeb.Telemetry
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", TtcAlertsWeb do
  #   pipe_through :api
  # end
end
