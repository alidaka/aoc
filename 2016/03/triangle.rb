class Triangle
  def self.horizontals(s)
    s.split("\n").select{ |l| horizontal(l)}.length
  end

  def self.horizontal(s)
    a, b, c = s.split(' ').reject(&:empty?).map{ |i| i.to_i}
    good?(a, b, c)
  end

  def self.good?(a, b, c)
    check = lambda { |a, b, c| (a+b)>c}

    check.call(a, b, c) && check.call(a, c, b) && check.call(b, c, a)
  end
end
