def power_level(x, y, serial_number)
  rack_id = x + 10
  (((rack_id * y + serial_number) * rack_id) / 100) % 10 - 5
end

grid_serial_number = 1955

result = (1..298).map do |y|
  (1..298).map do |x|
    sum = (0..2).map do |yy|
      (0..2).map do |xx|
        power_level x + xx, y + yy, grid_serial_number
      end
    end.flatten.sum
    {x, y, sum}
  end
end.flatten.max_by { |x, y, sum| sum }

puts result
