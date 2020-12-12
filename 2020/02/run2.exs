check = fn [a, b, chr, str] ->
  aa = String.to_integer(a) - 1
  bb = String.to_integer(b) - 1
  IO.puts("#{aa} #{bb} #{str} #{chr} #{String.at(str, aa) == chr}, #{String.at(str, bb) == chr}")
  String.at(str, aa) == chr != (String.at(str, bb) == chr)
  # len = Enum.filter(String.split(str, "", trim: true), fn s -> s == chr end) |> length
  # len >= String.to_integer(min) and len <= String.to_integer(max)
end

count =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Enum.map(fn x ->
    check.(tl(Regex.run(~r/([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)/, x)))
  end)
  |> Enum.filter(fn x -> x end)
  |> length

IO.puts(count)
