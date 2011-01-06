Feature: Upload a FISH file
  As a fish observer
  In order to publish my observations
  I need to upload my FISH files to fishOmatic

  Scenario: New user wants to upload their first FISH file
    Given I am logged in
    And I have no FISH files
    And I am on the view my FISH files page
    And I upload the FISH file "file_1.fish"
    And I press "Upload"
    Then I should be on the page for "file_1.fish"
    And I should see "File uploaded successfully"
    And I should see FISH file "file_1.fish"

  Scenario: Existing user wants to upload another FISH file
    Given I am logged in
    And I have uploaded 'file_1.fish"
    When I go to the upload FISH file page
    And I upload the FISH file "file_2.fish"
    And I press "Upload"
    Then I should be on the page for "file_2.fish"
    And I should see "File uploaded successfully"
    And I should see FISH file "file_2.fish"

  Scenario: Upload another FISH file with the same name
    Given I am logged in
    And I have uploaded "file_1.fish"
    When I go to the upload FISH file page
    And I upload the FISH file "file_1.fish"
    And I press "Upload"
    Then I should be on the page for "file_1_1.fish"
    And I should see "File uploaded successfully"
    And I should see FISH file "file_1.fish"

  Scenario: Unknown user tries to upload a file
    Given I am not logged in
    When I go to the upload FISH file page
    Then I should be on the user login page
    And I should see "You must be logged in to upload FISH files"
