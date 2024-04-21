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
