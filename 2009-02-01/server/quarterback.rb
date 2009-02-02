require 'rubygems'
require 'sinatra'
require 'fileutils'

get '/' do
  sleep 0.2 until File.exists? 'step.txt'
  File.open('step.txt', 'r') {|f| f.read}
end

get %r{/(.+)} do
  result = params[:captures].first
  FileUtils.rm 'step.txt' rescue nil
  File.open('result.txt', 'w') {|f| f.puts result}
end
