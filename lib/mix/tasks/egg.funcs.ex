defmodule Mix.Tasks.Egg.Funcs do
  use Mix.Task

  @shortdoc "Prints Eggman Lambda Function list"

  @moduledoc """
  Prints Eggman lambda funcs information.

  mix egg.funcs
  """

  @doc false
  def run(args) do
    Application.ensure_all_started(:hackney)
    {options, _argv, _errors} = OptionParser.parse(args, strict: [debug: :boolean, filter: :string])
    keyword = Keyword.get(options, :filter)
    lmd_list_funcs(keyword)
  end

  @doc false
  defp lmd_list_funcs(keyword) do
    Mix.shell.info ""
    Mix.shell.info "Lambda Functions:"
    Mix.shell.info "----------------------"
    show_funcs(keyword)
    Mix.shell.info "----------------------"
    Mix.shell.info ""
  end

  @doc false
  defp show_funcs(keyword) do
    Eggman.Lmd.Core.list_funcs(keyword)
    |> Enum.each(&(Mix.shell.info("#{&1}")))
  end
end
