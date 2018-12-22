clays = File.read_lines("input").map do |line|
  if md = /([xy])=(\d+), ([xy])=(\d+)\.\.(\d+)/.match(line)
    if md[1] == "x"
      x, y1, y2 = md[2].to_i, md[4].to_i, md[5].to_i
      (y1..y2).map { |y| {x, y} }
    elsif md[1] == "y"
      y, x1, x2 = md[2].to_i, md[4].to_i, md[5].to_i
      (x1..x2).map { |x| {x, y} }
    else
      puts "PANIC!!"
    end
  end
end.compact.flatten

minX, minY = clays.reduce { |acc, obj| {Math.min(acc[0], obj[0]), Math.min(acc[1], obj[1])} }
maxX, maxY = clays.reduce { |acc, obj| {Math.max(acc[0], obj[0]), Math.max(acc[1], obj[1])} }

class Field
  @f : Array(Array(Char))

  def initialize(@xSize : Int32, @ySize : Int32)
    @f = Array.new(ySize) { |_| Array.new(xSize, '.') }
  end

  def [](x, y)
    @f[y][x]
  end

  def []=(x, y, v)
    @f[y][x] = v
  end

  def is_blocked(x, y)
    @f[y][x] == '#' || @f[y][x] == '~'
  end

  def print(x1, x2, y1, y2)
    sum = (y1..y2).map_with_index do |y, i|
      line = (x1-1..x2+1).map do |x|
        self[x, y]
      end
count = line.count { |c| c == '~' || c == '|' } 
      printf "%5d %s %3d\n", [i, line.join, count]
      count
    end.sum
    puts sum
  end

  def count_water(y1, y2)
    @f[y1.. y2].map do |yy|
      yy.count { |c| c == '~' || c == '|' }
    end.sum
  end

  def count_drained(y1, y2)
    @f[y1.. y2].map do |yy|
      yy.count { |c| c == '~' }
    end.sum
  end

  def unmark_visited
    (0...@f.size).each do |y|
      (0...@f[y].size).each do |x|
        if self[x,y] == '^'
          self[x,y] = '|'
        end
      end
    end
  end
end

field = Field.new(1000, maxY + 1)

clays.each do |x, y|
  field[x, y] = '#'
end

def drop(field, x, y, maxY)
  yy = y + 1
  field[x, y] = '^'
  if yy <= maxY
    case field[x, yy]
    when '.', '|'
      drop(field, x, yy, maxY)
    when '#', '~'
      spread(field, x, y, maxY)
    end
  end
end

def spread(field, x, y, maxY)
  x1 = x
  while field.is_blocked(x1 - 1, y + 1) && !field.is_blocked(x1 - 1, y)
    field[x1 - 1, y] = '^'
    x1 -= 1
  end
  x2 = x
  while field.is_blocked(x2 + 1, y + 1) && !field.is_blocked(x2 + 1, y)
    field[x2 + 1, y] = '^'
    x2 += 1
  end

  if field.is_blocked(x1 - 1, y) && field.is_blocked(x2 + 1, y)
    (x1..x2).each do |x|
      field[x, y] = '~'
    end
  end

  if !field.is_blocked(x1 - 1, y)
    drop(field, x1-1, y, maxY)
  end
  if !field.is_blocked(x2 + 1, y)
    drop(field, x2+1, y, maxY)
  end
end

(1..1000).each do |_|
  drop(field, 500, 0, maxY)
  field.unmark_visited
end

field.print minX-1, maxX+1, 0, maxY
puts field.count_water(minY, maxY+1)
drop(field, 500, 0, maxY)
field.unmark_visited
puts field.count_water(minY, maxY)
puts field.count_drained(minY, maxY)
