require_relative 'security'

RSpec.describe Security do
  describe 'part one' do
    it 'does the example' do
      data = 'abc'
      password = Security.decode(data)
      expect(password).to eq '18f47a30'
    end

    it 'solves the problem' do
      data = 'uqwqemis'
      password = Security.decode(data)
      expect(password).to eq '1a3099aa'
    end
  end

  describe 'part two' do
    it 'does the example' do
      data = 'abc'
      password = Security.decode_positional(data)
      expect(password).to eq '05ace8e3'
    end

    it 'solves the problem' do
      data = 'uqwqemis'
      password = Security.decode_positional(data)
      expect(password).to eq '694190cd'
    end
  end
end
