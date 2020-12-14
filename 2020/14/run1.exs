import Enum
use Bitwise, only_operators: true

defmodule Day14 do
  def run(input) do
    input
    |> map(fn x ->
      case String.slice(x, 0..2) do
        "mas" -> parse_mask(x)
        "mem" -> parse_mem(x)
      end
    end)
    |> run(0, nil, %{})
  end

  def parse_mask(line) do
    Regex.run(~r/mask = ([01X]{36})/, line)
    |> at(1)
    |> String.split("", trim: true)
    |> with_index
    |> filter(fn {c, i} -> c != "X" end)
    |> (fn x -> {:mask, x} end).()
  end

  def parse_mem(line) do
    Regex.run(~r/mem\[([0-9]+)\] = ([0-9]+)/, line)
    |> tl
    |> (fn [addr, val] -> {:mem, {String.to_integer(addr), String.to_integer(val)}} end).()
  end

  def run(input, index, mask, values) do
    case at(input, index) do
      {:mask, newmask} ->
        run(input, index + 1, newmask, values)

      {:mem, {addr, value}} ->
        newvalue = bitmask(value, mask)
        run(input, index + 1, mask, Map.put(values, addr, newvalue))

      nil ->
        values
        |> map(fn {_, v} -> v end)
        |> sum
    end
  end

  def bitmask(value, mask) do
    reduce(mask, value, fn m, v ->
      case m do
        {"0", pos} -> ~~~(1 <<< (35 - pos)) &&& 0b111111111111111111111111111111111111 &&& v
        {"1", pos} -> v ||| 1 <<< (35 - pos)
      end
    end)
  end
end

input =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)

# example
[
  "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
  "mem[8] = 11",
  "mem[7] = 101",
  "mem[8] = 0"
]
|> Day14.run()
|> IO.puts()

# part 1
input |> Day14.run() |> IO.puts()
