arr = File.read_lines("input")
  # arr = ["R8,U5,L5,D3", "U7,R6,D4,L4"]
  # arr = ["R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83"]
  # arr = ["R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"]
  .map do |line|
    line.split(",").map { |x| parse(x) }
  end

h = {} of Tuple(Int32, Int32) => Bool
x, y = 0, 0
arr[0].each do |line|
  case line[:direction]
  when 'R'
    (1..line.[:amount]).each do |xx|
      h[{x + xx, y}] = true
    end
    x += line.[:amount]
  when 'L'
    (1..line.[:amount]).each do |xx|
      h[{x - xx, y}] = true
    end
    x -= line.[:amount]
  when 'U'
    (1..line.[:amount]).each do |yy|
      h[{x, y + yy}] = true
    end
    y += line.[:amount]
  when 'D'
    (1..line.[:amount]).each do |yy|
      h[{x, y - yy}] = true
    end
    y -= line.[:amount]
  end
end

result = [] of Int32
x, y = 0, 0
arr[1].each do |line|
  case line[:direction]
  when 'R'
    (1..line.[:amount]).each do |xx|
      if h[{x + xx, y}]?
        result.push(abs(x + xx) + abs(y))
      end
    end
    x += line.[:amount]
  when 'L'
    (1..line.[:amount]).each do |xx|
      if h[{x - xx, y}]?
        result.push(abs(x - xx) + abs(y))
      end
    end
    x -= line.[:amount]
  when 'U'
    (1..line.[:amount]).each do |yy|
      if h[{x, y + yy}]?
        result.push(abs(x) + abs(y + yy))
      end
    end
    y += line.[:amount]
  when 'D'
    (1..line.[:amount]).each do |yy|
      if h[{x, y - yy}]?
        result.push(abs(x) + abs(y - yy))
      end
    end
    y -= line.[:amount]
  end
end

puts result.min

def parse(s : String)
  m = /([RLUD])([0-9]+)/.match(s).not_nil!
  {direction: m[1][0], amount: m[2].to_i32}
end

def abs(n)
  if n >= 0
    n
  else
    -n
  end
end
