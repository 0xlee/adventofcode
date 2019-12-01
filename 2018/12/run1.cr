state = "..##.#######...##.###...#..#.#.#..#.##.#.##....####..........#..#.######..####.#.#..###.##..##..#..#"

rules = [
  {"#..#.", "."},
  {"..#..", "."},
  {"..#.#", "#"},
  {"##.#.", "."},
  {".#...", "#"},
  {"#....", "."},
  {"#####", "#"},
  {".#.##", "."},
  {"#.#..", "."},
  {"#.###", "#"},
  {".##..", "#"},
  {"##...", "."},
  {"#...#", "#"},
  {"####.", "#"},
  {"#.#.#", "."},
  {"#..##", "."},
  {".####", "."},
  {"...##", "."},
  {"..###", "#"},
  {".#..#", "."},
  {"##..#", "#"},
  {".#.#.", "."},
  {"..##.", "."},
  {"###..", "."},
  {"###.#", "#"},
  {"#.##.", "#"},
  {".....", "."},
  {".##.#", "#"},
  {"....#", "."},
  {"##.##", "#"},
  {"...#.", "#"},
  {".###.", "."},
].to_h

index = 0
(1..50000000000).each do |n|
  before = rules["..." + state[0] + state[1]]
  after = rules["" + state[state.size-2] + state[state.size-1] + "..."]

  before = before == "#" ? "#" : ""
  after = after == "#" ? "#" : ""

  if before == "#"
    index += 1
  end

  state = state.chars.map_with_index do |_, i|
    pattern = case i
    when 0
      ".." + state[i] + state[i + 1] + state[i + 2]
    when 1
      "." + state[i - 1] + state[i] + state[i + 1] + state[i + 2]
    when state.size - 2
      "" + state[i - 2] + state[i - 1] + state[i] + state[i + 1] + "."
    when state.size - 1
      "" + state[i - 2] + state[i - 1] + state[i] + ".."
    else
      "" + state[i - 2] + state[i - 1] + state[i] + state[i + 1] + state[i + 2]
    end
    rules[pattern]
  end.join
  state = before + state + after
  #state=state.join#.strip('.')
  #puts state.count('#')
  #puts state, index

  if n % 1000000 == 0
    puts n
  end
end

puts state.chars.map_with_index { |c, i| c == '#' ? i-index : 0 }.sum
