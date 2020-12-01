ints =
  File.read("input1")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)

for(
  i <- ints,
  j <- ints,
  k <- ints,
  do: {i, j, k}
)
|> Enum.find(fn {x, y, z} -> x + y + z == 2020 end)
|> (fn {x, y, z} -> x * y * z end).()
|> IO.puts()
