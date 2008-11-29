require 'base64'

class String
  def scramble
    Base64.encode64 self
  end
  
  def quinerize
    s = <<HERE + self
require 'base64'

class String
  def unscramble
    Base64.decode64 self
  end
end

HERE
    s.sub('%s', s.scramble)
  end
end

if __FILE__ == $0
  puts ARGF.read.quinerize
end
