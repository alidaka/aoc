class Map
  CARDINAL_WHEEL = [:north, :east, :south, :west, :north]
  attr_reader :x, :y

  def initialize
    @coordinates = Array.new(500) {Array.new(500, false)}

    @x = 0
    @y = 0

    @list = Array.new
    visit(@x, @y)
  end

  def self.travel(s, stop_on_repeat)
    instructions = s.split(', ')
    cardinal = :north

    map = Map.new
    instructions.each do |instruction|
      cardinal, distance = parse_instruction(instruction, cardinal)

      answer = map.go(cardinal, distance, stop_on_repeat)
      return from_origin(map.x, map.y) if answer && stop_on_repeat
    end

    from_origin(map.x, map.y)
  end

  def self.from_origin(x, y)
      x.abs + y.abs
  end

  def self.parse_instruction(instruction, cardinal)
    turn = instruction[0] == 'R' ? :right : :left
    cardinal = next_cardinal(cardinal, turn)

    distance = instruction[1...instruction.length].to_i

    [cardinal, distance]
  end

  def self.next_cardinal(previous_cardinal, turn)
    wheel = turn == :right ? CARDINAL_WHEEL : CARDINAL_WHEEL.reverse

    wheel.each_cons(2) { |a|
      return a[1] if a[0] == previous_cardinal
    }
  end

  def go(cardinal, distance, stop_on_repeat)
    distance.times {
      return true if step(cardinal) && stop_on_repeat
    }

    false
  end

  def step(cardinal)
    case cardinal
    when :north then @y += 1
    when :south then @y -= 1
    when :east then @x += 1
    when :west then @x -= 1
    end

    visit(@x, @y)
  end

  def visit(x, y)
    visited = get(x, y)
    set(x, y, true)
    visited
  end

  def translate(coordinate)
    image = (2 * coordinate.abs)
    image = image - 1 if coordinate < 0
    image
  end

  def get(x, y)
    xi = translate(x)
    yi = translate(y)
    @coordinates[xi][yi]
  end

  def set(x, y, value)
    xi = translate(x)
    yi = translate(y)
    @coordinates[xi][yi] = value
  end
end
