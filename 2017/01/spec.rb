require "minitest/autorun"
require_relative 'captcha'

class TestCaptcha < Minitest::Test
  def setup
    @captcha = Captcha.new
  end

  def test_1122
    x = '1122'
    assert_equal 3, @captcha.review(x)
  end

  def test_1111
    x = '1111'
    assert_equal 4, @captcha.review(x)
  end

  def test_1234
    x = '1234'
    assert_equal 0, @captcha.review(x)
  end

  def test_91212129
    x = '91212129'
    assert_equal 9, @captcha.review(x)
  end

  def test_puzzle
    x = File.read('input').strip
    assert_equal 1158, @captcha.review(x)
  end

  # PART 2

  def test_circular_1212
    x = '1212'
    assert_equal 6, @captcha.circular(x)
  end

  def test_circular_1221
    x = '1221'
    assert_equal 0, @captcha.circular(x)
  end

  def test_circular_123425
    x = '123425'
    assert_equal 4, @captcha.circular(x)
  end

  def test_circular_123123
    x = '123123'
    assert_equal 12, @captcha.circular(x)
  end

  def test_circular_12131415
    x = '12131415'
    assert_equal 4, @captcha.circular(x)
  end

  def test_circular_puzzle
    x = File.read('input').strip
    assert_equal 1132, @captcha.circular(x)
  end
end
