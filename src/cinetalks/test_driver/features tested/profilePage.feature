Feature: Open Profile page

  As a user,
  I want to click on the profile button
  so that I go to my profile page.

  Background: Loging in
    Given I am on the "LoginPage" page
    When I fill the "emailField" field with "sergiopeixoto3@gmail.com"
    And I fill the "passwordRegisterField" field with "123456"
    And I tap the "Login" button


  Scenario: Open Profile Page from home page
    Given I am on the "HomePage" page
    When I tap the "ProfileButton" button
    Then I should be on the "ProfilePage" page

#falta open profile page a partir da navbar