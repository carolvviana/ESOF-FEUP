Feature: Add to Watched List

    As a user,
    I want to add a movie to my watched list
    so that I can keep track of the movies I've watched

    Background: Loging in, entering a movie
        Given I am on the "LoginPage" page
        When I fill the "emailField" field with "sergiopeixoto3@gmail.com"
        And I fill the "passwordRegisterField" field with "123456"
        And I tap the "Login" button
        And I pause for 10 seconds
        And I tap the "tt0111161" button

     Scenario: Add to Watched List
        Given I am on the "MoviePage" page
        When I tap the "AddToWatched" button
        Then I expect the "AddToWatched" button to be  