# Requirements - User Stories, Acceptance Tests and Mockups

## Navbar
As a user, I want to have a navbar, so that I can navigate through home page, search page and profile page.

Given that I have the navbar in display <br>
When I click on search button <br>
Then I go to the search page <br>

Given that I have the navbar in display <br>
When I click on profile button <br>
Then I go to the profile page<br>

Given that I have the navbar in display<br>
When I click on home page button <br>
Then I go to the home page<br>

![image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/92639425/bf510788-d2f4-4a86-84c8-ed3c3683319c)
<br>
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/34020f90-8537-4611-95a5-62b4bdca03b2)
<br>
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/8c318066-6d14-4b15-8a2c-b90844442c65)

## To Watch List
As a user, I want to have a To Watch List so that I can keep track of which movies I want to watch.

Given that I am at my personal page<br>
When I scroll through the To Watch List carroussel<br>
Then I can see all the movies I want to see.<br>

![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/0fe1023f-aafe-4614-8e55-bf190f6b934b)
<br>
![image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/92639425/45957937-08eb-402e-82a8-73f46c411eda)


As a user, I want to check movie as wanted so that they are added to my 'to watch' list.

Given that I'm at a movie/tv show page<br>
When I click on the heart icon<br>
Then the movie will be added to my 'To Watch' list<br>


![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/bbd61d72-1a6f-4431-a4ad-64b96da54ebd)
<br>
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/3f45ae83-bb67-435b-858e-524f542a5491)
<br>
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/0c83e87a-5aa5-4ec9-ab65-7a83eb68e4eb)

## Watched List
As a user, I want to have a Watched List so that I can keep track of which movies I watched.

Given that I'm at my personal page<br>
When I scroll through the Watched List carroussel<br>
Then i will be able to see my watched movies<br>

![image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/92639425/3579a64f-5ace-42ec-b483-93decd9cde66)

As a user, I want to check movies as watched so that they are added to my 'watched' list

Given that I'm at a movie/tv show page <br>
When I click on the Watched icon<br>
Then the movie will be added to my watchlist <br>


![image](https://user-images.githubusercontent.com/92639425/224558979-4fbfe94a-619e-43e2-b811-567a9448eb15.png)
<br>
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/0a25e7bf-6d41-4418-b8cb-d8960b135b9a)
<br>
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/d6de03cb-314c-4ea0-837a-a678aa6eaa69)

## Trailer - Movie Page
As a user, I want to see the trailer of a movie so that I know what the movie is about

Given that I'm at a movie/tv show page<br>
When I click on the play button<br>
Then I will see the trailer of the movie/tv show<br>

![image](https://user-images.githubusercontent.com/92639425/234939784-70ac9353-8adb-4d1b-9940-f405c1557b2b.png)

## Comment Forum
As a user, I want to check comments on the forums so that I can see other users comments

Given that I'm in a movie page<br>
When I scroll down<br>
Then all the comments show up<br>

![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/56ee9f28-74ff-4a35-99f2-275e1e924a37)

## Comment on movie
As a user, I want to write comments on the forums so that I can comment on a movie and share my opinion.

Given that I'm on a movie page<br>
When I type in the Add Comment Box<br>
And click the "Send" icon<br>
Then a new comment is added to that movie<br>

Given that I'm on a movie page<br>
When I do not type anything in the Add Comment Box<br>
And click the "Send" icon<br>
Then an error message shows up<br>

Given I wrote a comment on a movie page<br>
When another users logs in <br>
And goes to that movie page<br>
Then he sees the comment I wrote<br>


### Successful coment:
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/9b2106df-614b-482c-a616-abf24cc9b593)
<br>
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/9cfa22ca-875a-40b4-a5ae-ae387a7e971f)

### Comment with error:
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/ed30c4b4-c5a0-41be-b4c0-0f5dc3964bdf)

## Reply to a comment
As a user, I want to reply to a comment so that I can express my thoughts about one's opinion.

