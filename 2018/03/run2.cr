pixel_list = File.read_lines("input").map do |line|
  index, left, top, width, height = line.scan(/\d+/).map(&.[0].to_i)
  (left...left + width).map do |x|
    (top...top + height).map do |y|
      {index, x, y}
    end
  end
end
  .flatten

hash = pixel_list
  .map { |index, x, y| {x, y} }
  .group_by(&.itself)
  .map { |point, list| {point, list.size} }
  .to_h

result = pixel_list
  .group_by(&.[0])
  .map { |index, index_points| {index, index_points.map { |_, x, y| {x, y} }} }
  .select { |index, points| points.all? { |p| hash[p] == 1 } }
  .map { |index, _| index }
  .first

puts result
