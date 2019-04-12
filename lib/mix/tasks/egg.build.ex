defmodule Mix.Tasks.Egg.Build do
  use Mix.Task

  @shortdoc "Build CloudFormation Resource"

  @moduledoc """
  Build CloudFormation resource.

  mix egg.build
  """

  @doc false
  def run(args) do
    Application.ensure_all_started(:hackney)
    {options, _argv, _errors} = OptionParser.parse(args, strict: [debug: :boolean, filter: :string])
    keyword = Keyword.get(options, :filter)
  end
end
