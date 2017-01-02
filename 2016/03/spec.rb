require_relative 'triangle'

RSpec.describe Triangle do
  describe 'part one' do
    it 'works for the example negative' do
      data = "5 10 25"
      result = Triangle.legits(data)
      expect(result).to eq 0
    end

    it 'works simply' do
      data = "5 10 25\n2 3 4"
      result = Triangle.legits(data)
      expect(result).to eq 1
    end

    it 'solves the problem' do
      data = File.read('input')
      result = Triangle.legits(data)
      expect(result).to eq 869
    end
  end
end
