defmodule HLClock.PhysicalTime do
  @callback now() :: integer

  def now, do: get_impl().now()

  def get_impl do
    Application.get_env(:hlclock, :physical_time, HLClock.RealTime)
  end
end
