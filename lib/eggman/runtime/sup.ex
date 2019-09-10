defmodule Eggman.Runtime.Sup do
  use Supervisor

  def start_link do
    IO.puts "Eggman.Runtime.Sup#start_link"
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    IO.puts "Eggman.Runtime.Sup#init"
    children = [
      worker(Eggman.Runtime.Poller, [], restart: :permanent, shutdown: (5 * 1000)),
      worker(Eggman.Runtime.Config, [])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
