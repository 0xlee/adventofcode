class Game
  property grid : Array(Array(Field | Nil))
  property root : Field

  def initialize(@grid)
    @root = @grid.flatten.compact.first
  end

  def to_s(io)
    @grid.map do |line|
      line.map do |field|
        if field
          io << field
        else
          io << '#'
        end
      end
      io << '\n'
    end
  end
end

class Field
  property left : Field | Nil
  property right : Field | Nil
  property up : Field | Nil
  property down : Field | Nil
  property nextField : Field | Nil

  property player : Player | Nil

  def self.with_player(player)
    s = self.new
    s.player = player
    s
  end

  def to_s(io)
    if p = @player
      io << p.team
    else
      io << '.'
    end
  end
end

class Player
  property team

  def initialize(@team : Char, @hp = 200)
  end
end

def make_field(lines : Array(Array(Char)))
  fields = lines.map do |line|
    line.map do |f|
      case f
      when '#'
        nil
      when '.'
        Field.new
      when 'E'
        Field.with_player(Player.new('E'))
      when 'G'
        Field.with_player(Player.new('G'))
      end
    end
  end
  puts fields[3]
  grid = fields.map_with_index do |fields_line, y|
    fields_line.map_with_index do |field, x|
        puts field
      if field
        field.right = fields[y][x + 1]?
        field.left = fields[y][x - 1]?
        field.up = fields[y - 1][x]?
        field.down = fields[y + 1][x]?
      else
        nil
      end
    end
  end
  puts grid[3]
  Game.new(grid)
end

lines = File.read_lines("_input").map { |line| line.chars }
puts make_field(lines)
