-- Query 1

SELECT Books.title, Books.publication_year
FROM Books
WHERE Books.publication_year > 2000
ORDER BY Books.publication_year DESC;

-- Query 2

SELECT *
FROM Books
WHERE Books.genre_id = 1 AND Books.copies_owned > 5;

-- Query 3

Select *
FROM Books
WHERE Books.title LIKE '%History%';

-- Query 4

-- Mathematical Logic:
-- if >= and <= is used on date objects, you can compare the dates. The due_dates are in Febuary (XXXX-02-XX),
-- but this doesn't mean the logic is flawed, as the query only compares the checkout dates

SELECT
    Loans.loan_id,
    Loans.checkout_date,
    Loans.due_date,
    Patrons.first_name || ' ' || Patrons.last_name AS "Patron Full Name",
    Patrons.email
FROM Loans
INNER JOIN Patrons ON Loans.patron_id = Patrons.patron_id
WHERE Loans.checkout_date >= '2023-01-01' 
  AND Loans.checkout_date <= '2023-01-31';
  
-- Query 5

SELECT
    Books.title,
    Authors.first_name || ' ' || Authors.last_name AS "Author Full Name",
    Genres.genre_name,
    Loans.checkout_date,
    Loans.due_date
FROM Books
INNER JOIN Authors ON Authors.author_id = Books.author_id
INNER JOIN Genres ON Genres.genre_id = Books.genre_id
INNER JOIN Loans ON Loans.book_id = Books.book_id;

-- Query 6: Self JOIN: Find pairs of patrons who live in the same city.
-- Show both patrons' names and their city.

-- Logic: created subtables to aggregate with eachother as well as
-- concatenation with || to get the full names in columns

SELECT 
    p1.first_name || ' ' || p1.last_name AS "Patron 1 Name",
    p2.first_name || ' ' || p2.last_name AS "Patron 2 Name",
    p1.city
FROM Patrons p1
INNER JOIN Patrons p2 ON p1.city = p2.city
WHERE p1.patron_id < p2.patron_id
ORDER BY p1.city;

-- Query 7: Used the logic from quesiton 10 to figure out if the books are borrowed and haven't been returned yet
-- as they aren't borrowed if they're at the library

SELECT
    books.book_id,
    books.title,
    patrons.first_name || ' ' || patrons.last_name AS "Patron Full Name",
    loans.return_date,
    branches.branch_name
FROM loans
INNER JOIN books ON loans.book_id = books.book_id
INNER JOIN patrons ON loans.patron_id = patrons.patron_id
INNER JOIN branches ON patrons.branch_id = branches.branch_id
WHERE books.genre_id = 1 
  AND Loans.return_date = "";
  
-- Query 8: COUNT aggregation: Count the number of books in each genre category.

SELECT Genres.genre_name, Books.genre_id, COUNT(Books.book_id) AS "Number of Books"
FROM Books
INNER JOIN Genres ON Genres.genre_id = Books.genre_id
GROUP BY Genres.genre_name
ORDER BY COUNT(Books.book_id) DESC;

-- Query 9: Multiple aggregations: Calculate the average, minimum, and maximum loan duration
-- (days between checkout and return) for each library branch. Include only returned books.

-- Logic: at first, forgot that julianday is a SQL function that helps tremendously for this, otherwise, using
-- SQL AVG, MIN, Max with inner joins on Patrons and Branches. Filtering by Return Date to help with the last
-- portion of the question

SELECT
    branches.branch_name,
    ROUND(AVG(julianday(loans.return_date) - julianday(loans.checkout_date)), 1) AS average_duration_days,
    MIN(julianday(loans.return_date) - julianday(loans.checkout_date)) AS minimum_duration_days,
    MAX(julianday(loans.return_date) - julianday(loans.checkout_date)) AS maximum_duration_days
