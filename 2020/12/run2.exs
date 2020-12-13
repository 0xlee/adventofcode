import Enum

defmodule Day12 do
  def run(input) do
    run(input, 0, {0, 0, 10, 1})
  end

  def run(input, index, {x, y, wx, wy}) do
    if index == count(input) do
      # IO.puts(index)
      {x, y, wx, wy}
    else
      {action, value} = at(input, index)

      case {action, value} do
        {"N", v} -> {x, y, wx, wy + v}
        {"S", v} -> {x, y, wx, wy - v}
        {"E", v} -> {x, y, wx + v, wy}
        {"W", v} -> {x, y, wx - v, wy}
        {"L", 90} -> {x, y, -wy, wx}
        {"L", 270} -> {x, y, wy, -wx}
        {"R", 90} -> {x, y, wy, -wx}
        {"R", 270} -> {x, y, -wy, wx}
        {_, 180} -> {x, y, -wx, -wy}
        {"F", v} -> {x + v * wx, y + v * wy, wx, wy}
      end
      |> (fn x -> run(input, index + 1, x) end).()
    end
  end
end

input =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> map(fn line ->
    Regex.run(~r/([NSEWLRF])([0-9]+)/, line)
    |> (fn [_, action, value] -> {action, String.to_integer(value)} end).()
  end)

# part 2
input |> Day12.run() |> (fn {x, y, _, _} -> abs(x) + abs(y) end).() |> IO.inspect()
