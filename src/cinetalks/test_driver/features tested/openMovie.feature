#DONE
Feature: Open movie/TV show page

  As a user,
  I want to click on a movie or tv show
  so that I can see more details.

  Background: Logging in
    Given I am on the "LoginPage" page
    When I fill the "emailField" field with "sergiopeixoto3@gmail.com"
    And I fill the "passwordRegisterField" field with "123456"
    And I tap the "Login" button
    And I pause for 10 seconds


  Scenario Outline: Open movie/TV show page from home
    Given I am on the "HomePage" page
    And There is a "<movieId>" displayed in the screen
    When I tap the "<movieId>" button
    Then I should be on the "MoviePage" page
    Examples:
      | movieId   |
      | tt0111161 |
      | tt0903747 |