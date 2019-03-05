defmodule EggmanTest do
  use ExUnit.Case
  doctest Eggman

  test "greets the world" do
    assert Eggman.hello() == :world
  end
end
