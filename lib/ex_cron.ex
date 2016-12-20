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

      iex> ExCron.next "5 20 * DEC MON-WED", {{2016, 5, 10},{22, 13, 13}}
      {{2016, 12, 5}, {20, 5, 0}}

  """
  def next(cron_string, start = {{_,_,_},{_,_,_}}) do
    {:ok, cron} = Parser.parse cron_string
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

  defp is_match(cron = %Cron{}, {{year, month, day},{hour, minute, _}}) do
    # Convert 1..7 - Monday..Sunday, to 0..6 - Sunday..Saturday
    day_of_week = rem(:calendar.day_of_the_week(year, month, day), 7)

    matches = [
      cron.minutes |> Enum.any?(&(&1 == minute)),
      cron.hours |> Enum.any?(&(&1 == hour)),
      cron.days_of_month |> Enum.any?(&(&1 == day)),
      cron.months |> Enum.any?(&(&1 == month)),
      cron.days_of_week |> Enum.any?(&(&1 == day_of_week))
    ]
    matches |> Enum.all?
  end

  @doc ~S"""
  Gets the date and time of all instances of a cron schedule between the
  given dates and times.

  ## Examples
      iex> ExCron.within "* * * * *", {{2016, 5, 10},{22, 13, 13}}, {{2016, 5, 10},{22, 15, 13}}
      [{{2016, 5, 10}, {22, 14, 0}}, {{2016, 5, 10}, {22, 15, 0}},]

  """
  def within(cron_string, start = {{_,_,_},{_,_,_}}, ending = {{_,_,_},{_,_,_}}) do
    {:ok, cron} = Parser.parse cron_string
    start_seconds = to_seconds start
    end_seconds = to_seconds ending

    do_within cron, start_seconds, end_seconds, []
  end

  defp do_within(cron = %Cron{}, seconds, seconds_end, dates) when seconds < seconds_end do
    date = :calendar.gregorian_seconds_to_datetime seconds

    dates = case is_match cron, date do
      true -> [date | dates]
      _ -> dates
    end

     do_within cron, seconds + 60, seconds_end, dates
  end
  defp do_within(_, _, _, dates), do: dates |> Enum.reverse
end
