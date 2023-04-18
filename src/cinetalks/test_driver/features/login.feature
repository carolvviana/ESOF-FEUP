Feature: Login

  As a user,
  I want to login to my account
  so that I can store useful data.

  Scenario Outline: Successful login
    Given I'm in the "LoginPage" page
    When I write the "<Email>" in the "emailField" field
    And I write the "<Password>" in the "passwordRegisterField" field
    And I tap the "Login" button
    Then I should be on "HomePage" page
    Examples:
      | Email                    | Password |
      | user_teste@gmail.com     | 123456   |
      | sergiopeixoto3@gmail.com | 123456   |

  Scenario Outline: Wrong credentials
    Given I'm in the "LoginPage" page
    When I write the "<Email>" in the "emailField" field
    And I write the "<Password>" in the "passwordRegisterField" field
    And I tap the "Login" button
    Then I should be on "LoginPage" page
    And A error message appears

  # Verify
  Scenario: Empty text fields
    Given I'm in the "LoginPage" page
    When I tap the "Login" button
    Then I should be on "LoginPage" page
    And A error message appears

  Scenario: ???
    Given that you open the app
    And is logged out
    When user types login details
    Then the home page shows up