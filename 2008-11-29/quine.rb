require 'base64'

class String
  def extract
    Base64.decode64 self
  end
end

s = "cmVxdWlyZSAnYmFzZTY0JwoKY2xhc3MgU3RyaW5nCiAgZGVmIGV4dHJhY3QK
ICAgIEJhc2U2NC5kZWNvZGU2NCBzZWxmCiAgZW5kCmVuZAoKcyA9ICIlcyIK
CnB1dHMgcy5leHRyYWN0LnN1YigiJXMiLCBzKQo=
"

puts s.extract.sub("%s", s)
