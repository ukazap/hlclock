defmodule HLClock.ServerTest do
  use ExUnit.Case, async: false

  setup_all do
    start_supervised!(HLClock.MockTime)
    :ok
  end

  describe "node names" do
    test "HLClocks can be given a node id" do
      node_id = fn -> 12345 end

      {:ok, hlc} =
        HLClock.Server.start_link(node_id: node_id, name: :given_node_id)

      {:ok, clock} = GenServer.call(hlc, :send_timestamp)
      assert %{node_id: 12345} = clock
    end

    test "if no node id is given then we use a hash of the node name" do
      {:ok, hlc} = HLClock.Server.start_link(name: :no_node_id)
      {:ok, clock} = GenServer.call(hlc, :send_timestamp)
      node_id = HLClock.NodeId.hash()
      assert %{node_id: ^node_id} = clock
    end
  end
end
