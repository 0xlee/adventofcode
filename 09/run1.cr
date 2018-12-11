class Marble
  property num
  property p
  property n

  def self.new(num : Int32)
    instance = Marble.allocate
    instance.initialize(num, instance, instance)
  end

  def initialize(@num : Int32, @p : Marble, @n : Marble)
  end

  def insert(num : Int32)
    marble = Marble.new(num)
    marble.p = self
    marble.n = self.n
    self.n.p = marble
    self.n = marble
  end

  def delete
    if self.num == 0
      raise Exception.new("Deleting Marble number 0")
    end
    self.p.n = self.n
    self.n.p = self.p
    self.n
  end

  def to_s(io)
    if @n.num == 0
      io << @num
    else
      io << @num << " " << @n
    end
  end
end

z = Marble.new(0)
puts "#{z}"
c = z

scores = Array.new(463, 0_i64)
player = 1
(1..7178700).each do |n|
  if n % 23 == 0
    c = c.p.p.p.p.p.p.p
    scores[player - 1] += n + c.num
    c = c.delete
  else
    c = c.n.insert(n)
  end
  player += 1
  if player > 463
    player = 1
  end
end

puts scores.max