Given that I'm on a movie page<br>
And I click on the reply button in a comment<br>
When I type in the Add Comment Box<br>
And click the "reply" button<br>
Then a new reply to that comment is added<br>

Given that I'm on a movie page<br>
And I click on reply button in a comment<br>
When I do not type anything in the Add Comment Box<br>
And click the "reply" button<br>
Then an error message shows up<br>

Given that I replied to someone's comment in a movie page<br>
When another user logs in<br>
And goes to that movie page<br>
Then he sees the reply I wrote<br>


### Successful reply:
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/d9409c89-ac7d-4f5a-b82c-65f93ebe1ea2)
<br>
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/46dd8aab-7772-4b50-bdf5-d6a09c55bf85)

### Error in reply:
![image](https://user-images.githubusercontent.com/92639425/232852486-27a85036-6b8b-4f5f-98b4-6d7c5c349723.png)

## Personal Rating
As a user, I want to give my personal rating to movies so that I know what I thought about a movie on a scale of 1-10.

Given that I'm on a movie/TV show page<br>
And I have never given any rating to that movie<br>
Then a message saying "Enter your rating" appears"<br>

Given that I'm on a movie/TV show page<br>
When I click on my rating<br>
Then a toggle shows up<br>
And I will be able to give my personal rating.<br>

Given that I'm on a movie/TV show page<br>
And I have given my rating before <br>
Then I can change that rating<br>
And give a new one<br>


### Rating given:
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/d2a2ed36-bea3-43a5-a44e-a13e04a9b8d6)

### No rating:
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/3a3e1629-0b09-43c8-8c50-bddafcd15bd9)

### Giving a rating:
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/a741cc48-7d72-419d-9ccf-a27ec78c861b)
<br>
![image](https://user-images.githubusercontent.com/92639425/224559023-e4d16402-dbbc-43a6-b2f8-0d8c97f9f2f6.png)

## Top 250 TV Shows
As a user, I want to see top 250 tv shows in my home screen so that I can immediately see which TV Shows are on that list - best acclaimed.

Given I am at the home page<br>
When I click the "See more" button at the top of the Top 250 TV shows carroussel<br>
Then a new page shows up<br>
And I can see the Top 250 TV shows.<br>

Given that I'm at the home page<br>
When i scroll through the Top 250 tv shows list<br>
Then i can see the top 250 tv shows in display<br>

![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/df6d45cd-30e1-48a1-863e-e4301a5c7fdf)

## In Theaters 
As a user, I want to see what movies/tv shows are in theatres so that I know which movies/tv shows I can watch at the cinema.

Given that I'm at the home page<br>
When i scroll through the In Theaters Carousel <br>
Then i can see the in theaters movies in display<br>


![image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/92639425/db26e982-944a-4762-a690-a8bfbda0039c)

## Top 250 Movies
As a user, I want to see top 250 movies in my home screen so that I can immediately see which movies are on that list - best acclaimed.

Given that I'm at the home page <br>
When I scroll through the Top 250 movies list <br>
Then I can see the top movies in display<br>

Given that I'm at the home page<br>
When i click the "See more" button at the top of the Top 250 movie list<br>
Then a page with the whole list appears<br>


![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/90401390-8ccb-4852-ae07-47bb95398833)
<br>
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/31eead1d-639a-448c-8891-5277d9f1a3a7)

## Search Bar
As a user, I want to search for movies and tv shows based on title so that they appear.

Given that I'm on the home page<br>
When i click on the search bar icon in the navbar<br>
Then the search page shows up<br>
and i can type the title of the movie/tv show that i want to search for.<br>

Given that I’m at the search page <br>
and I click on the search bar<br>
When I type something<br>
Then a list of movies and TV shows with that title show up.<br>

Given that I'm at the search page<br>
When I haven't typed anything yet <br>
Then a message saying that no search was made appears.<br>


