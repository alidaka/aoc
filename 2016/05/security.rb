require 'digest/md5'

class Security
  def self.decode(seed)
    suffix = 0
    8.times.map do |x|
      md5 = nil
      loop do
        md5 = Digest::MD5.hexdigest(seed + suffix.to_s)
        suffix += 1
        break if md5.start_with?('00000')
      end

      md5.chars[5]
    end.join
  end
end
