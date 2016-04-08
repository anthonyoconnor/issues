defmodule CLITest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1]


  test ":help returned by option parsing for -h and --help options" do
    assert parse_args(["-h", "ignore"]) == :help
    assert parse_args(["--help", "ignore"]) == :help
  end

  test "three values returned if 3 given" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "default count if 2 parameters given" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end
end
