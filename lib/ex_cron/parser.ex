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
      minutes: minutes |> map_piece(0..59),
      hours: hours |> map_piece(0..23),
      days_of_month: days_of_month |> map_piece(1..31),
      months: months |> map_piece(1..12),
      days_of_week: days_of_week |> map_piece(0..6)
    }
  end

  defp map_piece("*", valid_values), do: valid_values |> Enum.to_list
  defp map_piece(value, _valid_values) do
    pieces = String.split value, ","
    pieces
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort
  end
end
