result =
  File.read("input")
  |> elem(1)
  |> String.split("\n")
  |> Enum.map(fn line -> String.split(line, "", trim: true) end)

# part 1
result
|> Enum.reduce([], fn line, acc ->
  case {line, acc} do
    {s, []} -> [s]
    {'', _} -> [[] | acc]
    {s, [h | t]} -> [h ++ s | t]
  end
end)
|> Enum.map(fn x ->
  Enum.sort(x) |> Enum.dedup() |> Enum.count()
end)
|> Enum.sum()
|> IO.puts()

# part 2
result
|> Enum.reduce([], fn line, acc ->
  case {line, acc} do
    {s, []} -> [[s]]
    {'', _} -> [[] | acc]
    {s, [h | t]} -> [h ++ [s] | t]
  end
end)
|> Enum.filter(fn x -> !Enum.empty?(x) end)
|> Enum.map(fn x ->
  x
  |> Enum.map(&MapSet.new/1)
  |> Enum.reduce(fn y, acc -> MapSet.intersection(y, acc) end)
  |> Enum.count()
end)
|> Enum.sum()
|> IO.puts()
