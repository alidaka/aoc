require_relative 'room'

RSpec.describe Room do
  describe 'part one' do
    it 'can parse a sample input' do
      data = 'aaaa-bbb-z-y-x-123[abxyz]'
      result = Room.parse(data)
      expect(result[0]).to eq 'aaaabbbzyx'
      expect(result[1]).to eq 'abxyz'
      expect(result[2]).to eq 123
    end

    it 'identifies a simple positive case' do
      data = 'aaaa-bbb-z-y-x-123[abxyz]'
      result = Room.desect(data)
      expect(result).to eq 123
    end

    it 'identifies a simple negative case' do
      data = 'totally-real-room-200[decoy]'
      result = Room.desect(data)
      expect(result).to eq 0
    end

    it 'handles tied letters' do
      data = 'a-b-c-d-e-f-g-h-987[abcde]'
      result = Room.desect(data)
      expect(result).to eq 987
    end

    it 'handles a slightly harder case' do
      data = 'not-a-real-room-404[oarel]'
      result = Room.desect(data)
      expect(result).to eq 404
    end

    it 'works for several inputs' do
      data = "aaaa-bbb-z-y-x-123[abxyz]\ntotally-real-room-200[decoy]\na-b-c-d-e-f-g-h-987[abcde]\nnot-a-real-room-404[oarel]"
      result = Room.desect(data)
      expect(result).to eq (123+404+987)
    end
  end

  describe 'part two' do
  end
end
