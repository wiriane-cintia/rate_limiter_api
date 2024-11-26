defmodule RateLimiterWeb.TestController do
  use RateLimiterWeb, :controller

  def index(conn, _params) do
    json(conn, %{message: "Request allowed!"})
  end
end
