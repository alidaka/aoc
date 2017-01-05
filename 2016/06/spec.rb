require_relative 'signaler'

RSpec.describe Signal do
  describe 'part one' do
    it 'does the example' do
      data = "eedadn\n" +
             "drvtee\n" +
             "eandsr\n" +
             "raavrd\n" +
             "atevrs\n" +
             "tsrnev\n" +
             "sdttsa\n" +
             "rasrtv\n" +
             "nssdts\n" +
             "ntnada\n" +
             "svetve\n" +
             "tesnvt\n" +
             "vntsnd\n" +
             "vrdear\n" +
             "dvrsen\n" +
             "enarar"
      message = Signaler.filter(data)
      expect(message).to eq 'easter'
    end

    it 'solves the problem' do
      data = File.read('input')
      message = Signaler.filter(data)
      expect(message).to eq 'mshjnduc'
    end
  end

  describe 'part two' do
    it 'does the example' do
      data = "eedadn\n" +
             "drvtee\n" +
             "eandsr\n" +
             "raavrd\n" +
             "atevrs\n" +
             "tsrnev\n" +
             "sdttsa\n" +
             "rasrtv\n" +
             "nssdts\n" +
             "ntnada\n" +
             "svetve\n" +
             "tesnvt\n" +
             "vntsnd\n" +
             "vrdear\n" +
             "dvrsen\n" +
             "enarar"
      message = Signaler.filter_least(data)
      expect(message).to eq 'advent'
    end

    it 'solves the problem' do
      data = File.read('input')
      message = Signaler.filter_least(data)
      expect(message).to eq 'apfeeebz'
    end
  end
end
