
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- История миграций

create table migration_history (

	id serial not null primary key,
	
	applied timestamp not null default current_timestamp,
	
	version varchar(12) not null unique,
	title varchar(100) not null,
	notes text null default null
	
);

comment on table migration_history 
	is 'История версионной миграции базы данных.';

comment on column migration_history.applied 
	is 'Дата инсталяции миграции. Заполняется автоматически.';

comment on column migration_history.version 
	is 'Версия миграции в формате YYYYMMDDHHMM.';

comment on column migration_history.title 
	is 'Заголовок. Краткое описание изменения.';

comment on column migration_history.notes 
	is 'Полное описание изменений.';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Функции

create function 
	get_migration_history_id(version varchar) 
	returns integer as $$
	
	select id from migration_history as mh where mh.version = version

$$ language sql;

comment on function get_migration_history_id(version varchar) is 
'Получить номер миграции по ее версии.
Например: get_migration_history_id(''201611192200'').';
