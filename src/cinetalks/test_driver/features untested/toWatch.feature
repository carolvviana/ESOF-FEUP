Feature: To Watch list

As a user
I want to be able to add and remove a movie to my 'To Watch' list 
so that I can keep track of movies I want to watch.

Background: Loging in
    Given I am on the "LoginPage" page
    When I fill the "emailField" field with "sergiopeixoto3@gmail.com"
    And I fill the "passwordRegisterField" field with "123456"
    And I tap the "Login" button
    And I pause for 10 seconds

Scenario Outline: Adding movies to 'To Watch list'
  Given I am on the "HomePage" page
  And There is a "<movieId>" displayed in the screen
  When I tap the "<movieId>" button
  And I tap the "Add to Watchlist" button
  # Then I should see the "Movie added to your watchlist" message
  And I tap the "BackButton" button
  And I tap the "ProfileButton" button
  Then I should see the "<movieId>" in the "Watchlist" list
  Examples:
      | movieID   |
      | tt0111161 |
      | tt0068646 |
      | tt5491994 |