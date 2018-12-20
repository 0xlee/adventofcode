class TestCase
  property current = Array(Int32).new(4, 0)

  def runInstruction(opcode, a, b, c)
    case opcode
    when 0
      runAddi opcode, a, b, c
    when 1
      runEqrr opcode, a, b, c
    when 2
      runBorr opcode, a, b, c
    when 3
      runGtri opcode, a, b, c
    when 4
      runAddr opcode, a, b, c
    when 5
      runSeti opcode, a, b, c
    when 6
      runMuli opcode, a, b, c
    when 7
      runBani opcode, a, b, c
    when 8
      runBanr opcode, a, b, c
    when 9
      runGtrr opcode, a, b, c
    when 10
      runSetr opcode, a, b, c
    when 11
      runGtir opcode, a, b, c
    when 12
      runBori opcode, a, b, c
    when 13
      runEqri opcode, a, b, c
    when 14
      runEqir opcode, a, b, c
    when 15
      runMulr opcode, a, b, c
    end
  end

  def runAddr(opcode, a, b, c)
    @current[c] = @current[a] + @current[b]
  end

  def runAddi(opcode, a, b, c)
    @current[c] = @current[a] + b
  end

  def runMulr(opcode, a, b, c)
    @current[c] = @current[a] * @current[b]
  end

  def runMuli(opcode, a, b, c)
    @current[c] = @current[a] * b
  end

  def runBanr(opcode, a, b, c)
    @current[c] = @current[a] & @current[b]
  end

  def runBani(opcode, a, b, c)
    @current[c] = @current[a] & b
  end

  def runBorr(opcode, a, b, c)
    @current[c] = @current[a] | @current[b]
  end

  def runBori(opcode, a, b, c)
    @current[c] = @current[a] | b
  end

  def runSetr(opcode, a, b, c)
    @current[c] = @current[a]
  end

  def runSeti(opcode, a, b, c)
    @current[c] = a
  end

  def runGtir(opcode, a, b, c)
    @current[c] = a > @current[b] ? 1 : 0
  end

  def runGtri(opcode, a, b, c)
    @current[c] = @current[a] > b ? 1 : 0
  end

  def runGtrr(opcode, a, b, c)
    @current[c] = @current[a] > @current[b] ? 1 : 0
  end

  def runEqir(opcode, a, b, c)
    @current[c] = a == @current[b] ? 1 : 0
  end

  def runEqri(opcode, a, b, c)
    @current[c] = @current[a] == b ? 1 : 0
  end

  def runEqrr(opcode, a, b, c)
    @current[c] = @current[a] == @current[b] ? 1 : 0
  end
end

tc = TestCase.new
File.read_lines("input2").each do |line|
  if md = /(\d+) (\d+) (\d+) (\d+)/.match(line)
    tc.runInstruction md[1].to_i, md[2].to_i, md[3].to_i, md[4].to_i
  end
end

puts tc.current
