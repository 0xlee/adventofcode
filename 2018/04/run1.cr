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

most_asleep = asleep_time
  .group_by { |id, t| id }
  .to_a
  .sort_by { |id, v| v.size }
  .last

puts most_asleep[0]*most_asleep[1]
  .map { |id, t| t }
  .group_by { |t| t }
  .to_a
  .map { |t, c| {t, c.size} }
  .sort_by { |t, s| s }
  .last[0]
