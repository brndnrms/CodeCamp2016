defmodule HappyBeavers do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    TwitStat.Twitter.init

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, TwitStat.Router, [], [port: 4001])
    ]

    opts = [strategy: :one_for_one, name: TwitStat.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
