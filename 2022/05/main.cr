class GiantCargoCrane1
  def initialize()
    @stack = [
      ['T', 'P', 'Z', 'C', 'S', 'L', 'Q', 'N'], # 1
      ['L', 'P', 'T', 'V', 'H', 'C', 'G'],      # 2
      ['D', 'C', 'Z', 'F'],                     # 3
      ['G', 'W', 'T', 'D', 'L', 'M', 'V', 'C'], # 4
      ['P', 'W', 'C'],                          # 5
      ['P', 'F', 'J', 'D', 'C', 'T', 'S', 'Z'], # 6
      ['V', 'W', 'G', 'B', 'D'],                # 7
      ['N', 'J', 'S', 'Q', 'H', 'W'],           # 8
      ['R', 'C', 'Q', 'F', 'S', 'L', 'V'],      # 9
    ]
  end

  def move(count, from_stack, to_stack)
    if count <= 0 
      return
    end
    @stack[to_stack-1].push(@stack[from_stack-1].pop())
    move(count-1, from_stack, to_stack)
  end


  def get_stack()
    return @stack
  end

  def top_of_each_stack()
    @stack.map(&.pop()).join("")
  end
end

class GiantCargoCrane2 < GiantCargoCrane1
  def move(count, from_stack, to_stack)
    @stack[to_stack-1].concat(@stack[from_stack-1].pop(count))
  end
end

gcc1 = GiantCargoCrane1.new()
gcc2 = GiantCargoCrane2.new()
File.read_lines("input").each do |line|
  m = /move (\d+) from (\d+) to (\d+)/.match(line)
  if m
    gcc1.move(m[1].to_i, m[2].to_i, m[3].to_i)
    gcc2.move(m[1].to_i, m[2].to_i, m[3].to_i)
  end
end
puts gcc1.top_of_each_stack
puts gcc2.top_of_each_stack
