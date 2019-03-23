defmodule Eggman.Cfn.Core do
  alias ExAws.Cloudformation

  @doc false
  def list_stacks(stack_status, ""), do: list_stacks_base(stack_status)
  def list_stacks(stack_status, nil), do: list_stacks_base(stack_status)
  def list_stacks(stack_status, keyword) do
    list_stacks_base(stack_status)
    |> Enum.filter(&String.contains?(&1, keyword))
  end

  @doc false
  defp list_stacks_base(stack_status) do
    Cloudformation.list_stacks([stack_status_filters: [stack_status]])
    |> ExAws.request!
    |> Map.get(:body)
    |> Map.get(:stacks)
    |> Enum.map(&(Map.get(&1, :name)))
  end
end
