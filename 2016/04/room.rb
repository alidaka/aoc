class Room
  attr_reader :decrypted_name, :encrypted_name, :flat_name, :checksum, :sector_id

  def initialize(s)
    names = s.split('-')
    id = names.pop.split('[')
    @checksum = id.pop.chop

    @flat_name = names.join
    @encrypted_name = names.join('-')
    @sector_id = id[0].to_i
  end

  # de-sectorize
  def self.desect(s)
    valids(s)
      .map(&:sector_id)
      .reduce(:+) || 0
  end

  def self.decode(s)
    valids(s)
      .find { |room| room.decrypted_name.include?('object') }
  end

  def self.valids(s)
    s.split("\n")
      .map { |s| Room.new(s) }
      .select(&:valid?)
  end

  def valid?
    expected = @flat_name.chars
      .each_with_object(Hash.new(0)) {|char, counts| counts[char] += 1}
      .sort {|a, b| self.class.compare_counts(a, b)}
      .take(5)
      .map(&:first)
      .join

    expected == @checksum
  end

  def decrypted_name
    self.class.shift(@encrypted_name, @sector_id)
  end

  def self.compare_counts(a, b)
    a[1] == b[1] ? a[0] <=> b[0] : b[1] <=> a[1]
  end

  def self.shift(word, distance)
    word.chars
      .map {|char| shift_char(char, distance)}
      .join
  end

  def self.shift_char(char, distance)
    return ' ' if char == '-'

    ((char.ord - 97 + distance) % 26 + 97).chr
  end
end
