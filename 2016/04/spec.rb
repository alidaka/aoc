require_relative 'room'

RSpec.describe Room do
  describe 'part one' do
    it 'can parse a sample input' do
      data = 'aaaa-bbb-z-y-x-123[abxyz]'
      room = Room.new(data)
      expect(room.encrypted_name).to eq 'aaaa-bbb-z-y-x'
      expect(room.flat_name).to eq 'aaaabbbzyx'
      expect(room.checksum).to eq 'abxyz'
      expect(room.sector_id).to eq 123
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

    it 'solves the problem' do
      data = File.read('input')
      result = Room.desect(data)
      expect(result).to eq 409147
    end
  end

  describe 'part two' do
    it 'shifts a single word' do
      word = 'qzmt'
      result = Room.shift(word, 343)
      expect(result).to eq 'very'
    end

    it 'shifts a phrase' do
      phrase = 'qzmt-zixmtkozy-ivhz'
      result = Room.shift(phrase, 343)
      expect(result).to eq 'very encrypted name'
    end

    it 'solves the problem' do
      data = File.read('input')
      room = Room.decode(data)
      expect(room.decrypted_name).to eq 'northpole object storage'
      expect(room.sector_id).to eq 991
    end
  end
end
