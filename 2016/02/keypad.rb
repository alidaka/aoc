class Keypad
  def self.parse(s, format = :num)
    keypad = case format
    when :num
      layout = [['1','2','3'], ['4','5','6'], ['7','8','9']]
      Keypad.new(layout, 1, 1)
    when :alphanum
      layout = [[nil, nil, '1', nil, nil],
                [nil, '2', '3', '4', nil],
                ['5', '6', '7', '8', '9'],
                [nil, 'A', 'B', 'C', nil],
                [nil, nil, 'D', nil, nil]]
      Keypad.new(layout, 2, 0)
    end

    lines = s.split("\n")
    lines.each_with_object('') do |line, a|
      line.each_char do |direction|
        keypad.go(direction)
      end

      a << keypad.current
    end
  end

  def initialize(layout, x, y)
    rows = layout.length
    cols = layout[0].length

    @layout = layout
      .unshift(Array.new(cols))
      .push(Array.new(rows))
      .each { |a| a.unshift(nil).push(nil) }
    @x = x+1
    @y = y+1
  end

  def go(direction)
    case direction
    when 'U' then @x = @layout[@x-1][@y].nil? ? @x : @x-1
    when 'D' then @x = @layout[@x+1][@y].nil? ? @x : @x+1
    when 'L' then @y = @layout[@x][@y-1].nil? ? @y : @y-1
    when 'R' then @y = @layout[@x][@y+1].nil? ? @y : @y+1
    end
  end

  def current
    @layout[@x][@y]
  end
end
