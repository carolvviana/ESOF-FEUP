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
        And I tap the "nav-SearchButton" button

    Scenario Outline: Search movie
        Given I am on the "SearchPage" page
        When I fill the "SearchBar" field with "<movieTitle>"
        Then There is a "<movieId>" displayed in the screen
        Examples:
            | movieId   | movieTitle        |
            | tt0068646 | The Godfather     |
            | tt5491994 | Planet Earth II   |


# new 