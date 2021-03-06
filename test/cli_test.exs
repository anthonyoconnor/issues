defmodule CLITest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1,
                            sort_into_ascending_order: 1,
                            convert_to_list_of_maps: 1]


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


  test "sort ascending orders the correct way" do
    result = sort_into_ascending_order(fake_created_at_list(["c", "a", "b"]))
    issues = for issue <- result, do: issue["created_at"]
    assert issues == ~w{a b c}
  end

  defp fake_created_at_list(values) do
    data = for value <- values, do: [{"created_at", value}, {"other_data", "blah"}]
    convert_to_list_of_maps data
  end
end
