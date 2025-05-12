defmodule Drip.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DripWeb.Telemetry,
      Drip.Repo,
      {DNSCluster, query: Application.get_env(:drip, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Drip.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Drip.Finch},
      # Start a worker by calling: Drip.Worker.start_link(arg)
      # {Drip.Worker, arg},
      # Start to serve requests, typically the last entry
      DripWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Drip.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DripWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
