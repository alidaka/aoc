require_relative 'protocol'

RSpec.describe Protocol do
  describe 'part one' do
    it 'requires the outer abba' do
      address = 'abba[mnop]qrst'
      result = Protocol.supports_tls?(address)
      expect(result).to be true
    end

    it 'prohibits the inner abba' do
      address = 'abcd[bddb]xyyx'
      result = Protocol.supports_tls?(address)
      expect(result).to be false
    end

    it 'requires the abba to be different characters' do
      address = 'aaaa[qwer]tyui'
      result = Protocol.supports_tls?(address)
      expect(result).to be false
    end

    it 'detects address-interior abbas' do
      address = 'ioxxoj[asdfgh]zxcvbn'
      result = Protocol.supports_tls?(address)
      expect(result).to be true
    end
  end
end
