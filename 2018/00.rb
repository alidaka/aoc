#!/usr/bin/env ruby

def m(string)
end

if __FILE__ == $0
  if ARGV.empty?
    require 'minitest/autorun'

    class Test < Minitest::Test
      def test_part_one
        assert_equal(nil, m('string'))
      end

      def test_part_two
      end
    end
  else
    p m *ARGV
  end
end
