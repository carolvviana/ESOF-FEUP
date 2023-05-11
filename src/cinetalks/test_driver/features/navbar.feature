Feature: Navbar


  Background: Loging in
    Given I am on the "LoginPage" page
    When I fill the "emailField" field with "sergiopeixoto3@gmail.com"
    And I fill the "passwordRegisterField" field with "123456"
    And I tap the "Login" button

  Scenario: Go to Search Page
    When I tap the "nav-SearchButton" button
    Then I should be on the "SearchPage" page

  Scenario: Go to Home Page
    When I tap the "nav-HomeButton" button
    Then I should be on the "HomePage" page

  Scenario: Go to Profile Page
    When I tap the "nav-ProfileButton" button
    Then I should be on the "ProfilePage" page