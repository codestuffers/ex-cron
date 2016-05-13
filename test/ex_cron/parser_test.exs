defmodule ExCron.ParserTest do
  use ExUnit.Case
  doctest ExCron.Parser

  alias ExCron.Cron

  test "parse single minute" do
    assert {:ok, %Cron{minutes: [7]}} = ExCron.Parser.parse "7 * * * *"
  end

  test "parse multiple minutes" do
    assert {:ok, %Cron{minutes: [6, 14]}} = ExCron.Parser.parse "14,6 * * * *"
  end

  test "parse minute wildcard" do
    minutes = 0..59 |> Enum.to_list
    assert {:ok, %Cron{minutes: ^minutes}} = ExCron.Parser.parse "* * * * *"
  end

  test "parse minutes with fractional wildcard" do
    assert {:ok, %Cron{minutes: [0,20,40]}} = ExCron.Parser.parse "*/20 * * * *"
  end

  test "parse minute range" do
    assert {:ok, %Cron{minutes: [10,11,12]}} = ExCron.Parser.parse "10-12 * * * *"
  end

  test "parse multiple minute ranges" do
    assert {:ok, %Cron{minutes: [6,10,11,12,15,16]}} = ExCron.Parser.parse "10-12,6,15-16 * * * *"
  end

  ### Hour tests
  test "parse single hour" do
    assert {:ok, %Cron{hours: [7]}} = ExCron.Parser.parse "* 7 * * *"
  end

  test "parse multiple hours" do
    assert {:ok, %Cron{hours: [6, 14]}} = ExCron.Parser.parse "* 14,6 * * *"
  end

  test "parse hour wildcard" do
    hours = 0..23 |> Enum.to_list
    assert {:ok, %Cron{hours: ^hours}} = ExCron.Parser.parse "* * * * *"
  end

  test "parse hours with fractional wildcard" do
    assert {:ok, %Cron{hours: [0,6,12,18]}} = ExCron.Parser.parse "* */6 * * *"
  end

  test "parse hour range" do
    assert {:ok, %Cron{hours: [10,11,12]}} = ExCron.Parser.parse "* 10-12 * * *"
  end

  test "parse multiple hour ranges" do
    assert {:ok, %Cron{hours: [6,10,11,12,15,16]}} = ExCron.Parser.parse "* 10-12,6,15-16 * * *"
  end

  ### Day of month tests
  test "parse single day of month" do
    assert {:ok, %Cron{days_of_month: [7]}} = ExCron.Parser.parse "* * 7 * *"
  end

  test "parse multiple days of month" do
    assert {:ok, %Cron{days_of_month: [6, 14]}} = ExCron.Parser.parse "* * 14,6 * *"
  end

  test "parse day of month wildcard" do
    days_of_month = 1..31 |> Enum.to_list
    assert {:ok, %Cron{days_of_month: ^days_of_month}} = ExCron.Parser.parse "* * * * *"
  end

  test "parse days of month with fractional wildcard" do
    assert {:ok, %Cron{days_of_month: [10,20,30]}} = ExCron.Parser.parse "* * */10 * *"
  end

  test "parse day of month range" do
    assert {:ok, %Cron{days_of_month: [10,11,12]}} = ExCron.Parser.parse "* * 10-12 * *"
  end

  test "parse multiple day of month ranges" do
    assert {:ok, %Cron{days_of_month: [6,10,11,12,15,16]}} = ExCron.Parser.parse "* * 10-12,6,15-16 * *"
  end

  ### Month tests
  test "parse single month" do
    assert {:ok, %Cron{months: [7]}} = ExCron.Parser.parse "* * * 7 *"
    assert {:ok, %Cron{months: [7]}} = ExCron.Parser.parse "* * * jul *"
  end

  test "parse multiple months" do
    assert {:ok, %Cron{months: [6, 12]}} = ExCron.Parser.parse "* * * 12,6 *"
    assert {:ok, %Cron{months: [6, 12]}} = ExCron.Parser.parse "* * * DEC,JUN *"
  end

  test "parse month wildcard" do
    months = 1..12 |> Enum.to_list
    assert {:ok, %Cron{months: ^months}} = ExCron.Parser.parse "* * * * *"
  end

  test "parse months with fractional wildcard" do
    assert {:ok, %Cron{months: [3,6,9,12]}} = ExCron.Parser.parse "* * * */3 *"
  end

  test "parse month range" do
    assert {:ok, %Cron{months: [10,11,12]}} = ExCron.Parser.parse "* * * 10-12 *"
    assert {:ok, %Cron{months: [10,11,12]}} = ExCron.Parser.parse "* * * OCT-dec *"
  end

  test "parse multiple month ranges" do
    assert {:ok, %Cron{months: [3,4,6,10,11,12]}} = ExCron.Parser.parse "* * * 10-12,6,3-4 *"
    assert {:ok, %Cron{months: [3,4,6,10,11,12]}} = ExCron.Parser.parse "* * * oct-dec,jun,MAR-APR *"
  end

  ### Day of week tests
  test "parse single day of week" do
    assert {:ok, %Cron{days_of_week: [4]}} = ExCron.Parser.parse "* * * * 4"
    assert {:ok, %Cron{days_of_week: [4]}} = ExCron.Parser.parse "* * * * THU"
    assert {:ok, %Cron{days_of_week: [4]}} = ExCron.Parser.parse "* * * * thu"
  end

  test "parse multiple days of week" do
    assert {:ok, %Cron{days_of_week: [3, 6]}} = ExCron.Parser.parse "* * * * 6,3"
    assert {:ok, %Cron{days_of_week: [3, 6]}} = ExCron.Parser.parse "* * * * SAT,WED"
  end

  test "parse day of week wildcard" do
    days_of_week = 0..6 |> Enum.to_list
    assert {:ok, %Cron{days_of_week: ^days_of_week}} = ExCron.Parser.parse "* * * * *"
  end

  test "parse days of week with fractional wildcard" do
    assert {:ok, %Cron{days_of_week: [0,3,6]}} = ExCron.Parser.parse "* * * * */3"
  end

  test "parse day of week range" do
    assert {:ok, %Cron{days_of_week: [1, 2, 3]}} = ExCron.Parser.parse "* * * * 1-3"
    assert {:ok, %Cron{days_of_week: [1, 2, 3]}} = ExCron.Parser.parse "* * * * MON-WED"
  end

  test "parse multiple day of week ranges" do
    assert {:ok, %Cron{days_of_week: [0, 2, 3, 4, 5, 6]}} = ExCron.Parser.parse "* * * * 4-6,0,2-3"
    assert {:ok, %Cron{days_of_week: [0, 2, 3, 4, 5, 6]}} = ExCron.Parser.parse "* * * * THU-SAT,SUN,TUE-WED"
  end

  ### Errors
  test "returns error when there are not enough sections" do
    assert {:error, _} = ExCron.Parser.parse "* * *"
    assert {:error, "not enough sections; 5 are required"} = ExCron.Parser.parse "* * * *"
  end

  test "returns error when there are too many sections" do
    assert {:error, _} = ExCron.Parser.parse "* * * * * *"
    assert {:error, "too many sections; 5 are required"} = ExCron.Parser.parse "* * * * * * *"
  end

  test "error when minute has invalid character" do
    assert {:error, _} = ExCron.Parser.parse "X * * * *"
  end

  test "error when minute has invalid character in range" do
    assert {:error, _} = ExCron.Parser.parse "3-X * * * *"
  end

  test "error when minute has invalid character in multiple" do
    assert {:error, _} = ExCron.Parser.parse "3,X * * * *"
  end

  test "error when hour has invalid character" do
    assert {:error, _} = ExCron.Parser.parse "* X * * *"
  end

  test "error when hour has invalid character in range" do
    assert {:error, _} = ExCron.Parser.parse "* 3-X * * *"
  end

  test "error when hour has invalid character in multiple" do
    assert {:error, _} = ExCron.Parser.parse "* 3,X * * *"
  end

  test "error when day_of_month has invalid character" do
    assert {:error, _} = ExCron.Parser.parse "* * X * *"
  end

  test "error when day_of_month has invalid character in range" do
    assert {:error, _} = ExCron.Parser.parse "* * 3-X * *"
  end

  test "error when day_of_month has invalid character in multiple" do
    assert {:error, _} = ExCron.Parser.parse "* * 3,X * *"
  end

  test "error when month has invalid character" do
    assert {:error, _} = ExCron.Parser.parse "* * * X *"
  end

  test "error when month has invalid character in range" do
    assert {:error, _} = ExCron.Parser.parse "* * * 3-X *"
  end

  test "error when month has invalid character in multiple" do
    assert {:error, _} = ExCron.Parser.parse "* * * 3,X *"
  end

  test "error when day_of_week has invalid character" do
    assert {:error, _} = ExCron.Parser.parse "* * * * X"
  end

  test "error when day_of_week has invalid character in range" do
    assert {:error, _} = ExCron.Parser.parse "* * * * 3-X"
  end

  test "error when day_of_week has invalid character in multiple" do
    assert {:error, _} = ExCron.Parser.parse "* * * * 3,X"
  end
end
