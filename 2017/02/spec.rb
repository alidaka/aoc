require "minitest/autorun"
require_relative 'checksum'

class TestX < Minitest::Test
  def setup
    @checksum = Checksum.new
  end

  def test_example
    x = <<-BLOCK
    5 1 9 5
    7 5 3
    2 4 6 8
    BLOCK

    assert_equal 18, @checksum.do(x)
  end

  def test_part_one
    x = File.read('input')
    assert_equal 43074, @checksum.do(x)
  end

  def test_example_two
    x = <<-BLOCK
    5 9 2 8
    9 4 7 3
    3 8 6 5
    BLOCK

    assert_equal 9, @checksum.two(x)
  end

  def test_part_two
    x = File.read('input')
    assert_equal 280, @checksum.two(x)
  end
end
