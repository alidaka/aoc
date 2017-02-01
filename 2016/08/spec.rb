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

      result = Screen.follow(7, 3, instructions)
      expect(result).to be 6
    end

    it 'does the problem' do
      instructions = File.read('input')
      result = Screen.follow(50, 6, instructions)
      expect(result).to be 110
    end
  end
end
