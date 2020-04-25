# Library_Application_Mobile
Mobile Application for Library project based on Flutter.

The project is part of the final project for "SEP 759:Prototyping Web and Mobile Applications"

Application Flow Description 

The system contains two types of users: normal users and library staff. By default, the role of new users would be ‘normal user’ instead of ‘employee’. Employee account is not opened for signing up, it will be added to the system by the system administrator of the library only.

New user can sign up to the system using their email. And can sign in using their credential. Users can also upload an avatar image when they edit their profiles. It would be stored using ActiveStorage in Rails. 

Normal users:
•	When login, they can see different categories of books, they can choose different categories to see the corresponding book list.
•	They can have a list of favorite books, they can add books to their favorite book list, and delete them from the list.
•	They can check their list of favorite books, they can remove the books from the list
•	They can check the details of each book, can leave comments on different books, and check the comments of other users of the book

Library Employee:
•	When login, they can see different categories of books sorted according to popularity ranking, they can choose different categories to see the corresponding book list 
•	They can have 2 lists: procurement list and promotion list
•	They can add/remove books to procurement list on the main screen.
•	They can check the books in the procurement list, they can remove them from the list.
•	They can go to action page of different books on the main screen, where they can a list of books similar to the selected book, sorted according to similarity ranking. They can add/remove to/from the promotion list
•	They can go to the promotion list, and check the books in that list

Values from similarity table and popularity table are retrieved from external API (Mocakroo to be specific), simulating the real situation, when we generate those tables from other systems.

There are 5 API endpoints for connection between Rails and Flutter:
•	Authentication (acted as a gateway for other endpoints, will send out a json web token if credentials are correct)
•	Books (GET all book list and get specific book information)
•	Users (GET specific user by id or by email)
•	Comments (Users are able to use GET to view and POST to add comments)
•	Bookmark (Users are able to use GET to view and PUT/DELETE to adjust their lists)
The mobile application’s function is a replication of the web-version of the normal user. Library employees are not supposed to use the mobile version to make the procurement/promotion selections.

User can login to the system using their accounts created on the web-based system, they can do what they can do on the web-based application – check different lists of books,  view books, view/add comment, add/remove books on their bookmarks etc.

They will keep login unless they press logout, even if the application is ended.

When the mobile device lost internet connection, the application will have a busy indication and automatically connect to the server again when the connection is resumed.

