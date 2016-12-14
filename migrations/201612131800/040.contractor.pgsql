
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Контрагент

insert into document_type (tablename, title) values ('contractor', 'Контрагент');

create table contractor (

	id serial not null primary key,
	
	document_id integer not null references document (id) on delete cascade,
	type_id integer not null references contractor_type (id)
	
);

comment on table contractor is 
'Контрагент. Определены три типа контрагентов: физлицо, юрлицо, ИП.
Номер документа хранит ИНН физлица, ОГРН или ОГРНИП.';

comment on column contractor.type_id 
	is 'Тип контрагента (название таблицы).';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Триггеры 

create function 
	contractor_before_insert() 
	returns trigger as $$
	
	begin
		if new.document_id is null then
			insert into document (type_id) values (document_type_get_id('contractor'));
			new.document_id = currval('document_id_seq');
		end if;
		return new;
	end;

$$ language plpgsql;

comment on function contractor_before_insert()
	is 'Перед создание контрагента в таблице Документ обязательно должна быть создана запись.';

create trigger contractor_before_insert 
	before insert 
	on contractor 
	for each row 
	execute procedure contractor_before_insert();



