require 'appscript'

class Document
  include Appscript

  def initialize
    app('TextEdit').activate
  end

  DontSave = 2
  
  def close
    menu 'TextEdit', 'Quit TextEdit'
    
    begin
      app('System Events').
        processes['TextEdit'].
        windows['Untitled'].
        sheets[1].
        buttons[DontSave].
        click
    rescue CommandError
      # no confirmation dialog appeared; this is ok
    end
    
    sleep 1
  end
  
  def type_in(text)
    events = app('System Events')
    text.split(//).each {|k| events.keystroke k}
  end
  
  def text
    app('System Events').
      processes['TextEdit'].
      windows['Untitled'].
      scroll_areas[1].
      text_areas[1].
      value.
      get
  end
  
  Undo = 1
  def undo; menu('Edit', Undo) end
  def cut; menu('Edit', 'Cut') end
  def copy; menu('Edit', 'Copy') end
  def paste; menu('Edit', 'Paste') end
  def select_all; menu('Edit', 'Select All') end
  
  private
  
  def menu(name, item)
    app('System Events').
      processes['TextEdit'].
      menu_bars[1].
      menu_bar_items[name].
      menus[name].
      menu_items[item].
      click
    sleep 0.5
  end
end
