Feature: Creating Account

  User story:
  As a user,
  I want to create an account
  So that I can use the features of the app

  Scenario: Changing to register page
    Given I am in the "LoginPage" page
    When I tap the "SignUp" button
    Then I should be on the "CreateAccountPage" page

  # Background:
  #   Given I am in the "LoginPage" page
  #   And I tap the "SignUp" button

  
  Scenario Outline: Register with invalid data
    Given I am in the "CreateAccountPage" page
    And I tap the "SignUp" button
    When I fill the "usernameField" field with "<Username>"
    And I fill the "emailField" field with "<Email>"
    And I fill the "passwordRegisterField" field with "<Password>"
    # And I write the "<ConfirmPassword>" in the "confirmPasswordField" field
    When I tap the "SignUpButton" button
    Then I should be on the "CreateAccountPage" page
    # And A error message appears
    # check predefined steps: And "<ErrorMessage>" is displayed
    # check predefined steps: Fields are cleared (?)
    # Examples:
    # | Email              | Username | Password | ConfirmPassword |
    # |                    |          |          |                 |
    # | wrong@gmail.com    | wronggg  | onePass  | differentPass   |
    # fields are empty
    # uses an email already in use
    # password has less than 6 chars
    Examples:
      | Username  | Email           | Password |
      | test      | test@gmail.com  | onePass  |
      | wrong     | wrong@gmail.com | pass     |
      # |                 |          |          |

  Scenario Outline: Register with valid data
    Given I am in the "CreateAccountPage" page
    And I tap the "SignUp" button
    When I fill the "usernameField" field with "<Username>"
    And I fill the "emailField" field with "<Email>"
    And I fill the "passwordRegisterField" field with "<Password>"
    # And I write the "<ConfirmPassword>" in the "confirmPasswordField" field
    When I tap the "SignUpButton" button
    # Then A error message should appear
    Then I should be on the "HomePage" page
    # Examples:
    # | Email              | Username | Password  | ConfirmPassword |
    # | admin1@gmail.com   | admin1   | password1 | password1       |
    # | admin2@gmail.com   | admin2   | password2 | password2       |
    Examples:
      | Username | Email            | Password  |
      | admin1   | admin1@gmail.com | password1 |
      | admin2   | admin2@gmail.com | password2 |



