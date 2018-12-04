data_list = File.read_lines("input")
  .map do |line|
    if md = /\[([^\]]+)\] (.*)/.match(line)
      {md[1], md[2]}
    end
  end
  .compact
  .sort_by { |data| data[0] }

begin_shift = /Guard #(\d+) begins shift/

current_id = 0
last_fell_asleep = ""
asleep_list = data_list
  .map do |data|
    if match = begin_shift.match(data[1])
      current_id = match[1]
      nil
    elsif data[1] == "falls asleep"
      last_fell_asleep = data[0]
      nil
    elsif data[1] == "wakes up"
      {current_id, last_fell_asleep, data[0]}
    end
  end.compact

def parse_time(s)
  Time.parse(s, "%F %H:%M", kind = Time::Location::UTC)
end

asleep_time = asleep_list
  .map { |id, start, end| {id.to_i, parse_time(start), parse_time(end)} }
  .flat_map do |id, s, e|
    Range.new(s.to_unix, e.to_unix).step(60)
      .select { |t| Time.unix(t).hour == 0 }
      .map { |t| {id, Time.unix(t).minute} }
      .to_a
  end

result = asleep_time
  .group_by { |data| data }
  .to_a
  .map { |k, v| {k, v.size} }
  .sort_by { |k, s| s }
  .last(2)

result
  .each { |data| puts data[0][0] * data[0][1] }
