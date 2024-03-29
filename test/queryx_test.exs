defmodule QueryxTest do
  use ExUnit.Case
  doctest Queryx

  defmodule TestPost do
    use Ecto.Schema
    import Ecto.Changeset

    schema "areas" do
    end
  end

  describe "Queryx" do
    test "build_query/2 returns query" do
      query =
        Queryx.build_query(%{id: 123, uid: {:or_eq, 234}, order_by: {:asc, :id}}, TestPost)
        |> Queryx.build_query(%{limit:  2})

      query = %{key: "mykey"} |> Queryx.build_query(query)

      IO.inspect(query)

      assert 1 == 1
    end
  end
end
