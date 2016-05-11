# ExCron

ExCron is a simple library that will generate the next instance of a [cron](https://en.wikipedia.org/wiki/Cron) schedule or all instances within a given date range. The design and implementation of the parser and matcher are inspired by the [Quantum](https://github.com/c-rack/quantum-elixir) library and episodes 161 and 162 of [ElixirSips](http://elixirsips.com).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add ex_cron to your list of dependencies in `mix.exs`:

        def deps do
          [{:ex_cron, "~> 0.0.1"}]
        end

  2. Ensure ex_cron is started before your application:

        def application do
          [applications: [:ex_cron]]
        end

