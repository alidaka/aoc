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

def overlap2(string)
  n = 2000

  seen_claims = Array.new

  string.each_line
    .map(&Claim.method(:new))
    .each_with_object(Array.new(n) { Array.new(n, 0) }) do |claim, fabric|
      (claim.y...claim.y + claim.height).each_entry do |y|
        (claim.x...claim.x + claim.width).each_entry do |x|
          previous_id = fabric[y][x]
          if previous_id != 0 then
            seen_claims[previous_id] = true
            seen_claims[claim.id] = true
          else
            seen_claims[claim.id] |= false
          end
          fabric[y][x] = claim.id
        end
      end
    end

  seen_claims.find_index(false)
end

class Claim
  attr_reader :id, :x, :y, :width, :height

  def initialize(string)
    id, x, coordinates, size = string.split
    @id = id.delete_prefix('#').to_i
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
        input = <<~HEREDOC
          #1 @ 1,3: 4x4
          #2 @ 3,1: 4x4
          #3 @ 5,5: 2x2
        HEREDOC
        assert_equal(3, overlap2(input))
      end
    end
  else
    p overlap2 *ARGV
  end
end
