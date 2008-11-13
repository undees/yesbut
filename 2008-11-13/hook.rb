require 'rubygems'
require 'win32/api'

class String
  def snake_case
    gsub(/([a-z])([A-Z0-9])/, '\1_\2').downcase
  end
end


module Win32
  WH_MOUSE_LL = 14
  WM_LBUTTONDOWN = 0x201
  WM_LBUTTONUP = 0x202
  
  @@get_module_handle = API.new 'GetModuleHandle', 'L', 'L', 'kernel32'
  
  [['SetWindowsHookEx', 'LKLL', 'L'],
   ['UnhookWindowsHookEx', 'L', 'I'],
   ['CallNextHookEx', 'LLLP', 'L'],
   ['GetMessage', 'PLLL', 'I'],
   ['TranslateMessage', 'P', 'I'],
   ['DispatchMessage', 'P', 'L'],
   ['GetCursorPos', 'P', 'I']].each do |name, sig, ret|
    var = '@@' + name.snake_case
    api = API.new name, sig, ret, 'user32'
    class_variable_set var, api
  end
  
  class API
    def [](*args)
      call *args
    end
  end
end


class MouseWatcher
  include Win32

  def initialize
    @down = false
    
    @callback = API::Callback.new \
      'LLP',
      'L',
      &method(:mouse_hook)
  end
  
  def go
    mod = @@get_module_handle[0]
    @hook = @@set_windows_hook_ex[WH_MOUSE_LL, @callback, mod, 0]
    
    msg = "0" * 28
    while 0 != @@get_message[msg, 0, 0, 0]
      @@translate_message[msg]
      @@dispatch_message[msg]
    end
  rescue Interrupt
    @@unhook_windows_hook_ex[@hook]
    @hook = nil
  end

  private
  
  def mouse_hook(code, w, l)
    case w
    when WM_LBUTTONDOWN then @down = true
    when WM_LBUTTONUP then @down = false
    else if @down then
           point = "\0" * 8
           @@get_cursor_pos[point]
           x, y = point.unpack 'LL'
           puts "#{x} #{y}"
         end
    end

    @@call_next_hook_ex[@hook, code, w, l]
  end
end

MouseWatcher.new.go
