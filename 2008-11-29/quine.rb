require 'base64'

class String
  def unscramble
    Base64.decode64 self
  end
end

s = "cmVxdWlyZSAnYmFzZTY0JwoKY2xhc3MgU3RyaW5nCiAgZGVmIHVuc2NyYW1i
bGUKICAgIEJhc2U2NC5kZWNvZGU2NCBzZWxmCiAgZW5kCmVuZAoKcyA9ICIl
cyIKCnB1dHMgcy51bnNjcmFtYmxlLnN1YigiJXMiLCBzKQo=
"

puts s.unscramble.sub("%s", s)
