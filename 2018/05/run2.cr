input = File.read("input").strip

all_alphabet = "abcdefghijklmnopqrstuvwxyz"
pattern = Regex.new(all_alphabet.chars.map { |a| "#{a}#{a.upcase}|#{a.upcase}#{a}" }.join("|"))

result = all_alphabet.chars.map do |a|
  i1 = input.gsub(Regex.new("#{a}"), "")
  i2 = i1.gsub(Regex.new("#{a.upcase}"), "")
  lastsize = i2.size + 1
  while i2.size != lastsize
    lastsize = i2.size
    i2 = i2.gsub(pattern, "")
  end
  lastsize
end

puts result.min
