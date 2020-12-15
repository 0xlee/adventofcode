import Enum

defmodule Day15 do
  def run(input) do
    # part 1
    reverse(input) |> run1(count(input))

    # part 2
    map = input |> with_index |> filter(fn {_, i} -> i < count(input) - 1 end) |> Map.new()
    last_num = input |> at(-1)
    run2(map, last_num, count(input))
  end

  def run1(input, n) when n < 2020 do
    [head | tail] = input

    case find_index(tail, fn x -> x == head end) do
      nil -> [0 | input] |> run1(n + 1)
      num -> [num + 1 | input] |> run1(n + 1)
    end
  end

  def run2(map, last_num, n) when n < 30_000_000 do
    new_num =
      case map[last_num] do
        nil -> 0
        num -> n - num - 1
      end

    run2(Map.put(map, last_num, n - 1), new_num, n + 1)
  end

  def run1(input, n) do
    input |> hd |> IO.inspect()
  end

  def run2(input, last_num, _) do
    last_num |> IO.inspect()
  end
end

# Day15.run([0, 3, 6])
# Day15.run([1, 3, 2])
# Day15.run([2, 1, 3])
# Day15.run([1, 2, 3])
# Day15.run([2, 3, 4])
# Day15.run([3, 2, 1])
# Day15.run([3, 1, 2])
Day15.run([5, 1, 9, 18, 13, 8, 0])
