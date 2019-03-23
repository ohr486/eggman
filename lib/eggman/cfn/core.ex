defmodule Eggman.Cfn.Core do
  alias ExAws.Cloudformation

  @doc false
  def list_stacks(stack_status, keyword) do
    Cloudformation.list_stacks([stack_status_filters: [stack_status]])
    |> ExAws.request!
    |> Map.get(:body)
    |> Map.get(:stacks)
    |> Enum.map(&(Map.get(&1, :name)))
    |> Enum.filter(&String.contains?(&1, keyword))
  end
end
