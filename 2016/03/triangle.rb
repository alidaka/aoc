class Triangle
  def self.verticals(s)
    valid_triangles = 0
    s.split("\n")
      .each_slice(3) { |rows|
        rows = rows.map{|r| tokenize_line(r)}
        valid_triangles += vertical(rows)
      }

    valid_triangles
  end

  def self.vertical(a)
    (0..2).count{|i| good?(a[0][i], a[1][i], a[2][i])}
  end

  def self.horizontals(s)
    s.split("\n")
      .select{ |l| horizontal(l)}
      .length
  end

  def self.horizontal(s)
    a, b, c = tokenize_line(s)
    good?(a, b, c)
  end

  def self.tokenize_line(s)
    s.split(' ').reject(&:empty?).map{ |i| i.to_i}
  end

  def self.good?(a, b, c)
    check = lambda { |a, b, c| (a+b)>c}

    check.call(a, b, c) && check.call(a, c, b) && check.call(b, c, a)
  end
end
