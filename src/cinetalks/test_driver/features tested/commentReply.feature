Feature: Reply to a comment

    As a user,
    I want to reply to a comment
    so that i can express my thoughts about one's opinion

    Background: Loging in, entering a movie
        Given I am on the "LoginPage" page
        When I fill the "emailField" field with "sergiopeixoto3@gmail.com"
        And I fill the "passwordRegisterField" field with "123456"
        And I tap the "Login" button
        And I pause for 10 seconds
        And I tap the "tt5491994" button
        

    Scenario: Add valid reply
        Given I am on the "MoviePage" page
        When I tap the "ReplyButton" button
        And I fill the "commentField" field with "Agreed"
        And I tap the "AddComment" button
        Then I expect the text "Agreed" to be present

    Scenario: Add reply with empty field
        Given I am on the "MoviePage" page
        When I tap the "ReplyButton" button
        And I fill the "commentField" field with ""
        And I tap the "AddComment" button
        Then I expect the text "Reply cannot be empty" to be present

