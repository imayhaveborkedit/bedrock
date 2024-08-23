defmodule Bedrock.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Oban.Telemetry.attach_default_logger(encode: false)

    children = [
      BedrockWeb.Telemetry,
      Bedrock.Repo,
      {Oban, Application.fetch_env!(:bedrock, Oban)},
      {DNSCluster, query: Application.get_env(:bedrock, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Bedrock.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Bedrock.Finch},
      # Start a worker by calling: Bedrock.Worker.start_link(arg)
      # {Bedrock.Worker, arg},
      # Start to serve requests, typically the last entry
      BedrockWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bedrock.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BedrockWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
