defmodule RateLimiter.Application do
  use Application

  @impl true
  def start(_type, _args) do
    # Crie a tabela ETS ao iniciar a aplicação
    :ets.new(:rate_limiter_table, [:set, :public, :named_table])

    children = [
      # Start the Telemetry supervisor
      RateLimiterWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: RateLimiter.PubSub},
      # Start the Endpoint (http/https)
      RateLimiterWeb.Endpoint
      # Start a worker by calling: RateLimiter.Worker.start_link(arg)
      # {RateLimiter.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RateLimiter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RateLimiterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
