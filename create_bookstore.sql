/*
 * BOOKSTORE database schema
 * @author Ryan Crosier, Preksha Rao, Paul Choe, Zijun Zhou
 */
create table BOOK
(
    Title varchar(150) not null,
    Year char(4),
    BasePrice real,
    Stock int,
    Category varchar(30),
    ISBN char(10) not null,
    PubID char(9) not null,
    primary key(ISBN),
    foreign key(PubID) references PUBLISHER(PID)
);

create table AUTHOR
(
    PenFirstName varchar(30) not null,
    PenLastName varchar(30) not null,
    FirstName varchar(30),
    LastName varchar(30),
    Email varchar(30),
    Phone char(10),
    AID char(9) not null,
    primary key(AID)
);

create table WRITES
(
    BISBN char(10) not null,
    AuID char(9) not null,
    primary key(BISBN, AuID),
    foreign key(BISBN) references BOOK(ISBN),
    foreign key(AuID) references AUTHOR(AID)
);

create table CUSTOMER
(
    FirstName varchar(30) not null,
    LastName varchar(30) not null,
    Email varchar(30) not null,
    Phone char(10) not null,
    CID char(9) not null,
    primary key(CID)
);

create table PUBLISHER
(
    Name varchar(30) not null,
    Email varchar(30),
    Phone char(10),
    Address varchar(30),
    PID char(9) not null,
    primary key(PID)
);

create table DISCOUNT
(
    DiscountID char(9) not null,
    BISBN char(9) not null,
    DiscountStart date,
    DiscountEnd date,
    AmountOff int, /* percent off */
    primary key(DiscountID),
    foreign key(BISBN) references BOOK
);

create table REVIEW
(
    ReviewID char(9) not null,
    BISBN char(9) not null,
    CusID char(9) not null,
    Rating int not null,
    Content varchar(100),
    foreign key(BISBN) references BOOK,
    foreign key(CusID) references CUSTOMER
);

create table PURCHASE
(
    BISBN char(9) not null,
    CusID char(9) not null,
    DateOfSale date,
    Quantity int not null,
    primary key(BISBN, CusId),
    foreign key(BISBN) references BOOK,
    foreign key(CusID) references CUSTOMER
);



