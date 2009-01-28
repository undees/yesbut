Given /^a new document$/ do
  @doc = Document.new
end

When /^I type "(.*)"$/ do |text|
  @doc.type_in text
end

When /^I copy all the text$/ do
  @doc.select_all
  @doc.copy
end

Then /^the text should be "(.*)"$/ do |text|
  @doc.text.should == text
end

When /^I change the text to "(.*)"$/ do |text|
  @doc.select_all
  @doc.type_in text
end

When /^I paste over the text$/ do
  @doc.select_all
  @doc.paste
end

When /^I cut all the text$/ do
  @doc.select_all
  @doc.cut
end

Then /^the text should be empty$/ do
  @doc.text.should be_empty
end

When /^I undo my changes( again)?$/ do |_|
  @doc.undo
end
