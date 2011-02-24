Then /^"([^"]*)" should be "([^"]*)"$/ do |constant, value|
  eval(constant).should == value
end

