defmodule ExCronTest do
  use ExUnit.Case
  doctest ExCron

  test "next gets the next instance" do
    assert {{2016,5,10},{23,9,0}} = ExCron.next "9 * * * *", {{2016,5,10},{22,10,12}}
  end

  test "next gets the next instance when it is a Sunday" do
    assert {{2016,12,25},{0,0,0}} = ExCron.next "* * * * 0", {{2016,12,19},{22,10,12}}
  end

  test "within gets a list of insteances within the date range" do
    dates = ExCron.within "10 20 * OCT-DEC TUE-THU", {{2016,5,10},{23,9,0}}, {{2016,10,8},{6,30,12}}
    assert dates == [{{2016,10,4},{20,10,0}},{{2016,10,5},{20,10,0}},{{2016,10,6},{20,10,0}}]
  end

  test "within gets a large number of results" do
    dates = ExCron.within "* * * * *", {{2016,5,10},{23,9,0}}, {{2016,10,8},{6,30,12}}
    assert Enum.count(dates) == 216442
  end
end
