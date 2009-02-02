require 'curb'
require 'cgi'
require 'spec/expectations'

class PhoneDriver
  def initialize
    @curl = Curl::Easy.new 'http://localhost:3001/'
  end

  def method_missing(name, *args, &block)
    command = name.to_s.gsub(/_([a-z0-9])/) {$1.capitalize}
    xpath = Phone::Dict.new(args.shift).to_xpath
    extras = args.shift || []

    xml = Phone::Command.new(
      command,
      ['viewXPath', xpath] + extras).to_xml

    @curl.http_post 'q=' + CGI.escape(xml)
    @curl.body_str.strip.should == 'pass'
  end
end

Given /^a list of items$/ do
  @phone = PhoneDriver.new
end

When /^I scroll to row (.*)$/ do |row|
  @phone.scroll_to_row ['className', 'UITableView'], ['rowIndex', row]
end

When /^I touch the row marked "(.*)"$/ do |name|
  @phone.simulate_touch ['className', 'UITableViewCell', 'text', name]
end

When /^I touch the "(.*)" button$/ do |name|
  @phone.simulate_touch ['className', 'UIRoundedRectButton', 'currentTitle', name]
end

Then /^the label text should be "(.*)"$/ do |text|
  @phone.check_match_count ['className', 'UILabel', 'text', text], ['matchCount', 1]
end

at_exit {Curl::Easy.http_post 'http://localhost:3001/', 'q=' + CGI.escape(Phone::Command.empty)}
