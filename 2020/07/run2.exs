defmodule Day07 do
  def contains(map, target) do
    map[target]
    |> Enum.map(fn x ->
      case x do
        nil ->
          0

        {n, s} ->
          n + n * contains(map, s)
      end
    end)
    |> Enum.sum()
  end
end

input =
  File.read("input")
  |> elem(1)
  |> String.split("\n", trim: true)

map =
  input
  |> Enum.map(fn line ->
    String.split(line, ["bags contain", "bags,", "bag,", "bags.", "bag."], trim: true)
    |> Enum.map(&String.trim/1)
    |> (fn arr ->
          {String.to_atom(Enum.join(String.split(hd(arr), " "), "")),
           Enum.map(tl(arr), fn x ->
             {n, s} = String.split_at(x, 1)

             case {n, s} do
               {"n", _} ->
                 nil

               {ns, str} ->
                 {String.to_integer(ns),
                  String.to_atom(Enum.join(String.split(String.trim(str), " "), ""))}
             end
           end)}
        end).()
  end)

Day07.contains(map, :shinygold) |> IO.puts()
