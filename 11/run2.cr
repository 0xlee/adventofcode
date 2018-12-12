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
  (left...right).map do |x|
    (top...bottom).map do |y|
      grid[x - 1][y - 1]
    end
  end.flatten.sum
end

def subgrid_vsum(vgrid, left, top, right)
  (left...right).map do |x|
    vgrid[x - 1][top - 1]
  end.flatten.sum
end

def vert_grid(grid, size)
  (1..300).map do |x|
    (1..300 - size + 1).map do |y|
      if y + size <= 301
        (y...y + size).map { |yy| grid[x - 1][yy - 1] }
      end
    end.compact
  end
end

result = (1..300).map do |size|
  vgrid = vert_grid grid, size
  inner_result = (1..300).map do |left|
    (1..300).map do |top|
      if left + size <= 301 && top + size <= 301
        sum = subgrid_vsum vgrid, left, top, left + size
        {left, top, size, sum}
      end
    end.flatten.compact
  end.flatten.max_by { |_, _, _, sum| sum }
  puts "#{size} #{inner_result}"
  inner_result
end.flatten.max_by { |_, _, _, sum| sum }

puts result
