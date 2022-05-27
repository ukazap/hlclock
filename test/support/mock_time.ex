defmodule HLClock.MockTime do
  @behaviour HLClock.PhysicalTime
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{frozen_at: nil} end, name: __MODULE__)
  end

  @impl HLClock.PhysicalTime
  def now do
    Agent.get(__MODULE__, &mock_now/1)
  end

  def freeze(time \\ real_now()) do
    Agent.update(__MODULE__, fn _ -> %{frozen_at: time} end)
  end

  def unfreeze do
    Agent.update(__MODULE__, fn _ -> %{frozen_at: nil} end)
  end

  def mock_now(%{frozen_at: nil}), do: real_now()
  def mock_now(%{frozen_at: frozen_at}), do: frozen_at
  def real_now, do: System.os_time(:millisecond)
end
