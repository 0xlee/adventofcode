def run(arr : Array(Int32))
  input = [1] of Int32
  i = 0
  pos = 0
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
      puts "input #{v}"
      arr[arr[pos + 1]] = v
      pos += 2
    when 4 # output
      puts "output #{arr[arr[pos + 1]]}"
      pos += 2
    end
  end
  arr
end

arr = File.read_lines("input")
  .flat_map do |line|
    line.split(",").map(&.to_i32)
  end

# puts run([1, 0, 0, 0, 99])
# run([2, 3, 0, 3, 99])
# run([2, 4, 4, 5, 99, 0])
# run([1, 1, 1, 4, 99, 5, 6, 0, 99])
# puts run([101, 10, 1, 1, 99])

# arr[1] = 12
# arr[2] = 2
run(arr)
