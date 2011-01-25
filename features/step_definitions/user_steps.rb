Given /I am logged in/ do
  visit "/users/auth/facebook"
  When "facebook reply"
  Then "I should be on the home page"
  Then "I should see \"Successfully signed in with Facebook\""
end

Given /^I am not logged in$/ do
  pending # express the regexp above with the code you wish you had
end

When /^([^ ]+) reply$/ do |provider|
  visit "/users/auth/#{provider}/callback"
end

Given /^I am not signed in$/ do
  visit "/users/sign_out"
end

Then /^I should not see the signin links$/ do
  Then 'I should not see "Facebook Signin"'
  Then 'I should not see "Twitter Signin"'
end

