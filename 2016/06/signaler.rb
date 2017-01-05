class Signaler
  def self.filter(data)
    filter_kernel(data) { |a| most_common_letter(a) }
  end

  def self.filter_least(data)
    filter_kernel(data) { |a| least_common_letter(a) }
  end

  def self.filter_kernel(data)
    data.split("\n")
      .map(&:chars)
      .transpose
      .map {|row| yield row}
      .join
  end

  def self.sort_letters(a)
    a.each_with_object(Hash.new(0)) {|char, counts| counts[char] += 1}
      .sort {|a,b| a[1]<=>b[1]}
  end

  def self.most_common_letter(a)
    sort_letters(a).last[0]
  end

  def self.least_common_letter(a)
    sort_letters(a).first[0]
  end
end
