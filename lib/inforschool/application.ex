defmodule Inforschool.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      InforschoolWeb.Telemetry,
      Inforschool.Repo,
      {DNSCluster, query: Application.get_env(:inforschool, :dns_cluster_query) || :ignore},
      {Oban,
       AshOban.config(
         Application.fetch_env!(:inforschool, :ash_domains),
         Application.fetch_env!(:inforschool, Oban)
       )},
      {Phoenix.PubSub, name: Inforschool.PubSub},
      # Start a worker by calling: Inforschool.Worker.start_link(arg)
      # {Inforschool.Worker, arg},
      # Start to serve requests, typically the last entry
      InforschoolWeb.Endpoint,
      {AshAuthentication.Supervisor, [otp_app: :inforschool]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Inforschool.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    InforschoolWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
