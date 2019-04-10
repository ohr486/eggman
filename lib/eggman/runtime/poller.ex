defmodule Eggman.Runtime.Poller do
  use GenServer

  def start_link do
    IO.puts "Eggman.Runtime.Poller#start_link"
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    IO.puts "Eggman.Runtime.Poller#init"
    {:ok, []}
  end
end
