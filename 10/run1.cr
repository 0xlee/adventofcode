require "math"

class Point
  getter pos

  def initialize(@pos : NamedTuple(x: Int64, y: Int64), @vel : NamedTuple(x: Int64, y: Int64))
  end

  def move(second : Int32 = 1)
    pos = {x: @pos[:x] + second*@vel[:x], y: @pos[:y] + second*@vel[:y]}
    Point.new(pos, @vel)
  end
end

def boundary(points)
  ps = points.map { |p| p.pos }
  init = {ps.first[:x], ps.first[:y], ps.first[:x], ps.first[:y]} # left, top, right, bottom
  ps.reduce(init) do |acc, inc|
    left = Math.min(acc[0], inc[:x])
    top = Math.min(acc[1], inc[:y])
    right = Math.max(acc[2], inc[:x])
    bottom = Math.max(acc[3], inc[:y])
    {left, top, right, bottom}
  end
end

def draw_points(points)
  ps = points.map { |p| p.pos }
  boundary = boundary points
  (boundary[1]..boundary[3]).each do |y|
    result = (boundary[0]..boundary[2]).map do |x|
      ps.includes?({x: x, y: y}) ? '#' : '.' # expensive operation .includes?
    end
    puts result.join
  end
end

points = File.read_lines("input").map do |line|
  px, py, vx, vy = line.scan(/-?\d+/).map { |md| md[0].to_i64 }
  Point.new({x: px, y: py}, {x: vx, y: vy})
end

b = boundary(points)
bs = (b[2] - b[0]) * (b[3] - b[1])
prev_bs = bs + 1
i = 0

while bs < prev_bs
  prev_bs = bs
  points = points.map { |p| p.move }
  b = boundary(points)
  bs = (b[2] - b[0]) * (b[3] - b[1])
  i += 1
end

draw_points points.map { |p| p.move(-1) }
puts i - 1
