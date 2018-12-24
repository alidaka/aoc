#!/usr/bin/env ruby

def checksum(string)
  counts = string.split("\n")
    .each_with_object({twos: 0, threes: 0}) do |line, acc|
      chars = line.each_byte
        .each_with_object(Array.new(255, 0)) { |x, a| a[x] += 1 }
      acc[:twos] += 1 if chars.count(2).positive?
      acc[:threes] += 1 if chars.count(3).positive?
    end
  counts[:twos] * counts[:threes]
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
    end
  else
    p checksum *ARGV
  end
end
