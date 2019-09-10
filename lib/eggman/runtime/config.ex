defmodule Eggman.Runtime.Config do
  use GenServer

  def start_link do
    IO.puts "Eggman.Runtime.Config#start_link"
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    IO.puts "Eggman.Runtime.Config#init"
    {:ok, []}
  end
end
