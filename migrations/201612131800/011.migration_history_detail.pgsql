
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Операции миграций

create table migration_history_detail (

	id serial not null primary key,
	
	migration_history_id integer not null references migration_history (id) on delete cascade on update cascade,
	
	text varchar(100) not null
	
);

comment on table migration_history_detail 
	is 'Операции миграций.';

comment on column migration_history_detail.migration_history_id 
	is 'Ссылка на миграцию. Внешний ключ.';

comment on column migration_history_detail.text 
	is 'Описание операции.';