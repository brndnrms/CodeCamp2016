defmodule TwitStat do
  alias TwitStat.Graph
  alias TwitStat.Twitter

  defp intersect(x, y) do
    x -- (x -- y)
  end

  defp to_screen_names(ids) do
    ids_str = ids |> Enum.map(&Integer.to_string(&1))
                  |> Enum.join(",")
    Twitter.user_lookup(user_id: ids_str)
      |> Enum.map(&(&1.screen_name))
  end

  def followers(user) do
    _followers(user) |> to_screen_names |> Enum.sort
  end

  defp _followers(user) do
    Twitter.follower_ids(user).items
  end

  def common_followers(user1, user2) do
    _common_followers(user1, user2) |> to_screen_names |> Enum.sort
  end

  defp _common_followers(user1, user2) do
    intersect(_followers(user1), _followers(user2))
  end

  def following(user) do
    _following(user) |> to_screen_names |> Enum.sort
  end

  defp _following(user) do
    Twitter.friend_ids(user).items
  end

  def friends(user) do
    _friends(user) |> to_screen_names |> Enum.sort
  end

  defp _friends(user) do
    intersect(_followers(user), _following(user))
  end

  def common_friends(user1, user2) do
    _common_friends(user1, user2) |> to_screen_names |> Enum.sort
  end

  def _common_friends(user1, user2) do
    intersect(_friends(user1), _friends(user2))
  end

  def common_friends_graph(user1, user2) do
    _common_friends(user1, user2)
      |> create_graph
      #|> Graph.save("#{user1}_#{user2}.dot")
  end

  def create_graph(users) do
    g = users
      |> Enum.reduce(Graph.new, &Graph.add_node(&2, &1))
    g = users
      |> Enum.reduce(g, &add_friend_edges(&2, &1))
    nodes =
      Enum.zip(g.nodes, to_screen_names(g.nodes))
      |> Enum.map(fn {a,b} -> %{id: a, name: b} end)
    %{g | nodes: nodes}
  end

  defp add_friend_edges(graph, user) do
    intersect(_friends(user), graph.nodes)
      |> Enum.reduce(graph, &Graph.add_edge(&2, user, &1))
  end
end
