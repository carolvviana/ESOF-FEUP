Feature: Login

  As a user,
  I want to login to my account
  so that I can store useful data.

  Scenario Outline: Successful login
    Given I am on the "LoginPage" page
    When I fill the "emailField" field with "<Email>"
    And I fill the "passwordRegisterField" field with "<Password>"
    And I tap the "Login" button
    Then I should be on the "HomePage" page
    Examples:
      | Email                    | Password |
      | user_teste@gmail.com     | 123456   |
      | sergiopeixoto3@gmail.com | 123456   |

  Scenario Outline: Wrong credentials
    Given I am on the "LoginPage" page
    When I fill the "emailField" field with "<Email>"
    And I fill the "passwordRegisterField" field with "<Password>"
    And I tap the "Login" button
    Then I should be on the "LoginPage" page
    And I expect the text "<error>" to be present
    Examples:
      | Email                | Password | error                                   |
      | user_@gmail.com      | password | No user found for this email.           |
      | gui@gmail.com        | 098765   | Wrong password provided for this user.  |
      | gui                  | 098765   | Invalid email.                          |

  Scenario: Empty text fields
    Given I am on the "LoginPage" page
    When I tap the "Login" button
    Then I should be on the "LoginPage" page
    And I expect the text "Email cannot be empty" to be present
