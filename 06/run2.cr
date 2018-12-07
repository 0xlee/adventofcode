coordinates = File.read_lines("input")
  .map_with_index do |line, index|
    if md = /(\d+), (\d+)/.match(line)
      {index, md[1].to_i, md[2].to_i}
    end
  end
  .compact

def boundary(coordinates, spaces = 1) # left, top, right, bottom
  {
    coordinates.map(&.[1]).min - spaces,
    coordinates.map(&.[2]).min + spaces,
    coordinates.map(&.[1]).max - spaces,
    coordinates.map(&.[2]).max + spaces,
  }
end

def distance(x1, y1, x2, y2)
  (x2 - x1).abs + (y2 - y1).abs
end

x1, y1, x2, y2 = boundary(coordinates)
result = (x1..x2).flat_map do |x|
  (y1..y2).map do |y|
    sum = coordinates
      .map { |index, _x, _y| distance(_x, _y, x, y) }
      .sum
  end
end
  .select { |sum| sum < 10000 }
  .size

puts result
