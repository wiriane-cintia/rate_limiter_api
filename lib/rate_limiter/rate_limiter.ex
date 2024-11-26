defmodule RateLimiter do
  @moduledoc """
  Rate Limiter to control requests per IP.
  """

  @max_requests 5
  @time_window 1_000 # 1 second in milliseconds

  def start_link(_) do
    :ets.new(:rate_limiter_table, [:named_table, :public, :set, {:read_concurrency, true}])
    {:ok, nil}
  end

  def check_rate_limit(ip) do
    now = :os.system_time(:millisecond)

    case :ets.lookup(:rate_limiter_table, ip) do
      [] ->
        :ets.insert(:rate_limiter_table, {ip, [now]})
        {:ok, :allowed}

      [{^ip, timestamps}] ->
        updated_timestamps = Enum.filter(timestamps, fn ts -> now - ts <= @time_window end)

        if length(updated_timestamps) < @max_requests do
          :ets.insert(:rate_limiter_table, {ip, [now | updated_timestamps]})
          {:ok, :allowed}
        else
          {:error, :rate_limited}
        end
    end
  end
end
