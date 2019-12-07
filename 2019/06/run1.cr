orbits = File.read_lines("input")
  .map do |line|
    line.split(")").reverse
  end
  .to_h

indirect_orbits = {} of String => Int32

def count_indirect_orbits(orbits, indirect_orbits, obj)
  c = indirect_orbits[obj]?
  o = orbits[obj]?
  if c
  elsif o
    indirect_orbits[obj] = count_indirect_orbits(orbits, indirect_orbits, o) + 1
  else
    indirect_orbits[obj] = 0
  end

  indirect_orbits[obj]
end

count_orbits = orbits.map do |k, v|
  count_indirect_orbits(orbits, indirect_orbits, k)
end.sum

puts count_orbits
