class Captcha
  def review(x)
    memo = 0
    (x + x[0])
      .each_char
      .each_cons(2) { |first, second|
        memo += first.to_i if first == second
      }

    memo
  end

  def circular(x)
    memo = 0
    length = x.length
    offset = length/2
    x.each_char
      .each_with_index { |value, index|
        memo += value.to_i if value == x[(index + offset) % length]
      }

    memo
  end
end
