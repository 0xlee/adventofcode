at = fn list, x, y ->
  row = Enum.at(list, y)
  Enum.at(row, rem(x, Enum.count(row)))
end

map =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Enum.map(fn line -> String.split(line, "", trim: true) end)

run = fn step ->
  result =
    Enum.reduce_while(1..1000, [[], [0, 0]], fn _, [acc, [x, y]] ->
      if y < Enum.count(map) do
        {:cont, [acc ++ [at.(map, x, y)], step.(x, y)]}
      else
        {:halt, [acc, x, y]}
      end
    end)

  Enum.at(result, 0) |> Enum.filter(fn x -> x == "#" end) |> Enum.count()
end

# part 1
run.(fn x, y -> [x + 3, y + 1] end) |> IO.puts()

# part 2
[
  fn x, y -> [x + 1, y + 1] end,
  fn x, y -> [x + 3, y + 1] end,
  fn x, y -> [x + 5, y + 1] end,
  fn x, y -> [x + 7, y + 1] end,
  fn x, y -> [x + 1, y + 2] end
]
|> Enum.map(fn step -> run.(step) end)
|> Enum.reduce(1, fn x, acc -> x * acc end)
|> IO.puts()
