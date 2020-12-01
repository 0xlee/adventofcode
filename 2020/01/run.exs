ints =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)

# 1st part
for(
  i <- ints,
  j <- ints,
  do: {i, j}
)
|> Enum.find(fn {x, y} -> x + y == 2020 end)
|> (fn {x, y} -> x * y end).()
|> IO.puts()

# 2nd part
for(
  i <- ints,
  j <- ints,
  k <- ints,
  do: {i, j, k}
)
|> Enum.find(fn {x, y, z} -> x + y + z == 2020 end)
|> (fn {x, y, z} -> x * y * z end).()
|> IO.puts()
