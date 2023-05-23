Feature: To Watch list

    As a user
    I want to be able to add and remove a movie from my 'To Watch' list
    so that I can keep track of movies I want to watch.

    Background: Logging in
        Given I am on the "LoginPage" page
        When I fill the "emailField" field with "gui@gmail.com"
        And I fill the "passwordRegisterField" field with "123456"
        And I tap the "Login" button
        And I pause for 3 seconds

    Scenario Outline: Adding movies to 'To Watch list'
        Given I am on the "HomePage" page
        When I tap the "nav-SearchButton" button
        And I fill the "SearchBar" field with "<search>"
        And I pause for 3 seconds
        And I tap the "<movieID>" button
        And I tap the "ToWatchButton" button
        And I pause for 2 seconds
        And I tap the "BackButton" button
        And I tap the "nav-ProfileButton" button
        Then I expect the text "<movieTitle>" to be present
        Examples:
            | movieID   | search      | movieTitle              |
            | tt1490017 | lego        | The Lego Movie          |
            | tt4116284 | lego batman | The Lego Batman Movie   |

    Scenario Outline: Removing movies from 'To Watch list'
        Given I am on the "HomePage" page
        When I tap the "nav-SearchButton" button
        And I fill the "SearchBar" field with "<search>"
        And I pause for 3 seconds
        And I tap the "<movieID>" button
        And I tap the "ToWatchButton" button
        And I pause for 2 seconds
        And I tap the "BackButton" button
        And I tap the "nav-ProfileButton" button
        Then I expect the text "<movieTitle>" to be absent
        Examples:
            | movieID   | search      | movieTitle              |
            | tt1490017 | lego        | The Lego Movie          |
            | tt4116284 | lego batman | The Lego Batman Movie   |
