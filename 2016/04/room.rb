class Room
  # de-sectorize
  def self.desect(s)
    s.split("\n").reduce(0) {|sum, room| sum + analyze(room)}
  end

  def self.analyze(room)
    flat_name, checksum, sector_id = parse(room)
    [flat_name, checksum, sector_id]
  end

  def self.parse(s)
    names = s.split('-')
    id = names.pop.split('[')
    checksum = id.pop.chop

    names = names.reduce(&:+)
    id = id[0].to_i

    [names, checksum, id]
  end
end
