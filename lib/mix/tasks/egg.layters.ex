defmodule Mix.Tasks.Egg.Layers do
  use Mix.Task

  @shortdoc "Prints Eggman Lambda Layer list"

  @moduledoc """
  Prints Eggman lambda layers information.

  mix egg.layers
  """

  @doc false
  def run(args) do
    Application.ensure_all_started(:hackney)
    {options, _argv, _errors} = OptionParser.parse(args, strict: [debug: :boolean, filter: :string])
    keyword = Keyword.get(options, :filter)
    lmd_list_layers(keyword)
  end

  @doc false
  defp lmd_list_layers(keyword) do
    Mix.shell.info ""
    Mix.shell.info "Lambda Layers:"
    Mix.shell.info "----------------------"
    show_layers(keyword)
    Mix.shell.info "----------------------"
    Mix.shell.info ""
  end

  @doc false
  defp show_layers(keyword) do
    Eggman.Lmd.Core.list_layers(keyword)
    |> Enum.each(&(Mix.shell.info("#{&1}")))
  end
end
