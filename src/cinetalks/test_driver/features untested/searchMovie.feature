Feature: Search movie

    As a user,
    I want to search for a movie
    so that I can find it faster

    Background: Loging in, entering a movie
        Given I am on the "LoginPage" page
        When I fill the "emailField" field with "sergiopeixoto3@gmail.com"
        And I fill the "passwordRegisterField" field with "123456"
        And I tap the "Login" button
        And I pause for 10 seconds
        And I tap the "navbarsearchbutton" button

    Scenario: Search movie
        Given I am on the "SearchPage" page
        When I fill the "searchField" field with "The Godfather"
        And I tap the "searchButton" button
        Then There is a "tt0068646" displayed in the screen
        # Then I expect the text "The Godfather" to be present
        # Then I expect the text "The Godfather" to be present