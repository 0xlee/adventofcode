defmodule Day08 do
  def run1(input) do
    run(input, 0, 0, %{}, -1)
  end

  def run2(input) do
    0..(Enum.count(input) - 1)
    |> Enum.map(fn swap ->
      # |> elem(0) |> (fn x -> IO.puts("#{swap}") end).()
      run(input, 0, 0, %{}, swap)
    end)
    |> Enum.filter(fn {result, _, _} -> result == :terminated end)
  end

  def run(input, inst, acc, visited, swap) do
    {op, arg} = Enum.at(input, inst)
    v = Map.put(visited, inst, true)

    {new_inst, new_acc} =
      case {op, inst} do
        {"nop", inst} when inst == swap -> {inst + arg, acc}
        {"nop", inst} -> {inst + 1, acc}
        {"acc", inst} -> {inst + 1, acc + arg}
        {"jmp", inst} when inst == swap -> {inst + 1, acc}
        {"jmp", inst} -> {inst + arg, acc}
      end

    cond do
      new_inst >= Enum.count(input) ->
        {:terminated, new_inst, new_acc}

      Map.has_key?(visited, new_inst) ->
        {:loop, new_inst, new_acc}

      true ->
        run(input, new_inst, new_acc, v, swap)
    end
  end
end

input =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Enum.map(fn line ->
    Regex.run(~r/([a-z]{3}) ([-+][0-9]+)/, line)
    |> (fn [_, op, arg] -> {op, String.to_integer(arg)} end).()
  end)

# part 1
{:loop, _, acc} = Day08.run1(input)
IO.puts(acc)

# part 2
[{:terminated, _, acc} | _] = Day08.run2(input)
IO.puts(acc)
