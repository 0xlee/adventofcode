def all_pixel(left, top, width, height)
  Range.new(left, left + width, true).map do |x|
    Range.new(top, top + height, true).map do |y|
      {x, y}
    end
  end
end

result = File.read_lines("input").map do |line|
  if md = /#\d+ @ (\d+),(\d+): (\d+)x(\d+)/.match(line)
    all_pixel(md[1].to_i, md[2].to_i, md[3].to_i, md[4].to_i)
  else
    [] of Tuple(Int32, Int32)
  end
end
  .flatten
  .group_by { |e| e }
  .count { |e| e[1].size > 1 }

puts result
