defmodule RateLimiterWeb.Router do
  use RateLimiterWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug RateLimiterWeb.Plugs.RateLimiterPlug
  end

  scope "/api", RateLimiterWeb do
    pipe_through :api

    get "/test", TestController, :index
  end
end
