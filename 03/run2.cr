def all_pixel(index, left, top, width, height)
  Range.new(left, left + width, true).map do |x|
    Range.new(top, top + height, true).map do |y|
      {x, y}
    end
  end.flatten
end

pixel_list = File.read_lines("input").map do |line|
  if md = /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/.match(line)
    {md[1].to_i, md[2].to_i, md[3].to_i, md[4].to_i, md[5].to_i}
  end
end
  .compact

hash = pixel_list
  .flat_map { |v| all_pixel(*v) }
  .group_by { |e| e }
  .map { |k, v| {k, v.size} }
  .to_h

puts pixel_list
  .map { |v| {v[0], all_pixel(*v)} }
  .map { |a| {a[0], a[1].all? { |p| hash[p] == 1 }} }
  .select { |k, v| v }
