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
workers = [] of Tuple(Char, Int32)
iteration = -1

while result.size < letter_size
  iteration += 1
  workers = workers.map { |c, i| { c, i-1 } } # decrement all
  workers
    .select { |c, i| i == 0 }
    .map { |obj| workers.delete(obj) }
    .compact
    .each { |obj| result << obj[0] }
  if workers.size < 5
    visited, non_visited = rules.partition { |k, _| result.includes?(k) }
    next_candidates = all_letters - visited.map { |k, _| k } - non_visited.map { |_, v| v } - workers.map { |k, _| k }
    next_candidates.first(5 - workers.size).each do |next_element|
      workers << { next_element, 61 + (next_element - 'A') }
    end
  end

  puts iteration, workers
end

puts result
puts iteration
