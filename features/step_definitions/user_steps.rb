Given /I am logged in/ do
  visit "/users/auth/facebook"
  Then "I should be on the home page"
  Then "I should see \"Successfully signed in with Facebook\""
end

Given /^I am not logged in$/ do
  pending # express the regexp above with the code you wish you had
end

When /^([^ ]+ reply$/ do |provider|
  visit "/users/auth/#{provider}/callback"
end
