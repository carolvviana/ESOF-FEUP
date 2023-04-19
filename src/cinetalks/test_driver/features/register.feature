Feature: Creating Account

  User story:
  As a user,
  I want to create an account
  So that I can use the features of the app

  Scenario: Changing to register page
    Given I am on the "LoginPage" page
    When I tap the "SignUp" button
    Then I should be on the "CreateAccountPage" page

  Scenario Outline: Register with invalid data
    Given I am on the "CreateAccountPage" page
    And I tap the "SignUp" button
    When I fill the "usernameField" field with "<Username>"
    And I fill the "emailField" field with "<Email>"
    And I fill the "passwordRegisterField" field with "<Password>"
    When I tap the "SignUpButton" button
    Then I should be on the "CreateAccountPage" page
    # And A error message appears
    # uses an email already in use
    # password has less than 6 chars
    Examples:
      | Username | Email           | Password |
      | test     | test@gmail.com  | onePass  |
      | wrong    | wrong@gmail.com | pass     |
      |          |                 |          |

  Scenario Outline: Register with valid data
    Given I am on the "CreateAccountPage" page
    And I tap the "SignUp" button
    When I fill the "usernameField" field with "<Username>"
    And I fill the "emailField" field with "<Email>"
    And I fill the "passwordRegisterField" field with "<Password>"
    When I tap the "SignUpButton" button
    Then I should be on the "HomePage" page
    # Then A error message should appear
    Examples:
      | Username | Email            | Password  |
      | admin1   | admin1@gmail.com | password1 |
      | admin2   | admin2@gmail.com | password2 |



