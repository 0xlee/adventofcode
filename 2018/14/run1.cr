arr = [3, 7]
e1, e2 = 0, 1

input = 9

loop do
  sum = arr[e1] + arr[e2]
  arr += sum >= 10 ? [sum/10, sum % 10] : [sum]
  e1 = (e1 + arr[e1] + 1) % arr.size
  e2 = (e2 + arr[e2] + 1) % arr.size
  if arr.size > input + 10
    puts arr[input, 10].join
    break
  end
end
