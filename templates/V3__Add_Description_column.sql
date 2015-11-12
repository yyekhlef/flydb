alter table TODO
add column description VARCHAR(255) default '';

update TODO
set description = 'A description'
where ID = 2;
