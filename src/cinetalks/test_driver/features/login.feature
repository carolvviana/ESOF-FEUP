Feature: Login

    As a user, I want to login to my account so that I can store useful data.

    Scenario: Successful login
      Given I'm in the login page
      And I already have an account
      When I insert my credentials in username and password
      And click on login button

    Scenario: Wrong credentials
      Given I'm in the login page
      When I insert my credentials wrong
      Then the login will fail
      And error message appears

    # Verify
    Scenario: Don't have an account
      Given I'm in the login page
      And Dont have an account created
      When clicks log in
      Then the login should fail