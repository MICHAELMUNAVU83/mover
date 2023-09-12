defmodule MoverWeb.Router do
  use MoverWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MoverWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MoverWeb do
    pipe_through :browser

    live "/", PageLive.Index, :index
    live "/quotes", QuoteLive.Index, :index
    live "/quotes/new", QuoteLive.Index, :new
    live "/quotes/:id/edit", QuoteLive.Index, :edit

    live "/quotes/:id", QuoteLive.Show, :show
    live "/quotes/:id/show/edit", QuoteLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", MoverWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:mover, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MoverWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
