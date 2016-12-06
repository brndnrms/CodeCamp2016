defmodule TwitStatTest do
  use ExUnit.Case

  test "followers" do
    assert ["MachinesAreUs", "metallikito", "silmood"] ==
      TwitStat.followers("tuitabeaver")
  end

  test "common followers" do
    assert ["MachinesAreUs", "metallikito", "silmood"] ==
      TwitStat.common_followers("tuitabeaver", "hip_beaver")
  end

  test "friends" do
    assert ["MachinesAreUs", "metallikito", "rugi", "silmood"] ==
      TwitStat.friends("hip_beaver")
  end

  test "common friends" do
    assert ["MachinesAreUs", "metallikito", "silmood"] ==
      TwitStat.common_friends("tuitabeaver", "hip_beaver")
  end

  test "common friends graph" do
    real_g = TwitStat.common_friends_graph("tuitabeaver", "hip_beaver")

    expected_g = %TwitStat.Graph{
      nodes: [{14120299, "MachinesAreUs"},
              {84340970, "metallikito"},
              {2597177828, "silmood"}],
      edges: [[14120299, 84340970],
              [14120299, 2597177828],
              [84340970, 2597177828]]}
    assert real_g == expected_g
  end
end
