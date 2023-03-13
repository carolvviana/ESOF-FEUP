# Structure:

[User story]

[Acceptance Test]

[Mockup]



## 1

As a user, I want to create an account so that I have an identity.


Given that you open the app  
And dont have an account created  
When the user opens the app  
Then the login page shows up  

Given that the user is in the login page  
And dont have an account created  
When clicks log in  
Then the login should fail  

Given that the user is in the login page  
And dont have an account created  
When clicks in sign up  
Then a create account page shows up  

Given that the user is in the create account page  
And types the details  
When user confirms  
Then the home page shows up  

Given that you open the app  
And is logged out  
When user types login details  
Then the home page shows up  

 

## 2

As a user, I want to login to my account so that I can store useful data.

Given the initialization of the app  
and i have an account created  
When the login page shows up  
Then i should be able to login to my account and use the app  

Given the login page  
When i type my credentials wrong  
then the login should fail  
 
 
## 3
 
As a user, I want to search for movies and tv shows based on title so that they appear.

Given a movie/tv show that i want to search for, using its title  
When i click on the search bar  
Then a search page shows up  
and i will can type the title of the movie/tv show that i want to search for.  

Given that I'm at the search page  
When I want to search by filters  
Then i must click on filters button  
and I will be able to choose the filters I want.  

Given that I'm at the search page  
When I type something that is not recognized by the API  
Then a message saying that nothing was found appears.  

## 4
 
As a user, I want to filter my searches so that I can improve my search

## 5
 
As a user, I want to see top N movies and tv shows in my home screen so that I can immediately see what’s popular.

Given that I'm at the home page  
When i scroll through the Top N movies list  
Then i can see the top movies in display  

Given that I'm scrolling through the Top N movies  
When i reach the end of the list  
Then a plus sign appears  
and i can see the rest of the lis of movies  

## 6
 
As a user, I want to see what movies are in theatres so that I can watch them.

Given that I'm at the home page  
When i scroll through the In Theaters Carousel  
Then i can see the in theaters movies in display  

Given that I'm scrolling through the in theaters carousel  
When i reach the end of the list  
Then a plus sign appears  
and i can see the rest of the list of movies  
 
 
## 7

As a user, I want to see top N movies and tv shows in my home screen so that I can immediately see what’s popular.

Given that I'm at the home page  
When i scroll through the Top N tv shows list  
Then i can see the top N tv shows in display  

Given that I'm scrolling through the Top N tv shows  
When i reach the end of the list  
Then a plus sign appears  
and i can see the rest of the list of tv shows  
 
 
## 8

As a user, I want to click on a movie or tv show so that I can see more details.

Given a movie/tv show that is displayed in the screen  
When i click on it  
Then a page about the movie should appear  
and i can see details about that movie/tv show  
 
 ## 9
As a user, I want to see top N movies and tv shows in my home screen so that I can immediately see what’s popular.

## 10 
As a user, I want to see top N movies and tv shows in my home screen so that I can immediately see what’s popular.

## 11
As a user, I want to check movies as watched so that they are added to my watch list

 ## 12
As a user, I want to check movie as wanted so that they are added to my wish list.
 
## 13
As a user, I want to give my personal rating to movies so that I keep track of my liking
 
## 14
As a user, I want to check comments on the forums so that I know other opinions

Given that im in a movie page  
When I scroll down  
Then more comments show up
 
 
## 15
As a user, I want to write comments on the forums so that I can comment on a movie.

Given that im on a movie page  
When i type in the Add Comment Box  
Then a new comment should be added  

Given that im on a movie page  
And I click on reply button in a comment  
When i type in the Add Comment Box  
Then a new reply to that comment should be added  

## 16
As a user, I want to see the trailer of a movie so that I know what to expect
 
## 17
As a user, I want to go to my personal page so that I can see my latest watched movies
 
## 18
As a user, I want to got go my personal page so that I can see my Wishlist

## 19
As a user, I want to edit my profile so that I can personalize my profile picture or profile name
 
 
 
