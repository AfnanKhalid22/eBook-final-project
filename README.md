# final-project-eBook
eBook App 


# Project Description :
“eBook App” is a Swift application, is a collection of Arabic and English book libraries, contains many  books for adults and children, designed to help users read books anywhere and any time easily.

### Features List:

- User can read books in his preferred language.
- User can share his favorite Book with his frinds.
- User can choose his books favorite list.
- User can Change the App Language (Arabic & English).
- User can choose read or listen the book.
- User can share the App with friends.
- User can reset password.
- The application serve adults and children.

# Structure:

screens:
- HomeVC
- ArabicBookVC
- EnglishBookVC
- FavoriteVC
- profileVC
- pdfBookVC
- audioBookVC
Models:
- User
- BookData
Cells:
- ArabicCell
- EnglishCell
- Favourite Cell
- BookInformationCell
- ReadBook Cells


# User Stories:
- As a User  I want  to Login/Register, So that I can creat account in the app .

- As a User  I want  to SignOut, So that I can logout and login with another account.

- As a User  I want  to Edit my profile, So that I can update my name and profile image.

- As a User  I want  to Choose book Language, So that I can read it  with my language.

- As a User  I want  to change to dark mode, So that I can use app with mode as i want.

- As a User I want to See my favourite List , So that I can find my favourite book quickly and easily.

- As a User  I want  to Add/Remove books from favourite list, So that I can  control  my favourite list .

- As a User I want to Share the book , So that I can share it with my friends.

- As a User I want to Chanage App Langauge , So that I can use it with my understandable langauge.

- As a User I want to read adult/children Books , So that I can read books that are suitable for my age.

- As a User I want to add bookMark to book , So that I can complete read the book easily.

- As a User I want to listen audio book , So that I can choose read or listen the book.

# Backlog:
 
User :
- can signup/login
- see your profile
- see English & Arabic Book List
- see favourite book list
- can read Book
- can listen audio book
- can signOut


# React Router Routes (React App)

|      Component      |   Permission   |                                           Behavior                                                                       |
|---------------------|----------------|--------------------------------------------------------------------------------------------------------------------------|
|     lunchScreen     |     public     |                                        Show Logo                                                                         |  
|     welcome page    |     public     | welcome page, link to Register page, navigate to Registration page after tap on create account button.                                                                        |
|     welcome page    |     public     | welcome page, link to login page, navigate to login page after tap on login now button.                                                                        |                                                                                                          
|    RegisterPage     |     public     | Rigester page, link to login, navigate to homepage after Rigester.                                                       |                                                   
|     LoginPage       |     public     | Login page, link to login,  navigate to home page after login.                                                           |
|    firstHomePage    |   user only    | Home page, link to Arabic Books List, navigate to Arabic Books List after pressed on Arabic button.                      |
|    firstHomePage    |   user only    | Home page, link to English Books List, navigate to English Books List after pressed on English button.                   |
|    listBookPage     |   user only    | list Book page, link to Book information, navigate to Book information after pressed on specific Book.                   |
| informationBookPage |   user only    | information Book page, link to read Book, navigate to Book PDF page after pressed on Book icon Button.                   |
| informationBookPage |   user only    | information Book page, link to listen Book, navigate to audio page after pressed on headphone Button.|     
|    listBookPage     |   user only    | list Book Page, link to add book to favourite page, after pressed on heart Button.                                       |                
|  favouriteBookPage  |   user only    | favourite Book Page, link to raed   favourite book, after pressed  on specific Book.                                     |
|    childrenPage     |   user only    | children page, link to Arabic Books List, navigate to Arabic Books List after pressed on Arabic button.                |
|    childrenPage     |   user only    | children page, link to English Books List, navigate to English Books List after  pressed on English button.               |
|    profilePage      |   user only    | profile page, link to edit profile image, navigate to iphone library after tap on profile image.                         |
|    profilePage      |   user only    | profile page, link to edit User name, navigate to edite user name after tap on name field.                               |  
|    profilePage      |   user only    | profile page, link to children page , navigate to children page after tap on kids mode button.                         |
|    profilePage      |   user only    | profile page, link to change app mode , change to dark mode after tap on dark mode button.                        |  
|    profilePage      |   user only    | profile page, link to change language, navigate to iphone setting after tap on change Language button.                   |
|    profilePage      |   user only    | profile page, link to share Application, navigate todefault share popup of the iOS after pressed on Share App button.     |          
|    profilePage      |   user only    | profile page, link to signOut, navigate to login page after pressed on SignOut button.                                   |                               


# Components:

 - Rigester $ LogIn Page 
 - Home Page (contains collection of pages)
 - Cildren Page (contains collection of pages)
 - Favourite Page
 - Profile Page
 
 # Services
_ Auth Service: 
  - auth.rigester(user)
  - auth.login(user)
  - auth.logout(user)
_ Favourite Services.
  -user.add
  -user.delete

# repository Link:
 [click here](https://github.com/AfnanKhalid22/final-project-eBook)


