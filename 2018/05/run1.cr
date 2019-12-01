input = File.read("input")
pattern = Regex.new(('a'..'z').map { |a|
  "#{a}#{a.upcase}|#{a.upcase}#{a}"
}.join("|"))

lastsize = input.size + 1
while input.size != lastsize
  lastsize = input.size
  input = input.gsub(pattern, "")
end
puts lastsize
