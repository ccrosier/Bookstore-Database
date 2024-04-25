/* enforce foreign keys */
PRAGMA foreign_keys = ON;

PRAGMA foreign_keys = OFF;
.import ./data/book.csv BOOK 
.import ./data/author.csv AUTHOR
.import ./data/customer.csv CUSTOMER
.import ./data/publisher.csv PUBLISHER
.import ./data/discount.csv DISCOUNT
.import ./data/review.csv REVIEW
.import ./data/purchase.csv PURCHASE
.import ./data/writes.csv WRITES

PRAGMA foreign_keys = ON;

create view Top10 as select * from (
    select Title, PenFirstName, PenLastName, avg(Rating), sum(p.Quantity) 
    as quant from Book b, Review r, Purchase p, Author a, Writes w 
    where p.BISBN=ISBN and r.BISBN=b.ISBN and b.ISBN=w.BISBN and w.AuID=a.AID 
    group by b.ISBN) 
    order by quant desc limit 10;
    
create view Top5Genre as select Category, quant as QuantitySold from (
    select Category, sum(p.quantity) 
    as quant from Book b, Purchase p 
    where b.ISBN=p.BISBN 
    group by b.Category) 
    order by quant desc limit 5;

/*
* First index: find books categorized by Author and Title. Reasoning: end users will often rarely use raw SQL and do not see the indices, but may be searching for something within the schema that's very common and gives key information.
* It makes sense to think of books in terms of the author and the title, hence making an index for AID and Title would be a good candidate index.
*/

CREATE INDEX title
ON BOOK (Title);

/*
* Second index: find the phone number of a publisher the user wishes to contact, categorized by PID, E-mail and phone number. Reasoning: this index has been chosen in the case that the user wishes to make contact with the publisher (perhaps uses the phone number
* to make immediate contact, then use the e-mail address as a follow-up). Including the address didn't seem immedaitely pertinent, since most users would not be writing on paper directly to communicate with the publisher.
*/

CREATE INDEX pub_contact_information
ON PUBLISHER (PID, Email, Phone);

/*
* Third index: find review scores for books by BISBN, Rating (from highest to lowest) and Content. Reasoning: if a user wishes to simply filter results for reviews of "good" books, they can try to find the highest rated books and read the corresponding for them.
* This makes it easy for the user to find which books are popular and may be worth reading.
*/

CREATE INDEX book_reviews
ON REVIEW (BISBN, Rating DESC, Content);
