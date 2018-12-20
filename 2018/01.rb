#!/usr/bin/env ruby

def calibrate(string)
  string.split(/(, )|\n/)
    .map(&:to_i)
    .reduce(0, &:+)
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
    end
  else
    p calibrate *ARGV
  end
end
