class Room
  # de-sectorize
  def self.desect(s)
    s.split("\n").reduce(0) {|sum, room| sum + analyze(room)}
  end

  def self.analyze(room)
    flat_name, checksum, sector_id = parse(room)
    expected = flat_name.chars
      .each_with_object(Hash.new(0)) {|char, counts| counts[char] += 1}
      .sort {|a, b| compare_counts(a, b)}
      .take(5)
      .reduce('') {|memo, count| memo += count[0]}

    (expected == checksum) ? sector_id : 0
  end

  def self.parse(s)
    names = s.split('-')
    id = names.pop.split('[')
    checksum = id.pop.chop

    names = names.reduce(&:+)
    id = id[0].to_i

    [names, checksum, id]
  end

  def self.compare_counts(a, b)
    a[1] == b[1] ? a[0] <=> b[0] : b[1] <=> a[1]
  end
end
