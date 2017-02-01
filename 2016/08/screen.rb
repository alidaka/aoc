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

  def self.pp(screen)
    puts
    screen.transpose
      .each do |row|
        row.each_with_index do |c,i|
          print c == 0 ? '.' : '#'
          print ' ' if (i%5) == 4
        end

        puts
      end
  end

  def self.follow(columns, rows, input)
    a = to_instructions(input)
      .inject(Array.new(columns){Array.new(rows, 0)}) {|a,i| execute(a,i)}

    pp a

    a.flatten
      .reduce(&:+)
  end

  def self.execute(screen, instruction)
    case instruction.type
    when :rect then rect(screen, instruction.x, instruction.y)
    when :x then rotate_col(screen, instruction.index, instruction.amount)
    when :y then rotate_row(screen, instruction.index, instruction.amount)
    end
  end

  def self.rect(screen, x, y)
    screen.each_with_index do |col, i|
      if i < x then
        col[0...y] = Array.new(y, 1)
      end
    end
  end

  def self.rotate_col(screen, column, amount)
    screen[column].rotate!(-amount)
    screen
  end

  def self.rotate_row(screen, row, amount)
    rotate_col(screen.transpose, row, amount).transpose
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
