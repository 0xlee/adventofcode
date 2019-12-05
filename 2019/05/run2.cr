def run(arr : Array(Int32), input : Array(Int32))
  i = 0
  pos = 0
  while arr[pos] != 99
    opcode = arr[pos] % 100
    mode_p1, mode_p2, mode_p3 = arr[pos].tdiv(100) % 10, arr[pos].tdiv(1000) % 10, arr[pos].tdiv(10000) % 10
    # puts "#{opcode} #{mode_p1} #{mode_p2} #{mode_p3}"
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
      puts "input #{v}"
      arr[arr[pos + 1]] = v
      pos += 2
    when 4 # output
      p1 = mode_p1 == 1 ? arr[pos + 1] : arr[arr[pos + 1]]
      puts p1
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
  arr
end

arr = File.read_lines("input")
  .flat_map do |line|
    line.split(",").map(&.to_i32)
  end

# # test equals 8
# run([3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8], [7])
# run([3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8], [8])
# run([3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8], [9])
# # test less than 8
# run([3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8], [7])
# run([3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8], [8])
# run([3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8], [9])
# # test equals 8
# run([3, 3, 1108, -1, 8, 3, 4, 3, 99], [7])
# run([3, 3, 1108, -1, 8, 3, 4, 3, 99], [8])
# run([3, 3, 1108, -1, 8, 3, 4, 3, 99], [9])
# # test less than 8
# run([3, 3, 1107, -1, 8, 3, 4, 3, 99], [7])
# run([3, 3, 1107, -1, 8, 3, 4, 3, 99], [8])
# run([3, 3, 1107, -1, 8, 3, 4, 3, 99], [9])
# # jump test
# run([3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9], [0])
# run([3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9], [1])
# run([3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9], [-1])
# # jump test
# run([3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1], [0])
# run([3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1], [1])
# run([3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1], [-1])
# # larger example
# run([3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99], [7])
# run([3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99], [8])
# run([3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99], [9])

# arr[1] = 12
# arr[2] = 2
run(arr, [5])
# puts arr[0]
