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
end
