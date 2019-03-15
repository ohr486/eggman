defmodule Eggman.Cfn.Core do
  alias ExAws.Cloudformation

  def list_stacks do
    Cloudformation.list_stacks([stack_status_filters: [:delete_complete]])
    |> ExAws.request!
    |> Map.get(:body)
    |> Map.get(:stacks)
    |> Enum.map(&(Map.get(&1, :name)))
  end
end
