require 'rubygems'
require 'sinatra'
require 'fileutils'

post '/' do
  FileUtils.rm 'result.txt' rescue nil
  File.open('step.txt', 'w') {|f| f.puts params['q']}
  sleep 0.2 until File.exists? 'result.txt'
  File.open('result.txt', 'r') {|f| f.read}
end
