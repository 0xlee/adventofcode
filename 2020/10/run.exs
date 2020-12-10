defmodule Day10 do
  def run2(input) do
    run2(Enum.sort(input), 1, %{0=>1, Enum.min(input) => 1})
  end

  def run2(input, index, memo) do
    if index == Enum.count(input) do
      memo[Enum.at(input, index-1)]
    else
      n = Enum.at(input, index)
      s = for i <- 1..3, n-i >= 0 do
        memo[n-i]
      end
      |> Enum.filter(fn x -> x != nil end)
      |> Enum.sum()
      run2(input, index+1, Map.put(memo, n, s))
    end
  end
end

input =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)

# part 1
input
|> Enum.sort()
|> Enum.reduce_while({0, {0, 0, 0}}, fn x, {last, {d1, d2, d3}} ->
  case x - last do
    1 -> {:cont, {x, {d1 + 1, d2, d3}}}
    2 -> {:cont, {x, {d1, d2 + 1, d3}}}
    3 -> {:cont, {x, {d1, d2, d3 + 1}}}
    _ -> {:halt}
  end
end)
|> (fn {x, {d1, d2, d3}} -> {x + 3, {d1, d2, d3 + 1}} end).()
|> (fn {_, {d1, _, d3}} -> d1 * d3 end).()
|> IO.inspect()

# part 2
Day10.run2(input) |> IO.puts()
