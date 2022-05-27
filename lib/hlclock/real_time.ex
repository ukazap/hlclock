defmodule HLClock.RealTime do
  @behaviour HLClock.PhysicalTime

  @impl HLClock.PhysicalTime
  def now, do: System.os_time(:millisecond)
end
