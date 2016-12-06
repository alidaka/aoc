require_relative 'map'

RSpec.describe Map do
  def kernel(s, expected)
    map = Map.new
    result = map.calculate(s)
    expect(result).to eq expected
  end

  it 'works simply' do
    data = 'R2, L3'
    kernel(data, 5)
  end

  it 'works in small loops' do
    data = 'R2, R2, R2'
    kernel(data, 2)
  end

  it 'can go forth' do
    data = 'R5, L5, R5, R3'
    kernel(data, 12)
  end

  it 'works for hard cases' do
    data = 'L1, R3, R1, L5, L2, L5, R4, L2, R2, R2, L2, R1, L5, R3, L4, L1, L2, R3, R5, L2, R5, L1, R2, L5, R4, R2, R2, L1, L1, R1, L3, L1, R1, L3, R5, R3, R3, L4, R4, L2, L4, R1, R1, L193, R2, L1, R54, R1, L1, R71, L4, R3, R191, R3, R2, L4, R3, R2, L2, L4, L5, R4, R1, L2, L2, L3, L2, L1, R4, R1, R5, R3, L5, R3, R4, L2, R3, L1, L3, L3, L5, L1, L3, L3, L1, R3, L3, L2, R1, L3, L1, R5, R4, R3, R2, R3, L1, L2, R4, L3, R1, L1, L1, R5, R2, R4, R5, L1, L1, R1, L2, L4, R3, L1, L3, R5, R4, R3, R3, L2, R2, L1, R4, R2, L3, L4, L2, R2, R2, L4, R3, R5, L2, R2, R4, R5, L2, L3, L2, R5, L4, L2, R3, L5, R2, L1, R1, R3, R3, L5, L2, L2, R5'
    kernel(data, 278)
  end
end
