Application.put_env(:hlclock, :physical_time, HLClock.MockTime)

ExUnit.start()
