class Triangle
  def self.legits(s)
    s.split("\n").select{ |l| legit(l)}.length
  end

  def self.legit(s)
    a, b, c = s.split(' ').reject(&:empty?).map{ |i| i.to_i}
    good?(a, b, c)
  end

  def self.good?(a, b, c)
    good_kernel(a, b, c) && good_kernel(a, c, b) && good_kernel(b, c, a)
  end

  def self.good_kernel(a, b, c)
    (a + b) > c
  end
end
