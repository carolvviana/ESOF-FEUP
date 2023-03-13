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

![image](https://user-images.githubusercontent.com/92639425/224787209-fc1e2c42-3de0-4e30-b2a6-11d3df179731.png)

 

## 2

As a user, I want to login to my account so that I can store useful data.

Given the initialization of the app  
and i have an account created  
When the login page shows up  
Then i should be able to login to my account and use the app  

Given the login page  
When i type my credentials wrong  
then the login should fail  
 
![image](https://user-images.githubusercontent.com/92639425/224787265-5161cc1f-ce47-4a81-8e4a-c35bb151c448.png)

 
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

![image](https://user-images.githubusercontent.com/92639425/224787304-40110dd5-9cb4-48a5-bffb-8e1d7a907fd4.png)


## 4
 
As a user, I want to filter my searches so that I can improve my search

![image](https://user-images.githubusercontent.com/92639425/224787347-2e892b9f-9fff-4dfa-a4b2-80e35ae9ca72.png)


## 5
 
As a user, I want to see top N movies and tv shows in my home screen so that I can immediately see what’s popular.

Given that I'm at the home page  
When i scroll through the Top N movies list  
Then i can see the top movies in display  

Given that I'm scrolling through the Top N movies  
When i reach the end of the list  
Then a plus sign appears  
and i can see the rest of the lis of movies  

![image](https://user-images.githubusercontent.com/92639425/224787400-31c74623-a9e5-47ef-a882-d00b802a1a96.png)


## 6
 
As a user, I want to see what movies are in theatres so that I can watch them.

Given that I'm at the home page  
When i scroll through the In Theaters Carousel  
Then i can see the in theaters movies in display  

Given that I'm scrolling through the in theaters carousel  
When i reach the end of the list  
Then a plus sign appears  
and i can see the rest of the list of movies  
  
![image](https://user-images.githubusercontent.com/92639425/224787482-fbeeabf5-bcb6-404a-a294-e725bf1b7036.png)
 
 
## 7

As a user, I want to see top N movies and tv shows in my home screen so that I can immediately see what’s popular.

Given that I'm at the home page  
When i scroll through the Top N tv shows list  
Then i can see the top N tv shows in display  

Given that I'm scrolling through the Top N tv shows  
When i reach the end of the list  
Then a plus sign appears  
and i can see the rest of the list of tv shows  
 
![image](https://user-images.githubusercontent.com/92639425/224787547-9f163bc4-aaf3-4928-a6af-8b969af3034b.png)
 
 
## 8

As a user, I want to click on a movie or tv show so that I can see more details.

Given a movie/tv show that is displayed in the screen  
When i click on it  
Then a page about the movie should appear  
and i can see details about that movie/tv show  
 
![image](https://user-images.githubusercontent.com/92639425/224787599-19ba8f11-8bea-417b-bc4d-b8f6d292d3a4.png)


 ## 9
As a user, I want to see top N movies and tv shows in my home screen so that I can immediately see what’s popular.

![image](https://user-images.githubusercontent.com/92639425/224787680-d23fd595-fd9f-47c7-9525-daaa7be8e7a9.png)


## 10 
As a user, I want to see top N movies and tv shows in my home screen so that I can immediately see what’s popular.

![image](https://user-images.githubusercontent.com/92639425/224787753-e0b58862-83a9-45b1-abc9-de18e7af2646.png)


## 11
As a user, I want to check movies as watched so that they are added to my watch list

![image](https://user-images.githubusercontent.com/92639425/224787824-55ca1d2a-434c-48ad-a3f0-237ee37926df.png)


 ## 12
As a user, I want to check movie as wanted so that they are added to my wish list.
 
![image](https://user-images.githubusercontent.com/92639425/224787890-f387e1b7-85f8-4f6b-be1c-163f819f7a0a.png)


## 13
As a user, I want to give my personal rating to movies so that I keep track of my liking

![image](https://user-images.githubusercontent.com/92639425/224787943-4b350252-15d6-4e7c-b8da-c35759bc53ce.png)

 
## 14
As a user, I want to check comments on the forums so that I know other opinions

Given that im in a movie page  
When I scroll down  
Then more comments show up
 
 ![image](https://user-images.githubusercontent.com/92639425/224787970-1412f696-02aa-47f5-944f-a346d1d0a7c9.png)

 
## 15
As a user, I want to write comments on the forums so that I can comment on a movie.

Given that im on a movie page  
When i type in the Add Comment Box  
Then a new comment should be added  

Given that im on a movie page  
And I click on reply button in a comment  
When i type in the Add Comment Box  
Then a new reply to that comment should be added  

![image](https://user-images.githubusercontent.com/92639425/224788024-05bfaca7-86c9-44bd-9c28-44f40d07c62d.png)


## 16
As a user, I want to see the trailer of a movie so that I know what to expect

![image](https://user-images.githubusercontent.com/92639425/224788067-7a2eb7e0-8c10-4a52-9003-01ebad528917.png)

 
## 17
As a user, I want to go to my personal page so that I can see my latest watched movies

![image](https://user-images.githubusercontent.com/92639425/224788094-e374f70c-9ff3-4d1b-9a6f-1d924debc916.png)

 
## 18
As a user, I want to got go my personal page so that I can see my Wishlist

![image](https://user-images.githubusercontent.com/92639425/224788118-c4836336-35ad-4abb-bd40-352c3ef1d658.png)


## 19
As a user, I want to edit my profile so that I can personalize my profile picture or profile name
 
![image](https://user-images.githubusercontent.com/92639425/224788141-90a9bfe7-b723-4755-acc4-e5d41fe5920f.png)
![image](https://user-images.githubusercontent.com/92639425/224788199-3761f532-d46b-4723-8a48-ec26be2ff72c.png)
![image](https://user-images.githubusercontent.com/92639425/224788165-1bdd5c01-e131-4cdc-9c7d-48b0278b1265.png)

 
 
 
