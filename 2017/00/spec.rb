require "minitest/autorun"
require_relative 'x'

class TestX < Minitest::Test
  def setup
    @x = X.new
  end

  def test_1
    x = '1'
    assert_equal '1', @x.do(x)
  end
end
