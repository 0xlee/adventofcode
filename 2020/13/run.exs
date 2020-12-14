import Enum

defmodule Day13 do
  def run1(input) do
    run1(input, elem(input, 0))
  end

  def run1(input, time) do
    res = elem(input, 1) |> filter(fn {id, _} -> rem(time, id) == 0 end)

    case res do
      [] ->
        run1(input, time + 1)

      [x] ->
        elem(x, 0) * (time - elem(input, 0))
    end
  end

  def run2(input) do
    run2(elem(input, 1), elem(input, 0), 0, 1)
  end

  def run2(arr, time, index, incr) do
    {id, _} = arr |> at(index)

    res =
      arr
      |> at(index)
      |> (fn {id, idx} -> rem(time + idx, id) == 0 end).()

    case res do
      false ->
        run2(arr, time + incr, index, incr)

      true ->
        if count(arr) == index + 1 do
          time
        else
          run2(arr, time, index + 1, incr * id)
        end
    end
  end
end

input =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> (fn [n, xs] ->
        ids =
          String.split(xs, ",", trim: true)
          |> with_index()
          |> filter(fn {x, _} -> x != "x" end)
          |> map(fn {x, i} -> {String.to_integer(x), i} end)

        {String.to_integer(n), ids}
      end).()

# part 1
input |> Day13.run1() |> IO.puts()

# part 2
{939, [{17, 0}, {13, 2}, {19, 3}]} |> Day13.run2() |> IO.puts()
{939, [{67, 0}, {7, 1}, {59, 2}, {61, 3}]} |> Day13.run2() |> IO.puts()
{939, [{67, 0}, {7, 2}, {59, 3}, {61, 4}]} |> Day13.run2() |> IO.puts()
{939, [{67, 0}, {7, 1}, {59, 3}, {61, 4}]} |> Day13.run2() |> IO.puts()
{939, [{1789, 0}, {37, 1}, {47, 2}, {1889, 3}]} |> Day13.run2() |> IO.puts()
input |> Day13.run2() |> IO.puts()
