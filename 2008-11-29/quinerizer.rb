require 'base64'

class String
  def infuse
    Base64.encode64 self
  end
  
  def quinerize
    s = <<HERE + self
require 'base64'

class String
  def extract
    Base64.decode64 self
  end
end

HERE
    s.sub('%s', s.infuse)
  end
end

if __FILE__ == $0
  puts ARGF.read.quinerize
end
