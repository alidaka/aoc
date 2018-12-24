#!/usr/bin/env ruby

def checksum(string)
  counts = string.each_line
    .each_with_object({twos: 0, threes: 0}) do |line, acc|
      chars = line.each_byte
        .each_with_object(Array.new(255, 0)) { |x, a| a[x] += 1 }
      acc[:twos] += 1 if chars.count(2).positive?
      acc[:threes] += 1 if chars.count(3).positive?
    end
  counts[:twos] * counts[:threes]
end

def closest(string)
  string.each_line
    .map(&:strip)
    .to_a
    .combination(2) do |word1, word2|
      common = ''
      word1.chars.zip(word2.chars) { |char1, char2| common << char1 if char1 == char2 }
      return common if common.length == (word1.length - 1)
    end
end

if __FILE__ == $0
  if ARGV.empty?
    require 'minitest/autorun'

    class ChecksumTest < Minitest::Test
      def test_part_one
        input = <<~HEREDOC
          abcdef
          bababc
          abbcde
          abcccd
          aabcdd
          abcdee
          ababab
        HEREDOC
        assert_equal(12, checksum(input))
      end

      def test_part_two
        input = <<~HEREDOC
          abcde
          fghij
          klmno
          pqrst
          fguij
          axcye
          wvxyz
        HEREDOC

        assert_equal('fgij', closest(input))
      end
    end
  else
    p closest *ARGV
  end
end
