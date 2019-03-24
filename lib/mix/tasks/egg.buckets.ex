defmodule Mix.Tasks.Egg.Buckets do
  use Mix.Task

  @shortdoc "Prints Eggman S3 bucket list"

  @moduledoc """
  Prints Eggman s3 bucket information.

  mix egg.buckets
  """

  @doc false
  def run(args) do
    Application.ensure_all_started(:hackney)
    {options, _argv, _errors} = OptionParser.parse(args, strict: [debug: :boolean, filter: :string])
    keyword = Keyword.get(options, :filter)
    s3_list_buckets(keyword)
  end

  @doc false
  defp s3_list_buckets(keyword) do
    Mix.shell.info ""
    Mix.shell.info "S3 Buckets:"
    Mix.shell.info "----------------------"
    show_buckets(keyword)
    Mix.shell.info "----------------------"
    Mix.shell.info ""
  end

  @doc false
  defp show_buckets(keyword) do
    Eggman.S3.Core.list_buckets(keyword)
    |> Enum.each(&(Mix.shell.info("#{&1}")))
  end
end
