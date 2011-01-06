Given /I am logged in/ do
  visit user_omniauth_authorize_path(:facebook)
end

Given /^I am not logged in$/ do
  pending # express the regexp above with the code you wish you had
end
