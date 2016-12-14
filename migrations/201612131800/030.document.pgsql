
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Документ

create table document (

	id serial not null primary key,
	
	parent_id integer null default null references document (id) on delete set default,
	type_id integer not null references document_type (id),
	deleted boolean not null default false,
	
	subject text null default null,
	number varchar(200) null default null,
	notes text null default null,
	
	date_start date null default null,
	date_end date null default null
);

comment on table document 
	is 'Документ';

comment on column document.parent_id 
	is 'Документ основание (родительский документ).';

comment on column document.deleted 
	is 'Флажок: удален ли документ. Равен true, если удален.';

comment on column document.type_id 
	is 'Тип документа (название таблицы).';

comment on column document.subject 
	is 'Предмет или тема документа.';

comment on column document.number 
	is 'Номер документа (строка произвольного содержания).';

comment on column document.date_start 
	is 'Дата начала действия документа.';
	
comment on column document.date_end 
	is 'Дата конца действия документа. Null это документ без срока окончания действия.';

comment on column document.notes 
	is 'Заметки к документу произвольного содержания.';
