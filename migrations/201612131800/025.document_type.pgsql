
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Тип документа

create table document_type (

   id serial not null primary key,
   
   tablename varchar(100) not null unique,
   title varchar(200) not null
   
);

comment on table document_type 
	is 'Тип документа';

comment on column document_type.tablename 
	is 'Название таблицы';

comment on column document_type.title 
	is 'Название типа';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Функции

create function 
	document_type_get_id(tablename varchar) 
	returns integer as $$
	
	select id from document_type as dt where dt.tablename = tablename;

$$ language sql;

comment on function document_type_get_id(table_name varchar) is 
'Получить номер типа документа по названию таблицы.
Например: get_document_type_id(''contractor'').';