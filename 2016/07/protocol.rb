class Protocol
  def self.count_supported_tls(s)
    s.split("\n")
      .count {|address| supports_tls?(address)}
  end

  def self.supports_ssl?(address)
    supernets, hypernets = parse(address)
    abas = supernets.flat_map { |a| find_abas(a) }
    babs = hypernets.flat_map { |a| find_abas(a) }
  end

  def self.parse(address)
    chunks = address.split('[')
      .flat_map {|a| a.split(']')}

    chunks.each_with_index
      .partition {|x| (x[1]%2)==0}
      .map {|a| a.map(&:first)}
  end

  def self.supports_tls?(address)
    supernets, hypernets = parse(address)
    supernets.any? {|a| abba?(a)} && hypernets.none? {|a| abba?(a)}
  end

  def self.abba?(s)
    s.chars.each_cons(4) do |chars|
      return true if
        chars[0] == chars[3] &&
        chars[1] == chars[2] &&
        chars[0] != chars[1]
    end

    false
  end

  def self.find_abas(s)
    acc = []
    s.chars.each_cons(3) do |chars|
      if chars[0] == chars[2] && chars[0] != chars[1]
        acc << chars
      end
    end

    acc
  end
end
