defmodule ExCron.Parser do
  alias ExCron.Cron

  @moduledoc """
  Module that parses a cron string into a representation that can be used
  by code.
  """

  @doc ~S"""
  Parse a cron string into a tuple

  ## Example
      iex> ExCron.Parser.parse "0 0 0 0 *"
      %ExCron.Cron{minutes: [0], hours: [0], days_of_month: [0], months: [0], days_of_week: [0,1,2,3,4,5,6]}

  """
  def parse(cron) do
    [minutes, hours, days_of_month, months, days_of_week] = String.split cron, " ", parts: 5

    %Cron{
      minutes: minutes |> parse_piece(0..59),
      hours: hours |> parse_piece(0..23),
      days_of_month: days_of_month |> parse_piece(1..31),
      months: months |> parse_piece(1..12),
      days_of_week: days_of_week |> parse_piece(0..6, get_name_mapper(~w(SUN MON TUE WED THU FRI SAT)))
    }
  end

  defp parse_piece(piece, valid_values), do: parse_piece piece, valid_values, &String.to_integer/1
  defp parse_piece("*/" <> fractional, valid_values, _mapper) do
    fractional_value = String.to_integer fractional
    valid_values
      |> Enum.filter(&(0 == rem(&1, fractional_value)))
      |> Enum.to_list
  end
  defp parse_piece("*", valid_values, _mapper), do: valid_values |> Enum.to_list
  defp parse_piece(value, _valid_values, mapper) do
    pieces = String.split value, ","
    pieces
      |> Enum.map(&(parse_piece_value(&1, mapper)))
      |> List.flatten
      |> Enum.sort
  end

  defp parse_piece_value(value, mapper) do
    pieces = String.split value, "-"
    {min_value, max_value} = pieces
      |> Enum.map(mapper)
      |> Enum.min_max
    min_value..max_value
      |> Enum.to_list
  end

  defp get_name_mapper(lookup) do
    fn x ->
      case Enum.find_index(lookup, &(&1 == x)) do
        nil -> String.to_integer(x)
        val -> val
      end
    end
  end
end
