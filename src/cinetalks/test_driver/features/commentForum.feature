Feature: Add comment to a movie

    As a user,
    I want to add a comment to a movie
    so that I can share my opinion

    Background: Logging in, entering a movie
        Given I am on the "LoginPage" page
        When I fill the "emailField" field with "sergiopeixoto3@gmail.com"
        And I fill the "passwordRegisterField" field with "123456"
        And I tap the "Login" button
        And I pause for 5 seconds
        And I tap the "nav-SearchButton" button
        And I fill the "SearchBar" field with "lego"
        And I pause for 5 seconds
        And I tap the "tt1490017" button

    Scenario: Add comment
        Given I am on the "MoviePage" page
        When I fill the "commentField" field with "This movie is awesome!"
        And I tap the "AddComment" button
        Then I expect the text "This movie is awesome!" to be present

    Scenario: Add an empty comment
        Given I am on the "MoviePage" page
        When I fill the "commentField" field with ""
        And I tap the "AddComment" button
        Then I expect the text "Comment cannot be empty" to be present

    Scenario: Add comment and check if it is there
        Given I am on the "MoviePage" page
        When I fill the "commentField" field with "This movie is awesome!"
        And I tap the "AddComment" button
        And I tap the "BackButton" button
        And I tap the "nav-ProfileButton" button
        And I tap the "LogoutButton" button
        And I fill the "emailField" field with "jpccorreia04@gmail.com"
        And I fill the "passwordRegisterField" field with "123456789"
        And I tap the "Login" button
        And I pause for 5 seconds
        And I tap the "nav-SearchButton" button
        And I fill the "SearchBar" field with "lego"
        And I pause for 5 seconds
        And I tap the "tt1490017" button
        Then I expect the text "This movie is awesome!" to be present
