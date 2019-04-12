defmodule Mix.Tasks.Egg.Pack do
  use Mix.Task

  @shortdoc "Package CloudFormation Resource"

  @moduledoc """
  Package CloudFormation resource.

  mix egg.pack
  """

  @doc false
  def run(args) do
    Application.ensure_all_started(:hackney)
    {options, _argv, _errors} = OptionParser.parse(args, strict: [debug: :boolean, filter: :string])
    keyword = Keyword.get(options, :filter)
  end
end
