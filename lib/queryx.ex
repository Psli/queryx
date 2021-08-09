defmodule Queryx do
  import Ecto.Query, warn: false

  def build_query(query, criteria) when is_struct(query, Ecto.Query) and is_map(criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  def build_query(criteria, query) when is_struct(query, Ecto.Query) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  def build_query(criteria, module) do
    query = base_query(module)
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp base_query(module) do
    from(p in module)
  end

  defp compose_query({:order_by, value}, query) do
    query
    |> order_by(^value)
  end

  defp compose_query({:limit, n}, query) do
    query
    |> limit(^n)
  end

  defp compose_query({:preload, value}, query) do
    query
    |> preload(^value)
  end

  defp compose_query({key, {:eq, value}}, query) do
    query
    |> where([p], field(p, ^key) == ^value)
  end

  defp compose_query({key, {:not_eq, nil}}, query) do
    query
    |> where([p], not is_nil(field(p, ^key)))
  end

  defp compose_query({key, {:not_eq, value}}, query) do
    query
    |> where([p], field(p, ^key) != ^value)
  end

  # Greater than
  defp compose_query({key, {:gt, value}}, query) do
    query
    |> where([p], field(p, ^key) > ^value)
  end

  # Less than
  defp compose_query({key, {:lt, value}}, query) do
    query
    |> where([p], field(p, ^key) < ^value)
  end

  # Greater than or equal
  defp compose_query({key, {:gteq, value}}, query) do
    query
    |> where([p], field(p, ^key) >= ^value)
  end

  # Less than or equal
  defp compose_query({key, {:lteq, value}}, query) do
    query
    |> where([p], field(p, ^key) <= ^value)
  end

  defp compose_query({key, {:in, value}}, query) do
    query
    |> where([p], field(p, ^key) in ^value)
  end

  defp compose_query({key, {:between, begin_value, end_value}}, query) do
    query
    |> where([p], field(p, ^key) >= ^begin_value and field(p, ^key) <= ^end_value)
  end

  defp compose_query({key, nil}, query) do
    query
    |> where([p], is_nil(field(p, ^key)))
  end

  ### or_where
  defp compose_query({key, {:or_eq, value}}, query) do
    query
    |> or_where([p], field(p, ^key) == ^value)
  end

  defp compose_query({key, {:or_not_eq, nil}}, query) do
    query
    |> or_where([p], not is_nil(field(p, ^key)))
  end

  defp compose_query({key, {:or_not_eq, value}}, query) do
    query
    |> or_where([p], field(p, ^key) != ^value)
  end

  # Greater than
  defp compose_query({key, {:or_gt, value}}, query) do
    query
    |> or_where([p], field(p, ^key) > ^value)
  end

  # Less than
  defp compose_query({key, {:or_lt, value}}, query) do
    query
    |> or_where([p], field(p, ^key) < ^value)
  end

  # Greater than or equal
  defp compose_query({key, {:or_gteq, value}}, query) do
    query
    |> or_where([p], field(p, ^key) >= ^value)
  end

  # Less than or equal
  defp compose_query({key, {:or_lteq, value}}, query) do
    query
    |> or_where([p], field(p, ^key) <= ^value)
  end

  defp compose_query({key, {:or_in, value}}, query) do
    query
    |> or_where([p], field(p, ^key) in ^value)
  end

  defp compose_query({key, {:or_between, begin_value, end_value}}, query) do
    query
    |> or_where([p], field(p, ^key) >= ^begin_value and field(p, ^key) <= ^end_value)
  end

  defp compose_query({key, :or_nil}, query) do
    query
    |> or_where([p], is_nil(field(p, ^key)))
  end

  ### or_where end

  defp compose_query({key, value}, query) do
    query
    |> where([p], field(p, ^key) == ^value)
  end

  defp compose_query(_unsupported_param, query) do
    query
  end
end
