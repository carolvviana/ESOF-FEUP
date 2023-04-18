Feature: Login

  As a user,
  I want to login to my account
  so that I can store useful data.

  Scenario Outline: Successful login
    Given I am in the "LoginPage" page
    When I fill the "emailField" field with "<Email>"
    And I fill the "passwordRegisterField" field with "<Password>"
    And I tap the "Login" button
    Then I should be on the "HomePage" page
    Examples:
      | Email                    | Password |
      | user_teste@gmail.com     | 123456   |
      | sergiopeixoto3@gmail.com | 123456   |

  Scenario Outline: Wrong credentials
    Given I am in the "LoginPage" page
    When I fill the "emailField" field with "<Email>"
    And I fill the "passwordRegisterField" field with "<Password>"
    And I tap the "Login" button
    Then I should be on the "LoginPage" page
      # And A error message appears
    # password is wrong
    #
    Examples:
      | Email                | Password |
      | user_teste@gmail.com | password |
      | email@gmail.com      | 123456   |

  # Verify
  Scenario: Empty text fields
    Given I am in the "LoginPage" page
    When I tap the "Login" button
    Then I should be on the "LoginPage" page
# And A error message appears
