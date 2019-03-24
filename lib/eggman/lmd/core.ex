defmodule Eggman.Lmd.Core do
  alias ExAws.Lambda

  @doc false
  def list_funcs(""), do: list_funcs_base
  def list_funcs(nil), do: list_funcs_base
  def list_funcs(keyword) do
    list_funcs_base
    |> Enum.filter(&String.contains?(&1, keyword))
  end

  @doc false
  defp list_funcs_base do
    Lambda.list_functions
    |> ExAws.request!
    |> Map.get("Functions")
    |> Enum.map(&(Map.get(&1, "FunctionName")))
  end
end
