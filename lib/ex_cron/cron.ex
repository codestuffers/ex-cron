defmodule ExCron.Cron do
  @moduledoc """
  Struct that holds the pieces of a parsed cron string
  """
  
  defstruct [
    minutes: [],
    hours: [],
    days_of_month: [],
    months: [],
    days_of_week: []
  ]
end
