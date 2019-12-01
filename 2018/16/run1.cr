# 4 registers, 0 to 3, 16 opcodes
# opcode, two inputs A and B, output C

# addr
# addi
# mulr
# muli
# banr
# bani
# borr
# bori
# setr
# seti
# gtir
# gtri
# gtrr
# eqir
# eqri
# eqrr

class TestCase
  property before : Array(Int32)
  property instruction : Array(Int32)
  property after : Array(Int32)

  def initialize(@before, @instruction, @after)
  end

  def testAddr
    result = @before.clone
    result[@instruction[3]] = result[@instruction[1]] + result[@instruction[2]]
    result == @after
  end

  def testAddi
    result = @before.clone
    result[@instruction[3]] = result[@instruction[1]] + @instruction[2]
    result == @after
  end

  def testMulr
    result = @before.clone
    result[@instruction[3]] = result[@instruction[1]] * result[@instruction[2]]
    result == @after
  end

  def testMuli
    result = @before.clone
    result[@instruction[3]] = result[@instruction[1]] * @instruction[2]
    result == @after
  end

  def testBanr
    result = @before.clone
    result[@instruction[3]] = result[@instruction[1]] & result[@instruction[2]]
    result == @after
  end

  def testBani
    result = @before.clone
    result[@instruction[3]] = result[@instruction[1]] & @instruction[2]
    result == @after
  end

  def testBorr
    result = @before.clone
    result[@instruction[3]] = result[@instruction[1]] | result[@instruction[2]]
    result == @after
  end

  def testBori
    result = @before.clone
    result[@instruction[3]] = result[@instruction[1]] | @instruction[2]
    result == @after
  end

  def testSetr
    result = @before.clone
    result[@instruction[3]] = result[@instruction[1]]
    result == @after
  end

  def testSeti
    result = @before.clone
    result[@instruction[3]] = @instruction[1]
    result == @after
  end

  def testGtir
    result = @before.clone
    result[@instruction[3]] = @instruction[1] > result[@instruction[2]] ? 1 : 0
    result == @after
  end

  def testGtri
    result = @before.clone
    result[@instruction[3]] = result[@instruction[1]] > @instruction[2] ? 1 : 0
    result == @after
  end

  def testGtrr
    result = @before.clone
    result[@instruction[3]] = result[@instruction[1]] > result[@instruction[2]] ? 1 : 0
    result == @after
  end

  def testEqir
    result = @before.clone
    result[@instruction[3]] = @instruction[1] == result[@instruction[2]] ? 1 : 0
    result == @after
  end

  def testEqri
    result = @before.clone
    result[@instruction[3]] = result[@instruction[1]] == @instruction[2] ? 1 : 0
    result == @after
  end

  def testEqrr
    result = @before.clone
    result[@instruction[3]] = result[@instruction[1]] == result[@instruction[2]] ? 1 : 0
    result == @after
  end
end

before = [-1, 0, 0, 0]
instruction = [-1, 0, 0, 0]
result = Array.new(16, Array.new(16, Int32))

lines = File.read_lines("input1")
results = lines.map do |line|
  if md = /Before: \[(\d), (\d), (\d), (\d)\]/.match(line)
    before = [md[1].to_i, md[2].to_i, md[3].to_i, md[4].to_i]
    nil
  elsif md = /(\d+) (\d+) (\d+) (\d+)/.match(line)
    instruction = [md[1].to_i, md[2].to_i, md[3].to_i, md[4].to_i]
    nil
  elsif md = /After:  \[(\d), (\d), (\d), (\d)\]/.match(line)
    after = [md[1].to_i, md[2].to_i, md[3].to_i, md[4].to_i]
    tc = TestCase.new(before, instruction, after)
    {tc.instruction[0],
     tc.testAddr,
     tc.testAddi,
     tc.testMulr,
     tc.testMuli,
     tc.testBanr,
     tc.testBani,
     tc.testBorr,
     tc.testBori,
     tc.testSetr,
     tc.testSeti,
     tc.testGtir,
     tc.testGtri,
     tc.testGtrr,
     tc.testEqir,
     tc.testEqri,
     tc.testEqrr,
     tc,
    }
  end
end.compact

puts results
  .map { |v| (1..16).map { |n| v[n] ? 1 : 0 }.sum }
  .select { |v| v >= 3 }
  .size

results
  .group_by { |r| r[0] }
  # .map { |k, arr| arr.size }
  # .map { |k, arr|  arr.map(&.size)  }
  .map { |k, arr| {k, (1..16).map { |n| arr.all?(&.[n]) }} }
  .each { |k, arr| puts k, arr.map_with_index { |vv, ii| vv ? ii : nil }.compact }
