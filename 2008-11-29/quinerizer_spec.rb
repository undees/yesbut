require 'quinerizer'

module OutputHelper
  def puts(*args)
    args.first
  end
end

describe "String#quinerizer" do
  include OutputHelper

  it 'makes quines' do
    template = <<-HERE
s = "%s"

puts s.extract.sub("%s", s)
    HERE
    
    quine = template.quinerize
    eval(quine, binding).should == quine
  end
end
