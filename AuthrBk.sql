CREATE TABLE Authors (
  AuthorID INT AUTO_INCREMENT PRIMARY KEY,
  FullName VARCHAR(255),
  BirthCountry VARCHAR(255)
);

#add authors to the tables
INSERT INTO Authors (FullName, BirthCountry)
VALUES
  ('Jane Austen', 'England'),
  ('Charles Dickens', 'England'),
  ('Mark Twain', 'United States');

SELECT * FROM Authors;

#Create books table
CREATE TABLE Books (
  BookID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(255),
  AuthorID INT,
  FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);


#Add books to the books  table
INSERT INTO Books (Name, AuthorID)
VALUES
  ('Pride and Prejudice', 1),
  ('Sense and Sensibility', 1),
  ('The Pickwick Papers', 2);
  
 #query to see all books in the database 
 SELECT * FROM Books;
 
 #Join Authors and Books table
 SELECT Authors.FullName AS AuthorName, Books.Name AS BookName
FROM Authors
JOIN Books ON Authors.AuthorID = Books.AuthorID;

 #create authors book view
 CREATE VIEW AuthorBooks AS
SELECT Authors.FullName AS AuthorName, Books.Name AS BookName
FROM Authors
JOIN Books ON Authors.AuthorID = Books.AuthorID
ORDER BY Authors.FullName;

 #Query authors book view
 SELECT * FROM AuthorBooks;


