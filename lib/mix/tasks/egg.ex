defmodule Mix.Tasks.Egg do
  use Mix.Task

  @shortdoc "Prints Eggman help information"

  @moduledoc """
  Prints Eggman tasks and their information.

  mix egg
  """

  @doc false
  def run(args) do
    case args do
      [] -> general()
      _ -> Mix.raise "Invalid arguments, expected: mix egg"
    end
  end

  @doc false
  defp general() do
    Application.ensure_all_started(:eggman)
    Mix.shell.info "Eggman v#{Application.spec(:eggman, :vsn)}"
    Mix.shell.info "Serverless WAF."
    Mix.shell.info "\nAvailable tasks:\n"
    Mix.Tasks.Help.run(["--search", "egg."])
  end
end
