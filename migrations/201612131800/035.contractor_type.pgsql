
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Тип контрагента

create table contractor_type (

   id serial not null primary key,
   
   tablename varchar(100) not null unique,
   title varchar(200) not null
   
);

comment on table contractor_type is 'Тип контрагента';
comment on column contractor_type.tablename is 'Название таблицы';
comment on column contractor_type.title is 'Наименование';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Функции

create function 
	contractor_type_get_id(tablename varchar) 
	returns integer as $$
	
	select id from contractor_type as ct where ct.tablename = tablename;

$$ language sql;

comment on function contractor_type_get_id(table_name varchar) is 
'Получить номер типа контрагента по названию таблицы.
Например: get_contractor_type_id(''individual'').';
