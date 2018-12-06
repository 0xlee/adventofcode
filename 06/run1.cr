coordinates = File.read_lines("input")
  .map do |line|
    if md = /(\d+), (\d+)/.match(line)
      {md[1].to_i, md[2].to_i}
    end
  end
  .compact

def boundary(coordinates, spaces = 1) # left, top, right, bottom
  {
    coordinates.map(&.[0]).min - spaces,
    coordinates.map(&.[1]).min + spaces,
    coordinates.map(&.[0]).max - spaces,
    coordinates.map(&.[1]).max + spaces,
  }
end

def distance(coordinates, x, y)
end

x1, y1, x2, y2 = boundary(coordinates)
(x1..x2).map do |x|
  (y1..y2).map do |y|
    puts [x, y]
  end
end

