require_relative 'protocol'

RSpec.describe Protocol do
  describe 'part one: TLS, abba' do
    it 'requires the supernet abba' do
      address = 'abba[mnop]qrst'
      result = Protocol.supports_tls?(address)
      expect(result).to be true
    end

    it 'prohibits the hypernet abba' do
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

    it 'handles multiple hypernet sections' do
      address = 'abcd[bdb]xyyx[foo]aaaa'
      result = Protocol.supports_tls?(address)
      expect(result).to be true
    end

    it 'prohibits an abba in a later hypernet section' do
      address = 'abcd[fdfd]abcd[bddb]xyyx'
      result = Protocol.supports_tls?(address)
      expect(result).to be false
    end

    it 'solves the problem' do
      addresses = File.read('input')
      result = Protocol.count_supported_tls(addresses)
      expect(result).to eq 105
    end
  end

  xdescribe 'part two: SSL, aba/bab' do
    it 'handles a simple positive case' do
      address = 'aba[bab]xyz'
      result = protocol.supports_ssl?(address)
      expect(result).to be true
    end

    it 'handles a simple negative case' do
      address = 'xyx[xyx]xyx'
      result = protocol.supports_ssl?(address)
      expect(result).to be false
    end

    it 'handles a positive case with aba at the end' do
      address = 'aaa[kek]eke'
      result = protocol.supports_ssl?(address)
      expect(result).to be true
    end

    it 'handles a positive case with red herrings' do
      address = 'zazbz[bzb]cdb'
      result = protocol.supports_ssl?(address)
      expect(result).to be true
    end

    it 'solves the problem' do
      addresses = File.read('input')
      result = Protocol.count_supported_ssl(addresses)
      expect(result).to eq 0
    end
  end
end
