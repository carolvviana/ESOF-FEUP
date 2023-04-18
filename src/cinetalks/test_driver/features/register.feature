Feature: Creating Account

User story: 
As a user, 
I want to create an account 
So that I can use the features of the app

Scenario: Changing to register page
  Given I am in the "LoginPage" page
  When I click in "" tab
  Then a page shows up with "emailField", "usernameField", "passwordRegisterField" and "confirmPasswordField" field to fill

Scenario Outline: Register with invalid data
  Given that the user is in the "CreateAccountPage" page
  And writes the details
  When I write the "<Email>" in the "emailField" field 
  And I write the "<Username>" in the "usernameField" field 
  And I write the "<Password>" in the "passwordRegisterField" field
  And I write the "<ConfirmPassword>" in the "confirmPasswordField" field
  When user taps the "RegisterButton" button
  Then the home page shows up
# check predefined steps: And "<ErrorMessage>" is displayed
    # check predefined steps: Fields are cleared (?)
    Examples:
    | Email              | Username | Password | ConfirmPassword |
    | admin@gmail.com    | admin    | password | password        |
    |                    |          |          |                 |
    | abcdefg@gmail.com  | abcdefg  | password | differentPass   |
    # | new_ghjk@gmail.com | admin    | password | password        |
    # we need to check for existing username for this to work