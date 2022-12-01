#!/usr/bin/env elixir

File.read!("input")
  |> String.split("\n\n", trim: true)
  |> Enum.map(fn line -> line
    |> String.split("\n", trim: true) 
    |> Enum.map(&String.to_integer/1) 
    |> Enum.sum()
  end)
  |> Enum.max()
  |> IO.puts()

File.read!("input")
  |> String.split("\n\n", trim: true)
  |> Enum.map(fn line -> line
    |> String.split("\n", trim: true) 
    |> Enum.map(&String.to_integer/1) 
    |> Enum.sum()
  end)
  |> Enum.sort(:desc)
  |> Enum.take(3)
  |> Enum.sum()
  |> IO.puts()
