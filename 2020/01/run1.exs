ints =
  File.read("input1")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)

for(
  i <- ints,
  j <- ints,
  do: {i, j}
)
|> Enum.find(fn {x, y} -> x + y == 2020 end)
|> (fn {x, y} -> x * y end).()
|> IO.puts()
