defmodule ExCron do
  alias ExCron.Cron
  alias ExCron.Parser

  @moduledoc """
  Ex-Cron is a library for generating scheduled dates based on a given
  cron pattern.
  """

  @doc ~S"""
  Gets the date and time of the next instance of a cron schedule after the
  specified date and time.

  ## Examples
      iex> ExCron.next "* * * * *", {{2016, 5, 10},{22, 13, 13}}
      {{2016, 5, 10}, {22, 14, 0}}

  """
  def next(cron_string, start = {{_,_,_},{_,_,_}}) do
    cron = Parser.parse cron_string
    start_seconds = to_seconds start

    do_next cron, start_seconds
  end

  defp to_seconds(start = {{_,_,_},{_,_,0}}) do
    :calendar.datetime_to_gregorian_seconds(start)
  end
  defp to_seconds(start = {{_,_,_},{_,_,seconds}}) do
    :calendar.datetime_to_gregorian_seconds(start) + 60 - seconds
  end

  defp do_next(cron = %Cron{}, seconds) do
    date = :calendar.gregorian_seconds_to_datetime seconds

    case is_match cron, date do
      true -> date
      _ -> do_next cron, seconds + 60
    end
  end

  defp is_match(cron = %Cron{}, {{_, month, day},{hour, minute, _}}) do
    cron.minutes
      |> Enum.any?(&(&1 == minute))
  end

  @doc ~S"""
  Gets the date and time of all instances of a cron schedule between the
  given dates and times.

  ## Examples
      iex> ExCron.within "* * * * *", {{2016, 5, 10},{22, 13, 13}}, {{2016, 5, 10},{22, 15, 13}}
      [{{2016, 5, 10}, {22, 14, 0}}, {{2016, 5, 10}, {22, 15, 0}},]

  """
  def within(cron_string, start = {{_,_,_},{_,_,_}}, ending = {{_,_,_},{_,_,_}}) do
    [{{2016,5,10},{22,14,0}},{{2016,5,10},{22,15,0}}]
  end
end
