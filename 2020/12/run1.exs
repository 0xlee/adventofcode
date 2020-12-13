import Enum

defmodule Day12 do
  def run(input) do
    run(input, 0, {0, 0, "E"})
  end

  def run(input, index, {x, y, d}) do
    if index == count(input) do
      IO.puts(index)
      {x, y, d}
    else
      {action, value} = at(input, index)

      case {action, value, d} do
        {"N", v, _} -> {x, y + v, d}
        {"S", v, _} -> {x, y - v, d}
        {"E", v, _} -> {x + v, y, d}
        {"W", v, _} -> {x - v, y, d}
        {"L", 90, "N"} -> {x, y, "W"}
        {"L", 90, "S"} -> {x, y, "E"}
        {"L", 90, "E"} -> {x, y, "N"}
        {"L", 90, "W"} -> {x, y, "S"}
        {"L", 270, "N"} -> {x, y, "E"}
        {"L", 270, "S"} -> {x, y, "W"}
        {"L", 270, "E"} -> {x, y, "S"}
        {"L", 270, "W"} -> {x, y, "N"}
        {"R", 90, "N"} -> {x, y, "E"}
        {"R", 90, "S"} -> {x, y, "W"}
        {"R", 90, "E"} -> {x, y, "S"}
        {"R", 90, "W"} -> {x, y, "N"}
        {"R", 270, "N"} -> {x, y, "W"}
        {"R", 270, "S"} -> {x, y, "E"}
        {"R", 270, "E"} -> {x, y, "N"}
        {"R", 270, "W"} -> {x, y, "S"}
        {_, 180, "N"} -> {x, y, "S"}
        {_, 180, "S"} -> {x, y, "N"}
        {_, 180, "E"} -> {x, y, "W"}
        {_, 180, "W"} -> {x, y, "E"}
        {"F", v, "N"} -> {x, y + v, d}
        {"F", v, "S"} -> {x, y - v, d}
        {"F", v, "E"} -> {x + v, y, d}
        {"F", v, "W"} -> {x - v, y, d}
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

# part 1
input |> Day12.run() |> (fn {x, y, _} -> abs(x) + abs(y) end).() |> IO.inspect()
