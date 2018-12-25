#!/usr/bin/env ruby

def overlap(string)
  n = 2000

  string.each_line
    .map(&Claim.method(:new))
    .each_with_object(Array.new(n) { Array.new(n, 0) }) do |claim, fabric|
      (claim.y...claim.y + claim.height).each_entry do |y|
        (claim.x...claim.x + claim.width).each_entry do |x|
          fabric[y][x] += 1
        end
      end
    end
    .map do |a| # TODO: there's got to be a way to do this point-free, procs, ...
      a.count { |x| x > 1 }
    end.reduce(&:+)
end

class Claim
  attr_reader :id, :x, :y, :width, :height

  def initialize(string)
    id, x, coordinates, size = string.split
    @id = id.delete_prefix('#')
    @x, @y = coordinates.split(',').map(&:to_i)
    @width, @height = size.split('x').map(&:to_i)
  end
end

if __FILE__ == $0
  if ARGV.empty?
    require 'minitest/autorun'

    class Test < Minitest::Test
      def test_part_one
        input = <<~HEREDOC
          #1 @ 1,3: 4x4
          #2 @ 3,1: 4x4
          #3 @ 5,5: 2x2
        HEREDOC
        assert_equal(4, overlap(input))
      end

      def test_part_two
      end
    end
  else
    p overlap *ARGV
  end
end
