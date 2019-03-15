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
    debug_flag = options |> Keyword.get(:debug)
    options |> Keyword.get(:cfn) |> cfn_status(debug_flag)
  end

  @doc false
  defp cfn_status(stack_name, debug_flag) do
    IO.puts "debug=[#{debug_flag}]"
    IO.puts "stack_name=[#{stack_name}]"
    IO.inspect Eggman.Cfn.Core.list_stacks
  end
end
