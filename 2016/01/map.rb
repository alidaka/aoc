class Map
  CARDINAL_DIRECTIONS = [:north, :east, :south, :west]

  def calculate(s)
    instructions = s.split(', ')
    cardinal = :north
    totals = {}
    CARDINAL_DIRECTIONS.each { |direction| totals[direction] = 0 }

    instructions.each do |instruction|
      turn, distance = parse_instruction(instruction)
      cardinal = next_cardinal(cardinal, turn)
      totals[cardinal] += distance
    end

    roll_up(totals)
  end

  def roll_up(totals)
    x = (totals[:east] - totals[:west]).abs
    y = (totals[:north] - totals[:south]).abs
    x + y
  end

  def next_cardinal(previous_cardinal, turn)
    cheat_to_win = CARDINAL_DIRECTIONS + [:north]
    cheat_to_win.reverse! if turn == :left

    cheat_to_win.each_cons(2) { |a|
      return a[1] if a[0] == previous_cardinal
    }
  end

  def parse_instruction(instruction)
      turn = instruction[0] == 'R' ? :right : :left
      distance = instruction[1...instruction.length].to_i
      [turn, distance]
  end
end
