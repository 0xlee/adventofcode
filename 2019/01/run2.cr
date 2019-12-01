def calculate(number : Int64)
  result = number.tdiv(3) - 2
  if result <= 0
    0
  else
    result + calculate(result)
  end
end

sum = File.read_lines("input")
  .map do |number|
    calculate(number.to_i64)
  end
  .sum

puts sum
