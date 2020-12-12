input =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)

map =
  input
  |> Enum.map(fn line ->
    Regex.scan(~r/([a-z]+ [a-z]+) bags?/, line)
    |> Enum.map(fn y -> Enum.at(y, 1) end)
  end)

loop = fn target ->
  Enum.filter(map, fn s -> Enum.any?(tl(s), fn x -> x == target end) end)
  |> Enum.map(fn x -> Enum.at(x, 0) end)
end

result =
  Enum.reduce_while(1..100, {MapSet.new([]), MapSet.new(["shiny gold"])}, fn x, {old, new} ->
    result =
      Enum.reduce(new, MapSet.new([]), fn x, acc ->
        MapSet.union(acc, MapSet.new(loop.(x)))
      end)

    newold = MapSet.union(old, new)
    diff = MapSet.difference(result, newold)

    IO.puts(
      "old: #{Enum.join(old, "-")} new: #{Enum.join(new, "-")} diff:#{Enum.join(diff, "-")}"
    )

    case Enum.count(diff) do
      0 -> {:halt, {newold, diff}}
      _ -> {:cont, {newold, diff}}
    end
  end)

IO.puts(Enum.count(elem(result, 0)) - 1)
