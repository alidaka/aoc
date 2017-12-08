class Checksum
  def do(x)
    x.strip
      .split("\n")
      .map(&:split)
      .map { |row| row.map(&:to_i).max - row.map(&:to_i).min }
      .reduce(:+)
  end

  def two(x)
    x.strip
      .split("\n")
      .map(&:split)
      .map { |row|
        row.to_a
          .map(&:to_i)
          .permutation(2)
          .map { |a, b| a == (a/b * b) ? a/b : 0 }
          .reduce(:+)
      }
      .reduce(:+)
  end
end
