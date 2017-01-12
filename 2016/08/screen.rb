class Screen
  class Instruction
    attr_reader :type, :index, :amount
    def initialize(type, index, amount)
      @type = type
      @index = index
      @amount = amount
    end

    def x
      @index
    end

    def y
      @amount
    end
  end

  def self.follow(input)
    # 50px wide 6px tall
    to_instructions(input)
      .each_with_object(Array.new(50, Array.new(6, false))) {|i,a| execute(i,a)}
  end

  def execute(instruction, screen)
    case instruction.type
    when :rect rect(screen, instruction.x, instruction.y)
    when :x rotate_col(screen, instruction.index, instruction.amount)
    when :y rotate_row(screen, instruction.index, instruction.amount)
    end
  end

  def rect(screen, x, y)
    screen[0...x].each {|col| col[0...y] = true}
  end

  def rotate_col(screen, column, amount)
  end

  def rotate_row(screen, row, amount)
  end

  def self.to_instructions(input)
    input.split("\n")
      .map {|i| to_instruction(i)}
  end

  def self.to_instruction(unparsed)
    Instruction.new *case
    when unparsed.start_with?('rect')
      unparsed[5..unparsed.length]
        .split('x')
        .map(&:to_i)
        .unshift(:rect)
    when unparsed.start_with?('rotate column x=')
      unparsed[16..unparsed.length]
        .split(' by ')
        .map(&:to_i)
        .unshift(:x)
    when unparsed.start_with?('rotate row y=')
      unparsed[13..unparsed.length]
        .split(' by ')
        .map(&:to_i)
        .unshift(:y)
    end
  end
end
