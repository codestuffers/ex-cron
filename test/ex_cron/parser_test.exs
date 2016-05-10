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

  ### Hour tests
  test "parse single hour" do
    assert %Cron{hours: [7]} = ExCron.Parser.parse "* 7 * * *"
  end

  test "parse multiple hours" do
    assert %Cron{hours: [6, 14]} = ExCron.Parser.parse "* 14,6 * * *"
  end

  test "parse hour wildcard" do
    hours = 0..23 |> Enum.to_list
    assert %Cron{hours: ^hours} = ExCron.Parser.parse "* * * * *"
  end

  test "parse hours with fractional wildcard" do
    assert %Cron{hours: [0,6,12,18]} = ExCron.Parser.parse "* */6 * * *"
  end

  test "parse hour range" do
    assert %Cron{hours: [10,11,12]} = ExCron.Parser.parse "* 10-12 * * *"
  end

  test "parse multiple hour ranges" do
    assert %Cron{hours: [6,10,11,12,15,16]} = ExCron.Parser.parse "* 10-12,6,15-16 * * *"
  end

  ### Month tests
  test "parse single month" do
    assert %Cron{months: [7]} = ExCron.Parser.parse "* * * 7 *"
  end

  test "parse multiple months" do
    assert %Cron{months: [6, 12]} = ExCron.Parser.parse "* * * 12,6 *"
  end

  test "parse month wildcard" do
    months = 1..12 |> Enum.to_list
    assert %Cron{months: ^months} = ExCron.Parser.parse "* * * * *"
  end

  test "parse months with fractional wildcard" do
    assert %Cron{months: [3,6,9,12]} = ExCron.Parser.parse "* * * */3 *"
  end

  test "parse month range" do
    assert %Cron{months: [10,11,12]} = ExCron.Parser.parse "* * * 10-12 *"
  end

  test "parse multiple month ranges" do
    assert %Cron{months: [3,4,6,10,11,12]} = ExCron.Parser.parse "* * * 10-12,6,3,4 *"
  end
end
