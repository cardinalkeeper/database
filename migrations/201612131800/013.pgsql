
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Описание миграции

insert into migration_history (version, title) 
	values ('201612131800', 'Начало проекта');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создана таблица История миграций');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создана таблица Операции миграций');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создано представление История миграций');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создана таблица Организационно-правовая форма');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создана таблица Тип документа');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создана таблица Документ');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создана таблица Тип контрагента');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создана таблица Контрагент');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создана таблица Физическое лицо');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создана таблица Индивидуальный предприниматель');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создана таблица Юридическое лицо');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создано представление Контрагент');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создано представление Физическое лицо');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создано представление Индивидуальный предприниматель');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создано представление Юридическое лицо');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создана таблица Договор');

insert into migration_history_detail (migration_history_id, text) 
	values (get_migration_history_id('201612131800'), 'Создана таблица Платежные поручения');