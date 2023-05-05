
Feature: Go back from Movie Page to Home Page

    As a user, 
    I want to go back to previous page
    so that I continue what I was doing

    Background: Logging in
    Given I am on the "LoginPage" page
    When I fill the "emailField" field with "sergiopeixoto3@gmail.com"
    And I fill the "passwordRegisterField" field with "123456"
    And I tap the "Login" button
    And I pause for 10 seconds
    And I tap the "ProfileButton" button 


Scenario: Go back from Profile Page to Home Page
Given I am on the "ProfilePage" page
When I tap the back button
Then I should go to "HomePage" page
