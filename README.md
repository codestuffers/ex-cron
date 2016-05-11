# ExCron

Cron schedule generator for Elixir.

[![Hex.pm Version](http://img.shields.io/hexpm/v/ex_cron.svg)](https://hex.pm/packages/ex_cron)
[![Hex docs](http://img.shields.io/badge/hex.pm-docs-green.svg?style=flat)](https://hexdocs.pm/ex_cron)
[![Build Status](https://travis-ci.org/codestuffers/ex-cron.png?branch=master)](https://travis-ci.org/codestuffers/ex-cron)
[![Inline docs](http://inch-ci.org/github/codestuffers/ex-cron.svg?branch=master)](http://inch-ci.org/github/codestuffers/ex-cron)

ExCron is a simple library that will generate the next instance of a [cron](https://en.wikipedia.org/wiki/Cron)
schedule or all instances within a given date range. The design and implementation of the parser and matcher are
inspired by the [Quantum](https://github.com/c-rack/quantum-elixir) library and episodes 161 and 162 of
[ElixirSips](http://elixirsips.com).

ExCron is only meant to work with cron schedules. [Repeatex](https://github.com/rcdilorenzo/repeatex) offers similar
functionality using natural English expressions.s

## Installation

Until the library is ready for release, you will need to add a reference to the github repository to use it:

  1. Add ex_cron to your list of dependencies in `mix.exs`:

        def deps do
          [{:ex_cron, github: "codestuffers/ex-cron"}]
        end

## Author

Andrew Benz (@andorbal)

## License

ExCron is released under the MIT License. See the LICENSE file for further details.
