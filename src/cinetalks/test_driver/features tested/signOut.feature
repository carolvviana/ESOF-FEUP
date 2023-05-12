Feature: Sign out

  As a user,
  I want to sign out
  so that my account is not connected anymore.

  Background: Loging in, entering the profile page
    Given I am on the "LoginPage" page
    When I fill the "emailField" field with "sergiopeixoto3@gmail.com"
    And I fill the "passwordRegisterField" field with "123456"
    And I tap the "Login" button
    And I tap the "ProfileButton" button

  Scenario: Sign out
    When I tap the "LogoutButton" button
    Then I should be on the "LoginPage" page

