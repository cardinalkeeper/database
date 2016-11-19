
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- История миграций

create table migration_history (

	id serial not null,
	
	applied timestamp not null default current_timestamp,
	version varchar(12) not null,
	title varchar(100) not null,
	notes text null default null,
	
	constraint migration_history_primary_key primary key (id)
);

comment on table migration_history 
	is 'История версионной миграции базы данных.';

comment on column migration_history.applied 
	is 'Дата инсталяции миграции.';

comment on column migration_history.version 
	is 'Версия миграции в формате YYYYMMDDHHMM.';

comment on column migration_history.title 
	is 'Заголовок. Краткое описание изменения.';

comment on column migration_history.notes 
	is 'Полное описание изменений.';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Номер текущей миграции

insert into migration_history (version, title, notes) 
	values ('201611192200', 'Начало создания базы данных.', '');