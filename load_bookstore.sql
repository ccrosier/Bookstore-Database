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