FROM loans
INNER JOIN patrons ON loans.patron_id = patrons.patron_id
INNER JOIN branches ON patrons.branch_id = branches.branch_id
WHERE loans.return_date IS NOT NULL
GROUP BY branches.branch_name;

-- Query 10: Conditional aggregation: Find patrons with overdue books
-- (due_date < CURRENT_DATE and return_date = ' '), along with the count of overdue books they have

-- Logic get the patrons count and apply the logic. I had to change the logic provided in the question
-- to "" insteaad of ' '. I also concatenated by || for items.

SELECT
    Patrons.patron_id,
    Patrons.first_name || ' ' || Patrons.last_name AS "Patron Full Name",
    COUNT(Loans.patron_id) AS "Overdue Books Count"
FROM Loans
INNER JOIN Patrons ON Loans.patron_id = Patrons.patron_id
WHERE Loans.due_date < CURRENT_DATE 
  AND Loans.return_date = ""
GROUP BY Patrons.patron_id, "Patron Full Name"
ORDER BY "Overdue Books Count" DESC;

-- Query 11:
-- Logic: strftime is used to extract the year and month from the checkout_date column for column using

SELECT 
    strftime('%Y', checkout_date) AS "Year",
    strftime('%m', checkout_date) AS "Month",
    COUNT(loan_id) AS "Number of Loans",
    COUNT(DISTINCT patron_id) AS "Unique Patrons"
FROM Loans
GROUP BY "Year", "Month"
ORDER BY "Year" DESC, "Month" DESC;

/* Query Questions at the end

In our library database, we track which branch a book was borrowed from, but books can exist at multiple branches. How would you modify the schema to track the actual inventory at each branch?

Answer 1: I would create an inventory table that has links to the "branches" table with "branches_id" as a foreign key.
Otherwise, I will leave as is. I would also have an integer value for the total amount of copies at each branch.
book_id would also be a foreign key to the books table in this instance for aggregations and query purposes

Based on the provided data model, what business questions could library administrators answer using SQL queries that we haven't covered in our exercise?

Answer 2: Some questions that could be answered is to run queries to figure out if there's any patrons that
haven't checked out anything in the last "X" months. Another question that can also be answered
is to find out what day of week has the most checkout_date values. You can use this to deeal with
staffing issues should there be any. Another question that can be answered is to figure out which genres of books 
are the most checked out. This can be used to figure out what types of books the library needs to acquire more of.
The last question that can be figured out is what books have been checked out the least in "X" amount of time. This
will answer any questions relating to pushing emails out to those particular patrons.

How would you extend this schema to track additional patron interactions, such as reserved books, late fees, or participation in library programs?

Answer 3: I would create an additional table that would hold "patron_id" and "book_id" as foreign key values. This table would also have a
string variable for "Reservation Status" and a Float value for "late fees". I also would have another foreign key for library programs.
This would be linked to another table dedicated to library programs, which would have "program_id" as a primary key. Likewise, this would
be the foreign key in the first aforementioned table.

For tasks 1-3, how could you combine them into a single, more complex query that finds recent history books with multiple copies?

Answer 4: In order to get a complex query that finds recent history books with multiple copies, I would utilize the books and genres table to
start the query simply to figure out the list of history books with multiple copies. I would then ask what the business excecutive means by
"recent" as if it's the publication date, I just filter by a specific "XXXX" publication year and order by newest first. I would also
ask what the executive means by "multiple" as well, as this defines what my "Having" clause will be. If it's recent by
reservation or inventory updates, then I would link to the aforementioned two tables by way of book_id and patron_id.

What performance considerations should be kept in mind when running complex joins and aggregations on large library datasets?

Answer 5: Being able to cache particular joins and aggregations is necessary for performance considerations. Further, getting only specific
columns would also help with performance. The last thing that's necessary for performance considerations is making sure syntax is kept intact
for the complex joins, so the database doesn't accidentally cross join when it should only be inner joining.
*/