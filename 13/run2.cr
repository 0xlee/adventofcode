grid = File.read_lines("_input").map { |line| line.chars }

moving_parts = grid.map_with_index do |line, y|
  line
    .map_with_index { |field, x| {y, x, field, 0} }
    .select { |_, _, field| field == '>' || field == '<' || field == 'v' || field == '^' }
end.flatten

def move(grid : Array(Array(Char)), moving_parts : Array(Tuple(Int32, Int32, Char, Int32)))
  moving_parts.map do |y, x, field, count|
    case field
    when '>'
      case grid[y][x + 1]
      when ' '
        raise "ERROR >"
      when '\\'
        {y, x + 1, 'v', count}
      when '/'
        {y, x + 1, '^', count}
      when '+'
        {y, x + 1, dir('>', count), (count + 1) % 3}
      else
        {y, x + 1, '>', count}
      end
    when '<'
      case grid[y][x - 1]
      when ' '
        raise "ERROR <"
      when '\\'
        {y, x - 1, '^', count}
      when '/'
        {y, x - 1, 'v', count}
      when '+'
        {y, x - 1, dir('<', count), (count + 1) % 3}
      else
        {y, x - 1, '<', count}
      end
    when 'v'
      case grid[y + 1][x]
      when ' '
        raise "ERROR v"
      when '\\'
        {y + 1, x, '>', count}
      when '/'
        {y + 1, x, '<', count}
      when '+'
        {y + 1, x, dir('v', count), (count + 1) % 3}
      else
        {y + 1, x, 'v', count}
      end
    when '^'
      case grid[y - 1][x]
      when ' '
        raise "ERROR ^"
      when '\\'
        {y - 1, x, '<', count}
      when '/'
        {y - 1, x, '>', count}
      when '+'
        {y - 1, x, dir('^', count), (count + 1) % 3}
      else
        {y - 1, x, '^', count}
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
      raise "ERROR >#{num}"
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
      raise "ERROR <#{num}"
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
      raise "ERROR v#{num}"
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
      raise "ERROR ^#{num}"
    end
  else
    raise "ERROR"
  end
end

puts moving_parts
puts moving_parts.sort

(1..100000000).each do |n|
  moving_parts.sort!
  moved_parts = move(grid, moving_parts)
  removed = Array.new(moved_parts.size, false)
  moved_parts.each_with_index do |moved, idx|
    yy, xx = moved[0], moved[1]
    cross_not_moved = moving_parts.map_with_index { |m, i| { m[0], m[1], i}}.select { |y, x, i| i >= idx && x == xx && y == yy }
    cross_moved = moved_parts.map_with_index { |m, i| { m[0], m[1], i}}.select { |y, x, i| i < idx && x == xx && y == yy }
    if cross_not_moved.count &.itself > 0
      puts "crossed1 #{moved[1]},#{moved[0]}"
      removed[cross_not_moved.first[2]] = true
      removed[idx] = true
      puts "remaining #{moved_parts.size}"
    end
    if cross_moved.count &.itself > 0
      puts "crossed2 #{moved[1]},#{moved[0]} #{cross_moved.size}"
      puts "deleting #{cross_moved.first[2]} #{idx-1}"
      puts moving_parts
      removed[cross_moved.first[2]] = true
      removed[idx-1] = true
      puts "remaining #{moved_parts.size}"
    end
  end
  if moved_parts.zip(removed).select{|k, v| !v}.size == 1
    puts moving_parts
    puts moved_parts.first
    Process.exit(0)
  end
  moving_parts = moved_parts.zip(removed).select{|k, v| !v}.map(&.[0])
  puts moving_parts
end
