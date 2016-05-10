defmodule ExCron.ParserTest do
  use ExUnit.Case
  doctest ExCron.Parser

  alias ExCron.Cron

  test "parse single minute" do
    assert %Cron{minutes: [7]} = ExCron.Parser.parse "7 * * * *"
  end

  test "parse multiple minutes" do
    assert %Cron{minutes: [6, 14]} = ExCron.Parser.parse "14,6 * * * *"
  end

  test "parse minute wildcard" do
    minutes = 0..59 |> Enum.to_list
    assert %Cron{minutes: ^minutes} = ExCron.Parser.parse "* * * * *"
  end

  test "parse minutes with fractional wildcard" do
    assert %Cron{minutes: [0,20,40]} = ExCron.Parser.parse "*/20 * * * *"
  end

  test "parse minute range" do
    assert %Cron{minutes: [10,11,12]} = ExCron.Parser.parse "10-12 * * * *"
  end

  test "parse multiple minute ranges" do
    assert %Cron{minutes: [6,10,11,12,15,16]} = ExCron.Parser.parse "10-12,6,15-16 * * * *"
  end
end
