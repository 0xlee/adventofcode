lines = File.read_lines("input")

class State
  def initialize(@state : Array(Array(Char)))
  end

  def [](x, y)
    if x >= 0 && y >= 0 && y < @state.size && x < @state[0].size
      @state[y][x]
    else
      nil
    end
  end

  def []=(x, y, v)
    @state[y][x] = v
  end

  def all_neighbors(x, y)
    [
      self[x - 1, y - 1],
      self[x - 1, y],
      self[x - 1, y + 1],
      self[x, y - 1],
      self[x, y + 1],
      self[x + 1, y - 1],
      self[x + 1, y],
      self[x + 1, y + 1],
    ]
  end

  def next_state
    result = (0...@state.size).map do |y|
      (0...@state[y].size).map do |x|
        neighbors = self.all_neighbors(x, y)
        content = self[x, y]
        if content == '.'
          if neighbors.count { |n| n == '|' } >= 3
            '|'
          else
            '.'
          end
        elsif content == '|'
          if neighbors.count { |n| n == '#' } >= 3
            '#'
          else
            '|'
          end
        else
          if neighbors.any? { |n| n == '#' } && neighbors.any? { |n| n == '|' }
            '#'
          else
            '.'
          end
        end
      end
    end

    State.new(result)
  end

  def to_s(io)
    (0...@state.size).map do |y|
      (0...@state[y].size).map do |x|
        io << self[x, y]
      end
      io << "\n"
    end
  end

  def count(needle)
    @state.sum do |line|
      line.count { |c| c == needle }
    end
  end

  def result
    self.count('|') * self.count('#')
  end

  def empty?
    self.count('|') * self.count('#') == 0
  end
end

visited = Hash(String, Int32).new
state = State.new(lines.map(&.chars))

n = 0
nn = 1000000000
repeat = 0

while n < nn
  n += 1
  state = state.next_state
  if visited[state.to_s]?
    repeat = n - visited[state.to_s]
    if n % repeat == nn % repeat
      puts state.result
      break
    end
  end
  visited[state.to_s] = n
end
