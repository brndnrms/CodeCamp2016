# HappyBeavers Team!

## Is it working?

Let's see

```
$ mix deps.get
...
$ mix test
```

If the tests run successfully, then yep, it's working.

## How to use it

```
$ iex -S mix
...
```

If you want to create a graphviz generated image:

```
> TwitStat.common_friends_graph("user1", "user2") |> Graph.save("#{user1}_#{user2}}.dot")
```

A file named "#{user1}_#{user2}.dot" should be generated, then from your shell

```
$ dot -Tpng dot_file.dot -o out_file.png
```

and you'll have a nice pic of the social network shared by `user1` and `user2`.

If you want to use the REST API:

```
$ curl i"http://localhost:4001/graph/common_friends/user1/user2"
```

and you'll get the graph data in json format.

## Examples

`d5lment` and `alcidesfp`

![d5lment and alcidesfp](https://raw.githubusercontent.com/artesanosoft/CodeCamp2016/master/happy_beavers/examples/d5lment_alcidesfp.png)

`hiphoox` and `chochosmx`

![hiphoox and chochosmx](https://raw.githubusercontent.com/artesanosoft/CodeCamp2016/master/happy_beavers/examples/hiphoox_chochosmx.png)
