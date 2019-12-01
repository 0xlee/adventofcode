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
result_map =
  (x1..x2).flat_map do |x|
    (y1..y2).map do |y|
      data = coordinates
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
      { {x, y}, data }
    end
  end

invalid_index_list = result_map
  .select { |p, data| data[2] == false && (p[0] == x1 || p[0] == x2 || p[1] == y1 || p[1] == y2) }
  .map { |_, data| {data[0], true} }
  .to_h

puts invalid_index_list

puts result_map
  .map { |_, data| data }
  .select { |data| !data[2] }
  .group_by { |data| data[0] }
  .map { |index, datas| {index, datas.size} }
  .select { |index, data| !invalid_index_list.fetch(index, false) }
  .reduce { |acc, incr| acc[1] > incr[1] ? acc : incr }[1]
