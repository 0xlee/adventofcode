import Enum
use Bitwise, only_operators: true

defmodule Day14 do
  def run(input) do
    input
    |> map(&parse/1)
    |> run(0, nil, %{})
  end

  def parse(line) do
    case String.slice(line, 0..2) do
      "mas" -> parse_mask(line)
      "mem" -> parse_mem(line)
    end
  end

  def parse_mask(line) do
    Regex.run(~r/mask = ([01X]{36})/, line)
    |> at(1)
    |> String.split("", trim: true)
    |> with_index
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
        # newvalue = bitmask(value, mask)
        # run(input, index + 1, mask, Map.put(values, addr, newvalue))
        v = setValue(addr, mask, 0, value, values)
        run(input, index + 1, mask, v)

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

  def setValue(addr, mask, index, value, result) do
    m = at(mask, index)

    case m do
      nil ->
        Map.put(result, addr, value)

      {"0", _} ->
        setValue(addr, mask, index + 1, value, result)

      {"1", pos} ->
        setValue(addr ||| 1 <<< (35 - pos), mask, index + 1, value, result)

      {"X", pos} ->
        a1 = ~~~(1 <<< (35 - pos)) &&& 0b111111111111111111111111111111111111 &&& addr
        a2 = addr ||| 1 <<< (35 - pos)
        r1 = setValue(a1, mask, index + 1, value, result)
        r2 = setValue(a2, mask, index + 1, value, r1)
        r2
    end
  end
end

input =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)

# example
input_example = [
  "mask = 000000000000000000000000000000X1001X",
  "mem[42] = 100",
  "mask = 00000000000000000000000000000000X0XX",
  "mem[26] = 1"
]

# part 2
input |> Day14.run() |> IO.inspect()
