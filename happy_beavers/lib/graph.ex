defmodule TwitStat.Graph do
  defstruct nodes: [], edges: []

  def new, do: %TwitStat.Graph{}

  def add_node(graph, node) do
    new_nodes = [node | graph.nodes] |> Enum.sort |> Enum.dedup
    %{graph | nodes: new_nodes}
  end

  def add_edge(graph, node1, node2) do
    new_edges = [ Enum.sort([node1, node2]) | graph.edges] |> Enum.sort |> Enum.dedup
    %{graph | edges: new_edges}
  end

  def save(graph, fname) do
    {:ok, file} = File.open fname, [:write]

    IO.binwrite file, "graph G {\n"

    users = Enum.reduce(graph.nodes, %{}, fn {id,name}, acc -> Map.put(acc, id, name) end)

    graph.nodes
    |> Enum.each((fn {id, name} -> IO.binwrite file, "  #{name}\n" end))

    graph.edges
    |> Enum.each((fn [h1 | [h2|_]] ->
      user1 = Map.get(users, h1)
      user2 = Map.get(users, h2)
      IO.binwrite file, "  #{user1} -- #{user2}\n"
     end))

    IO.binwrite file, "}"
    File.close file

    graph
  end
end
