
Feature: return to previous page

    As a user,
    I want to go back to previous page
    so that I continue what I was doing

    Background: Logging in
        Given I am on the "LoginPage" page
        When I fill the "emailField" field with "sergiopeixoto3@gmail.com"
        And I fill the "passwordRegisterField" field with "123456"
        And I tap the "Login" button


    Scenario: Go back from Profile Page to Home Page
        Given And I tap the "ProfileButton" button 
        And I am on the "ProfilePage" page
        When I tap the "BackButton" button
        Then I should be on the "HomePage" page

    Scenario: Go back from Movie Page to Home Page
        Given I tap the "tt0111161" button
        And I am on the "MoviePage" page
        When I tap the "BackButton" button
        Then I should be on the "HomePage" page
