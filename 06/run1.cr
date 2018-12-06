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
result =
  (x1..x2).flat_map do |x|
    (y1..y2).map do |y|
      coordinates
        .map { |index, _x, _y| {index, distance(_x, _y, x, y)} }
        .reduce({-1, Int32::MAX, false}) do |acc, inc|
          if inc[1] < acc[1]
            {inc[0], inc[1], false}
          elsif inc[1] == acc[1]
            {acc[0], acc[1], true}
          else
            acc
          end
        end
    end
  end

puts result
