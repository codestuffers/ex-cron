defmodule ExCronTest do
  use ExUnit.Case
  doctest ExCron

  test "next gets the next instance" do
    assert {{2016,5,10},{23,9,0}} = ExCron.next "9 * * * *", {{2016,5,10},{22,10,12}}
  end
end
