require 'digest/md5'

class Security
  def self.decode(seed)
    password = ''
    md5_prefixes(seed) do |md5|
      password += md5.chars[5]
      return password if password.length == 8
    end
  end

  def self.decode_positional(seed)
    password = Array.new(8)
    md5_prefixes(seed) do |md5|
      position = md5.chars[5].ord - 48
      next if position < 0 || position > 7 || !password[position].nil?

      password[position] = md5.chars[6]
      return password.join if !password.include?(nil)
    end
  end

  def self.md5_prefixes(seed)
    suffix = 0
    loop do
      md5 = Digest::MD5.hexdigest(seed + suffix.to_s)
      suffix += 1
      puts suffix if md5.start_with?('00000')
      yield md5 if md5.start_with?('00000')
    end
  end
end
