def power_level(x, y, serial_number)
  rack_id = x + 10
  (((rack_id * y + serial_number) * rack_id) / 100) % 10 - 5
end

grid_serial_number = 1955

grid = (1..300).map do |x|
  (1..300).map do |y|
    power_level x, y, grid_serial_number
  end
end

def subgrid_sum(grid, left, top, right, bottom)
  (left..right).map do |x|
    (top..bottom).map do |y|
      grid[x - 1][y - 1]
    end
  end.flatten.sum
end

result = (1..300).map do |left|
  inner_result =(1..300).map do |top|
    (1..300).map do |size|
      if left + size <= 300 && top + size <= 300
        sum = subgrid_sum grid, left, top, left+size, top+size
        { left, top, size, sum }
      end
    end.flatten.compact
  end.flatten.max_by { |_, _, _, sum| sum }
  puts "#{left} #{inner_result}"
  inner_result
end.flatten.max_by { |_, _, _, sum| sum }

puts result
