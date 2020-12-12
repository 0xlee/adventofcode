use Bitwise

result =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Enum.map(fn line ->
    cs = String.split(line, "", trim: true)

    Enum.reduce(cs, 0, fn x, acc ->
      case x do
        "F" ->
          acc <<< 1 ||| 0

        "B" ->
          acc <<< 1 ||| 1

        "L" ->
          acc <<< 1 ||| 0

        "R" ->
          acc <<< 1 ||| 1
      end
    end)
  end)

# part 1
result
|> Enum.max()
|> IO.puts()

# part 2
result
|> Enum.sort()
|> Enum.reduce(0, fn seatId, acc ->
  case {seatId, acc} do
    {l, 0} ->
      l

    {l, n} when l == n + 1 ->
      l

    # here printing missing
    {l, n} when l == n + 2 ->
      IO.puts(n + 1)
      l

    {l, n} ->
      IO.puts("ERROR: #{l}, #{n}")
  end
end)
