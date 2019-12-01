result = File.read_lines("input").map do |line|
  _, left, top, width, height = line.scan(/\d+/).map(&.[0].to_i)
  (left...left + width).map do |x|
    (top...top + height).map do |y|
      {x, y}
    end
  end
end
  .flatten
  .group_by(&.itself)
  .count { |_, coll| coll.size > 1 }

puts result
