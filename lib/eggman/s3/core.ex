defmodule Eggman.S3.Core do
  alias ExAws.S3

  @doc false
  def list_buckets(""), do: list_buckets_base
  def list_buckets(nil), do: list_buckets_base
  def list_buckets(keyword) do
    list_buckets_base
    |> Enum.filter(&String.contains?(&1, keyword))
  end

  @doc false
  defp list_buckets_base do
    S3.list_buckets
    |> ExAws.request!
    |> Map.get(:body)
    |> Map.get(:buckets)
    |> Enum.map(&(Map.get(&1, :name)))
  end
end
