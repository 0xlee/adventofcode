arr = [3, 7]
e1, e2 = 0, 1

input = "55440".chars.map(&.to_i)
puts input

len = 10

(0..1000000000).map do |_|
  if arr.size >= len
    puts len
    len *= 10
  end
  sum = arr[e1] + arr[e2]
  if sum >= 10
    arr << sum/10
    arr << sum % 10
  else
    arr << sum
  end
  e1 = (e1 + arr[e1] + 1) % arr.size
  e2 = (e2 + arr[e2] + 1) % arr.size
  if arr.size > input.size
    e = arr.size - input.size
    if (0...input.size).all? { |i| arr[e + i] == input[i] }
      puts e
      break
    end
    if sum >= 10
      e = arr.size - input.size - 1
      if (0...input.size).all? { |i| arr[e + i] == input[i] }
        puts e
        break
      end
    end
  end
end

# Two array merge generates a new array every time and is VERY BAD for performance
