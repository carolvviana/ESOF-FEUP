Feature: Creating Account

  User story:
  As a user,
  I want to create an account
  So that I can use the features of the app

  Scenario: Changing to register page
    Given I am in the "LoginPage" page
    When I tap the "SignUp" button
    Then I should be on the "CreateAccountPage" page

  Scenario Outline: Register with valid data
    Given I'm in the "CreateAccountPage" page
    When I write the "<Email>" in the "emailField" field
    And I write the "<Username>" in the "usernameField" field
    And I write the "<Password>" in the "passwordRegisterField" field
    # And I write the "<ConfirmPassword>" in the "confirmPasswordField" field
    When I tap the "RegisterButton" button
    Then A error message should appear
    Then I should be on the "HomePage" page
    # Examples:
    # | Email              | Username | Password  | ConfirmPassword |
    # | admin1@gmail.com   | admin1   | password1 | password1       |
    # | admin2@gmail.com   | admin2   | password2 | password2       |
    Examples:
      | Email            | Username | Password  |
      | admin1@gmail.com | admin1   | password1 |
      | admin2@gmail.com | admin2   | password2 |



  Scenario Outline: Register with invalid data
    Given I'm in the "CreateAccountPage" page
    When I write the "<Email>" in the "emailField" field
    And I write the "<Username>" in the "usernameField" field
    And I write the "<Password>" in the "passwordRegisterField" field
    # And I write the "<ConfirmPassword>" in the "confirmPasswordField" field
    When I tap the "RegisterButton" button
    Then I should be on "CreateAccountPage" page
    And A error message appears
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
      | Email           | Username | Password |
      |                 |          |          |
      | test@gmail.com  | test     | onePass  |
      | wrong@gmail.com | wrong    | pass     |
