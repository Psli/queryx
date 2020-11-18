# Queryx

```elixir
defmodule News do
  use Queryx
end

%{"order_by" => {:desc, :id}}
|> Map.merge(params)
|> News.build_query()
|> Repo.all()
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `queryx` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:queryx, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/queryx](https://hexdocs.pm/queryx).