![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/3cbe0dc5-fe2e-400b-ab1a-f1c82adc14d8)
<br>
![Image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/93731538/d845ef47-1cf8-4778-986f-701122d31050)

## Login
As a user, I want to login to my account so that I can store useful data.

Given that I’m in the login page <br>
And I already have an account <br>
When I insert my credentials in username and password <br>
And click on login button <br>
Then the login will be successful<br>

Given that I’m in the login page <br>
When I insert my credentials wrong <br>
Then the login will fail <br>
And error message appears<br>

Given that the user is in the login page<br>
And dont have an account created<br>
When clicks log in<br>
Then the login should fail<br>


![image](https://user-images.githubusercontent.com/92639425/224558503-4abc579d-4826-4b5d-af97-f6b8e9f7f0d2.png)
<br>
![image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T4/assets/92639425/59616b36-c9f1-41bd-aeb5-7bb464c75669)
<br>
![image](https://user-images.githubusercontent.com/92639425/236310612-f1b170a8-5d6c-4eaf-95ea-d6157ed291ab.png)
<br>
![image](https://user-images.githubusercontent.com/92639425/236310746-893fcc66-8730-4520-90b9-ecb55b4597ef.png)

## Register
As a user, I want to create an account so that I can use the features of the app.

Given that you open the app<br>
And dont have an account created<br>
When the user opens the app <br>
Then the login page shows up<br>

Given that I open the app <br>
And want to create an account <br>
When I click in sign up <br>
Then a page shows up with login and password place to fill<br>

Given that the user is in the create account page<br>
And writes the details<br>
When user confirms<br>
Then the home page shows up<br>

Given that you open the app<br>
And is logged out<br>
When user types login details<br>
Then the home page shows up<br>

![image](https://user-images.githubusercontent.com/92639425/232332594-8f0976ec-5e06-45df-a870-d18c9d16f6d2.png)
<br>
![image](https://user-images.githubusercontent.com/92639425/232332615-82dc714a-57fa-4160-8811-cfdd27174eec.png)
<br>
![image](https://user-images.githubusercontent.com/92639425/232332626-9fb602b1-4110-4b4e-b218-92537dc077c0.png)
<br>
![image](https://user-images.githubusercontent.com/92639425/232332638-8ff0af50-192c-4aba-878a-04f2cde33926.png)
<br>
![image](https://user-images.githubusercontent.com/92639425/232332652-3a82b97a-5b1d-4528-8d08-97373c5f4275.png)



## Next Features (to be implemented if we had the time)

### Edit personal page
As a user, I want to edit my profile so that I can personalize my profile picture or profile name

Given that im at my personal page<br>
When i click on the pencil icon<br>
Then i will be able to do changes in my profile<br>

Given that i clicked on the pencil icon<br>
When I click on username<br>
Then i will be able to change my username<br>

Given that i click on the pencil icon <br>
When i click on an avatar <br>
Then my profile picture will be changed to the respective avatar<br>

![image](https://user-images.githubusercontent.com/92639425/232334589-8c6129d8-1901-484c-94f2-aa609c268b8f.png)
<br>
![image](https://user-images.githubusercontent.com/92639425/232334595-13b647fc-fb7e-43f7-8030-8246f1cb118e.png)
<br>
![image](https://user-images.githubusercontent.com/92639425/232334601-c359d211-fc39-4303-8121-fb76efc184b3.png)
<br>
![image](https://user-images.githubusercontent.com/92639425/234937773-e3eb38ee-976a-4fbc-a9a9-89923e43374a.png)

### Filter
As a user, I want to use filters so that I can improve my search

Given that I’m at the search page<br>
and I want to search by filters<br>
when I click on the filters button<br>
then I can choose the filters I want<br>

Given that i choose the filters i want<br>
When i click on search<br>
Then the search will be filtered <br>

![image](https://user-images.githubusercontent.com/92639425/232334386-ebb38057-83bf-49c3-af42-8ef57902c6ce.png)


