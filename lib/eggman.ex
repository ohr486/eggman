defmodule Eggman do
  use Application

  def start(_type, _args) do
    IO.puts "Eggman#start"
    Eggman.Runtime.Sup.start_link
  end

  def stop(_state) do
    IO.puts "Eggman#stop"
    :ok
  end
end
