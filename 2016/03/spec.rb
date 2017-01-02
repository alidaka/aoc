require_relative 'triangle'

RSpec.describe Triangle do
  describe 'part one' do
    it 'works for the example negative' do
      data = "5 10 25"
      result = Triangle.horizontals(data)
      expect(result).to eq 0
    end

    it 'works simply' do
      data = "5 10 25\n2 3 4"
      result = Triangle.horizontals(data)
      expect(result).to eq 1
    end

    it 'solves the problem' do
      data = File.read('input')
      result = Triangle.horizontals(data)
      expect(result).to eq 869
    end
  end

  describe 'part two' do
    it 'works simply' do
      data = "1 2 5\n2 3 10\n3 4 25"
      result = Triangle.verticals(data)
      expect(result).to eq 1
    end

    it 'solves the problem' do
      data = File.read('input')
      result = Triangle.verticals(data)
      expect(result).to eq 1544
    end
  end
end
