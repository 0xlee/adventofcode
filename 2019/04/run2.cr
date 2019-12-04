def has_double(digits)
  counts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  digits.each do |d|
    counts[d] += 1
  end

  counts.any? { |n| n == 2 }
end

def in_range(digits)
  n = digits[0] * 100000 + digits[1] * 10000 + digits[2] * 1000 + digits[3] * 100 + digits[4] * 10 + digits[5] * 1
  n >= 359282 && n <= 820401
end

result = (1..9).map do |d1|
  (d1..9).map do |d2|
    (d2..9).map do |d3|
      (d3..9).map do |d4|
        (d4..9).map do |d5|
          (d5..9).map do |d6|
            arr = [d1, d2, d3, d4, d5, d6]
            has_double(arr) && in_range(arr)
          end
        end
      end
    end
  end
end.flatten.select { |x| x }

puts has_double([1, 1, 2, 2, 3, 3])
puts has_double([1, 2, 3, 4, 4, 4])
puts has_double([1, 1, 1, 1, 2, 2])

puts result.size
