Feature: Add comment to a movie

    As a user,
    I want to add a comment to a movie
    so that I can share my opinion

    Background: Loging in, entering a movie
        Given I am on the "LoginPage" page
        When I fill the "emailField" field with "sergiopeixoto3@gmail.com"
        And I fill the "passwordRegisterField" field with "123456"
        And I tap the "Login" button
        And I pause for 10 seconds
        # And I tap the "tt0111161" button
        And I tap the "nav-SearchButton" button
        When I fill the "SearchBar" field with "The Godfather"
        And I tap the "tt0068646" button
        # Then There is a "<movieId>" displayed in the screen
    #mudar o filme

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

    # go back to home, go to profile, logout, login with other accoutn, verify that comment is there
    Scenario: Add comment and check if it is there
        Given I am on the "MoviePage" page
        When I fill the "commentField" field with "This movie is awesome!"
        And I tap the "AddComment" button
        And I tap the "BackButton" button
        And I tap the "nav-ProfileButton" button
        And I tap the "LogoutButton" button
        # And I tap the "Login" button
        And I fill the "emailField" field with "jpccorreia04@gmail.com"
        And I fill the "passwordRegisterField" field with "123456789"
        And I tap the "Login" button
        And I pause for 10 seconds
        And I tap the "tt0068646" button
        Then I expect the text "This movie is awesome!" to be present




# Feature: View comments on movie page

#     As a user,
#     I want to check comments on the forums
#     so that I know other opinions


# # Scenario: View comments
# # Given I am on the "MoviePage" page
# # When I scroll "up"
# # Then I should be able to see the comments



# Scenario: View comments #2
# Given I am on the "MoviePage" page
# When I swipe up by 800 pixels on the "MoviePage" page
# Then I should be able to see the comments
