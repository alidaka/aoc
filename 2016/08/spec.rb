require_relative 'screen'

RSpec.describe Screen do
  describe 'part one' do
    it 'does the example' do
      instructions = <<~eos
      rect 3x2
      rotate column x=1 by 1
      rotate row y=0 by 4
      rotate column x=1 by 1
      eos

      result = Screen.follow(instructions)
      expect(result).to be 0
    end
  end
end
