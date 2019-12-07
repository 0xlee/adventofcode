def run(arr : Array(Int32), input : Array(Int32))
  i = 0
  pos = 0
  last_output = 0
  while arr[pos] != 99
    opcode = arr[pos] % 100
    mode_p1, mode_p2, mode_p3 = arr[pos].tdiv(100) % 10, arr[pos].tdiv(1000) % 10, arr[pos].tdiv(10000) % 10
    case opcode
    when 1 # add
      p1 = mode_p1 == 1 ? arr[pos + 1] : arr[arr[pos + 1]]
      p2 = mode_p2 == 1 ? arr[pos + 2] : arr[arr[pos + 2]]
      arr[arr[pos + 3]] = p1 + p2
      pos += 4
    when 2 # mult
      p1 = mode_p1 == 1 ? arr[pos + 1] : arr[arr[pos + 1]]
      p2 = mode_p2 == 1 ? arr[pos + 2] : arr[arr[pos + 2]]
      arr[arr[pos + 3]] = p1 * p2
      pos += 4
    when 3 # input
      v = input[i]
      i += 1
      # puts "input #{v}"
      arr[arr[pos + 1]] = v
      pos += 2
    when 4 # output
      p1 = mode_p1 == 1 ? arr[pos + 1] : arr[arr[pos + 1]]
      # puts "output #{p1}"
      last_output = p1
      pos += 2
    when 5 # jump-if-true
      p1 = mode_p1 == 1 ? arr[pos + 1] : arr[arr[pos + 1]]
      p2 = mode_p2 == 1 ? arr[pos + 2] : arr[arr[pos + 2]]
      if p1 != 0
        pos = p2
      else
        pos += 3
      end
    when 6 # jump-if-true
      p1 = mode_p1 == 1 ? arr[pos + 1] : arr[arr[pos + 1]]
      p2 = mode_p2 == 1 ? arr[pos + 2] : arr[arr[pos + 2]]
      if p1 == 0
        pos = p2
      else
        pos += 3
      end
    when 7 # less than
      p1 = mode_p1 == 1 ? arr[pos + 1] : arr[arr[pos + 1]]
      p2 = mode_p2 == 1 ? arr[pos + 2] : arr[arr[pos + 2]]
      if p1 < p2
        arr[arr[pos + 3]] = 1
      else
        arr[arr[pos + 3]] = 0
      end
      pos += 4
    when 8 # equals
      p1 = mode_p1 == 1 ? arr[pos + 1] : arr[arr[pos + 1]]
      p2 = mode_p2 == 1 ? arr[pos + 2] : arr[arr[pos + 2]]
      if p1 == p2
        arr[arr[pos + 3]] = 1
      else
        arr[arr[pos + 3]] = 0
      end
      pos += 4
    end
  end
  last_output
end

def multiple_run(arr : Array(Int32), phase : Array(Int32))
  output = run(arr, [phase[0], 0])
  output = run(arr, [phase[1], output])
  output = run(arr, [phase[2], output])
  output = run(arr, [phase[3], output])
  output = run(arr, [phase[4], output])
  output
end

arr = File.read_lines("input")
  .flat_map do |line|
    line.split(",").map(&.to_i32)
  end

# puts multiple_run([3, 15, 3, 16, 1002, 16, 10, 16, 1, 16, 15, 15, 4, 15, 99, 0, 0], [4, 3, 2, 1, 0])
# puts multiple_run([3, 23, 3, 24, 1002, 24, 10, 24, 1002, 23, -1, 23, 101, 5, 23, 23, 1, 24, 23, 23, 4, 23, 99, 0, 0], [0, 1, 2, 3, 4])
# puts multiple_run([3, 31, 3, 32, 1002, 32, 10, 32, 1001, 31, -2, 31, 1007, 31, 0, 33, 1002, 33, 7, 33, 1, 33, 31, 31, 1, 32, 31, 31, 4, 31, 99, 0, 0, 0], [1, 0, 4, 3, 2])

result = [0, 1, 2, 3, 4].permutations.map do |p|
  multiple_run(arr, p)
end
puts result.max
