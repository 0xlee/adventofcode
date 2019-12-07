orbits = File.read_lines("input")
  .map do |line|
    line.split(")").reverse
  end
  .to_h

def parents(orbits, obj, result)
  o = orbits[obj]?
  if o
    result << o
    parents(orbits, o, result)
  end
  result
end

parents_of_me = parents(orbits, "YOU", [] of String)
parents_of_santa = parents(orbits, "SAN", [] of String)

a = parents_of_me.index("DKQ")
b = parents_of_santa.index("DKQ")
if a && b
  puts a + b
end
