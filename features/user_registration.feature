Feature: User Registration
  In order to keep track of my observation files
  As a fish observer
  I need to be able to identify myself with the system

  Scenario: Sign in with facebook
    Given I am on the home page
    And I am not signed in
    When I follow "Facebook Signin"
    And facebook reply
    Then I should see "Successfully signed in with Facebook"
    And I should not see the signin links
