Feature: Login

    As a user, 
    I want to login to my account 
    so that I can store useful data.

    Scenario: Successful login
      Given I'm in the "LoginPage" page
      And I already have an account
      When I insert my "username" in the "username" field
      And I insert my "password" in the "password" field
      And click on "login" button
      Then the login will be successful

    Scenario: Wrong credentials
      Given I'm in the "LoginPage" page
      When I insert my credentials wrong
      Then the login will fail
      And error message appears

    # Verify
    Scenario: Don't have an account
      Given I'm in the login page
      And Dont have an account created
      When clicks log in
      Then the login should fail

    Scenario: ???
      Given that you open the app
      And is logged out
      When user types login details
      Then the home page shows up