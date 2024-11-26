defmodule RateLimiterWeb.Plugs.RateLimiterPlug do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    ip = get_peer_ip(conn)

    case RateLimiter.check_rate_limit(ip) do
      {:ok, :allowed} ->
        conn

      {:error, :rate_limited} ->
        conn
        |> send_resp(429, "Too Many Requests")
        |> halt()
    end
  end

  defp get_peer_ip(conn) do
    Tuple.to_list(conn.remote_ip)
    |> Enum.join(".")
  end
end
