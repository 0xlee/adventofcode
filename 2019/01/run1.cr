def calculate(number : Int64)
  number.tdiv(3) - 2
end

sum = File.read_lines("input")
  .map do |number|
    calculate(number.to_i64)
  end
  .sum

puts sum
