defmodule Mix.Tasks.Egg.Status do
  use Mix.Task

  @shortdoc "Prints Eggman App status"

  @moduledoc """
  Prints Eggman app information.

  mix egg.status
  """

  @doc false
  def run(args) do
    Application.ensure_all_started(:hackney)
    {options, _argv, _errors} = OptionParser.parse(args, strict: [debug: :boolean, cfn: :string])
    cfn_list_status
  end

  @doc false
  defp cfn_list_status do
    Mix.shell.info ""
    Mix.shell.info "Cloudformation Stacks:"
    Mix.shell.info "----------------------"
    [
      :create_complete,
      :update_complete,
      :update_rollback_complete,
      :rollback_complete,
      :delete_complete,
    ]
    |> Enum.each(&show_stacks(&1))
    Mix.shell.info "----------------------"
    Mix.shell.info ""
  end

  @doc false
  defp show_stacks(stack_status) do
    Eggman.Cfn.Core.list_stacks(stack_status)
    |> Enum.each(&(Mix.shell.info("[#{stack_status}] #{&1}")))
  end
end
