def run(arr : Array(Int32))
  pos = 0
  while arr[pos] != 99
    case arr[pos]
    when 1
      arr[arr[pos + 3]] = arr[arr[pos + 1]] + arr[arr[pos + 2]]
      pos += 4
    when 2
      arr[arr[pos + 3]] = arr[arr[pos + 1]] * arr[arr[pos + 2]]
      pos += 4
    end
  end
end

arr = File.read_lines("input")
  .flat_map do |line|
    line.split(",").map(&.to_i32)
  end

# run([1, 0, 0, 0, 99])
# run([2, 3, 0, 3, 99])
# run([2, 4, 4, 5, 99, 0])
# run([1, 1, 1, 4, 99, 5, 6, 0, 99])

arr[1] = 12
arr[2] = 2
run(arr)
puts arr[0]
