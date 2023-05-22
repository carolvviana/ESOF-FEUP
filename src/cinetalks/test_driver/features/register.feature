Feature: Creating Account

  User story:
  As a user,
  I want to create an account
  So that I can use the features of the app

  Background: Going to register page
    Given I am on the "LoginPage" page
    And I tap the "SignUp" button


  Scenario Outline: Register with invalid data
    Given I am on the "CreateAccountPage" page
    When I fill the "usernameField" field with "<Username>"
    And I fill the "emailField" field with "<Email>"
    And I fill the "passwordRegisterField" field with "<Password>"
    When I tap the "SignUpButton" button
    Then I should be on the "CreateAccountPage" page
    And I expect the text "<error>" to be present
    Examples:
      | Username | Email           | Password | error |
      | test     | test@gmail.com  | onePass  | The account already exists for that email. |
      | wrong    | wrong@gmail.com | pass     | The password is too weak.                  |
      |          |                 |          | Please enter a username.                   |
      | hello    | email           | 123456   | The email is invalid.                      |

  Scenario Outline: Register with valid data
    Given I am on the "CreateAccountPage" page
    When I fill the "usernameField" field with "<Username>"
    And I fill the "emailField" field with "<Email>"
    And I fill the "passwordRegisterField" field with "<Password>"
    When I tap the "SignUpButton" button
    Then I should be on the "HomePage" page
    Examples:
      | Username | Email            | Password  |
      | admin1   | admin1@gmail.com | password1 |
      | admin2   | admin2@gmail.com | password2 |



