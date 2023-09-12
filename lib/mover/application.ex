defmodule Mover.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MoverWeb.Telemetry,
      # Start the Ecto repository
      Mover.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Mover.PubSub},
      # Start Finch
      {Finch, name: Mover.Finch},
      # Start the Endpoint (http/https)
      MoverWeb.Endpoint
      # Start a worker by calling: Mover.Worker.start_link(arg)
      # {Mover.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mover.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MoverWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
