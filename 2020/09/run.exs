defmodule Day09 do
  def run(input, preamble) do
    run(input, preamble, preamble)
  end

  def run(input, preamble, index) do
    num = Enum.at(input, index)
    if index >= Enum.count(input) do
      {:out_of_bound}
    else
      arr = input |> Enum.drop(index - preamble) |> Enum.take(preamble)
      sums = for {a, i} <- Enum.with_index(arr), {b, j} <- Enum.with_index(arr) , i < j do
        a+b
      end |> MapSet.new

      if MapSet.member?(sums, num) do
        run(input, preamble, index+1)
      else
        {:no_sum, num}
      end
    end
  end

  def run2(input, num) do
    for {_, i} <- Enum.with_index(input), {_, j} <- Enum.with_index(input), i<j do
      arr = input |> Enum.drop(i) |> Enum.take(j-i+1) 
      s = arr |> Enum.sum
      {Enum.min(arr), Enum.max(arr), s}
    end |> Enum.filter(fn {_, _, x} -> x == num end)
  end
end

input =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)

case Day09.run(input, 25) do
  {:out_of_bound} -> IO.puts("Not found!")
  {:no_sum, num} -> IO.puts(num)
  end

#Day09.run2(input, 127) |> (fn [{a, b, _}] -> IO.puts(a+b) end).()
Day09.run2(input, 258585477) |> (fn [{a, b, _}] -> IO.puts(a+b) end).()
