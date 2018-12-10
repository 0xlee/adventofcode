rules = File.read_lines("input")
  .map_with_index do |line, index|
    if md = /Step (\w) must be finished before step (\w) can begin\./.match(line)
      {md[1].chars.first, md[2].chars.first}
    end
  end
  .compact

all_letters = rules.map { |l1, l2| [l1, l2] }.flatten.uniq.sort
letter_size = all_letters.size
result = [] of Char

while result.size < letter_size
  visited, non_visited = rules.partition { |k, v| result.includes?(k) }
  result << (all_letters - visited.map { |k, _| k } - non_visited.map { |_, v| v }).first
end

puts result.join
