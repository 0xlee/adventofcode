result =
  File.read("input")
  |> elem(1)
  |> String.split("\n")
  |> Enum.map(fn line -> String.split(line, "", trim: true) end)
  |> Enum.reduce([], fn line, acc ->
    case {line, acc} do
      {s, []} -> [s]
      {'', _} -> ["" | acc]
      {s, [h | t]} -> [Enum.join([h, s], " ") | t]
    end
  end)
  |> Enum.map(fn x ->
    Enum.map(Regex.scan(~r/([a-z]{3}):([^ ]+)/, x), fn [_, k, v] ->
      {String.to_atom(k), v}
    end)
    |> Enum.into(%{})
  end)

# part 1
result
|> Enum.filter(fn x -> Map.has_key?(x, :byr) end)
|> Enum.filter(fn x -> Map.has_key?(x, :iyr) end)
|> Enum.filter(fn x -> Map.has_key?(x, :eyr) end)
|> Enum.filter(fn x -> Map.has_key?(x, :hgt) end)
|> Enum.filter(fn x -> Map.has_key?(x, :hcl) end)
|> Enum.filter(fn x -> Map.has_key?(x, :ecl) end)
|> Enum.filter(fn x -> Map.has_key?(x, :pid) end)
|> Enum.count()
|> IO.puts()

# part 2
range_predicate = fn min, max ->
  fn value ->
    n = String.to_integer(value)
    n >= min and n <= max
  end
end

regex_predicate = fn r ->
  fn value ->
    Regex.match?(r, value)
  end
end

haircolor = MapSet.new(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])

haircolor_predicate = fn value ->
  MapSet.member?(haircolor, value)
end

height_predicate = fn value ->
  cond do
    Regex.match?(~r/([0-9]+)cm/, value) ->
      n = String.to_integer(Enum.at(Regex.run(~r/([0-9]+)cm/, value), 1))
      n >= 150 and n <= 193

    Regex.match?(~r/([0-9]+)in/, value) ->
      true
      n = String.to_integer(Enum.at(Regex.run(~r/([0-9]+)in/, value), 1))
      n >= 59 and n <= 76

    true ->
      false
  end
end

filter_predicate = fn x, key, predicate ->
  Map.has_key?(x, key) and predicate.(Map.get(x, key))
end

result
|> Enum.filter(fn x -> filter_predicate.(x, :byr, range_predicate.(1920, 2002)) end)
|> Enum.filter(fn x -> filter_predicate.(x, :iyr, range_predicate.(2010, 2020)) end)
|> Enum.filter(fn x -> filter_predicate.(x, :eyr, range_predicate.(2020, 2030)) end)
|> Enum.filter(fn x -> filter_predicate.(x, :hgt, height_predicate) end)
|> Enum.filter(fn x -> filter_predicate.(x, :hcl, regex_predicate.(~r/^#[0-9a-f]{6}$/)) end)
|> Enum.filter(fn x -> filter_predicate.(x, :ecl, haircolor_predicate) end)
|> Enum.filter(fn x -> filter_predicate.(x, :pid, regex_predicate.(~r/^[0-9]{9}$/)) end)
|> Enum.count()
|> IO.puts()
