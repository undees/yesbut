require 'rmagick'
include Magick

canvas = Image.new 640, 480 do
  self.background_color = 'black'
end

finger = Image.new 20, 20 do
  self.background_color = 'black'
end

draw = Draw.new
draw.stroke 'white'
draw.stroke_opacity 0.3
draw.fill 'white'
draw.fill_opacity 0.3
draw.circle 10, 10, 5, 10
draw.draw finger

finger = finger.blur_image
finger = finger.level_channel BlueChannel, 0, QuantumRange / 128
finger = finger.recolor [1, 1, 0, 0, 0.2, 0, 0, 0, 0.9]

background = Image.read('window.png').first
background = background.modulate 0.25, 0.25

File.open('mouse.txt') do |f|
  f.each_line do |l|
    x, y = l.split.map {|s| s.to_i}
    background.composite! finger, x, y, PlusCompositeOp
  end
end

background.write 'heatmap.png'
