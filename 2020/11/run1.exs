import Enum

defmodule Day11 do
  def run1(input) do
    by = input |> count()
    bx = input |> at(0) |> count()

    output =
      for {line, y} <- with_index(input) do
        for {seat, x} <- with_index(line) do
          cnt = neighbors_occupied_count(input, x, y, bx, by)

          case {seat, cnt} do
            {"L", 0} -> "#"
            {"#", n} when n >= 4 -> "L"
            _ -> seat
          end
        end
      end

    if is_equal(input, output) do
      output |> flat_map(fn x -> x end) |> filter(fn x -> x == "#" end) |> count()
    else
      run1(output)
    end
  end

  def is_equal(input1, input2) do
    s1 = input1 |> map(fn x -> join(x, "") end) |> join("")
    s2 = input2 |> map(fn x -> join(x, "") end) |> join("")
    s1 == s2
  end

  def neighbors_occupied_count(input, x, y, bx, by) do
    for dy <- -1..1, dx <- -1..1, dx != 0 or dy != 0 do
      case {x + dx, y + dy} do
        {xx, _} when xx < 0 or xx >= bx ->
          0

        {_, yy} when yy < 0 or yy >= by ->
          0

        {xx, yy} ->
          seat = input |> at(yy) |> at(xx)

          if seat == "#" do
            1
          else
            0
          end
      end
    end
    |> sum()
  end
end

input =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> map(fn x -> String.split(x, "", trim: true) end)

# part 1
Day11.run1(input) |> IO.puts()
