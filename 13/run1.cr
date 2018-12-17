grid = File.read_lines("input").map { |line| line.chars }

#grid = grid.map_with_index do |line, y|
#  line.map_with_index do |field, x|
#    { x: x, y: y, field: field, count: 0, moved: false }
#  end
#end

moving_parts = grid.map_with_index do |line, y|
  line
    .map_with_index { |field, x| {x, y, field, 0} }
    .select { |_, _, field| field == '>' || field == '<' || field == 'v' || field == '^' }
end.flatten

def move(grid : Array(Array(Char)), moving_parts : Array(Tuple(Int32, Int32, Char, Int32)))
  moving_parts.map do |x, y, field, count|
    case field
    when '>'
      case grid[y][x + 1]
      when ' '
        raise "ERROR"
      when '\\'
        {x + 1, y, 'v', count}
      when '/'
        {x + 1, y, '^', count}
      when '+'
        {x + 1, y, dir('>', count), (count+1)%3}
      else
        {x + 1, y, '>', count}
      end
    when '<'
      case grid[y][x - 1]
      when ' '
        raise "ERROR"
      when '\\'
        {x - 1, y, '^', count}
      when '/'
        {x - 1, y, 'v', count}
      when '+'
        {x - 1, y, dir('<', count), (count+1)%3}
      else
        {x - 1, y, '<', count}
      end
    when 'v'
      case grid[y + 1][x]
      when ' '
        raise "ERROR"
      when '\\'
        {x, y + 1, '>', count}
      when '/'
        {x, y + 1, '<', count}
      when '+'
        {x, y+1, dir('v', count), (count+1)%3}
      else
        {x, y + 1, 'v', count}
      end
    when '^'
      case grid[y - 1][x]
      when ' '
        raise "ERROR"
      when '\\'
        {x, y - 1, '<', count}
      when '/'
        {x, y - 1, '>', count}
      when '+'
        {x, y-1, dir('^', count), (count+1)%3}
      else
        {x, y - 1, '^', count}
      end
    end
  end.compact
end

def dir(current_direction, num)
  case current_direction
  when '>'
    case num
    when 0
      '^'
    when 1
      '>'
    when 2
      'v'
    else
      raise "ERROR"
    end
  when '<'
    case num
    when 0
      'v'
    when 1
      '<'
    when 2
      '^'
    else
      raise "ERROR"
    end
  when 'v'
    case num
    when 0
      '>'
    when 1
      'v'
    when 2
      '<'
    else
      raise "ERROR"
    end
  when '^'
    case num
    when 0
      '<'
    when 1
      '^'
    when 2
      '>'
    else
      raise "ERROR"
    end
  else
    raise "ERROR"
  end
end

(1..100000000).each do |n|
  moved_parts = move(grid, moving_parts)
  crossed_parts = (moving_parts + moved_parts).group_by { |x, y, _, _| {x, y} }.select { |pos, values| values.size > 1 }
  if crossed_parts.size > 0
    puts crossed_parts
    puts moving_parts
    puts moved_parts
    break
  end
  moving_parts = moved_parts
  puts "#{n} #{moving_parts.map { |_, _, v, c| "#{v}#{c}" }.join()}"
end
