create table TODO (
    ID int not null,
    NAME varchar(100) not null,
    DUE timestamp null,
    COMPLETED int(1) default 0
);
