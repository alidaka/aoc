#!/usr/bin/env ruby

def calibrate(string)
  string.split(/,|\n/)
    .map(&:to_i)
    .reduce(0, &:+)
end

def calibrate2(string)
  seen = []
  string.split(/,|\n/)
    .map(&:to_i)
    .cycle
    .each_with_object([0]) do |x, seen|
      nxt = seen.last + x
      return nxt if seen.include?(nxt)
      seen << nxt
    end
end

if __FILE__ == $0
  if ARGV.empty?
    require 'minitest/autorun'

    class CalibrateTest < Minitest::Test
      def test_part_one
        assert_equal(3, calibrate('+1, +1, +1'))
        assert_equal(0, calibrate('+1, +1, -2'))
        assert_equal(-6, calibrate('-1, -2, -3'))
      end

      def test_part_two
        assert_equal(0, calibrate2('+1, -1'))
        assert_equal(10, calibrate2('+3, +3, +4, -2, -4'))
        assert_equal(5, calibrate2('-6, +3, +8, +5, -6'))
        assert_equal(14, calibrate2('+7, +7, -2, -7, -4'))
      end
    end
  else
    p calibrate2 *ARGV
  end
end
