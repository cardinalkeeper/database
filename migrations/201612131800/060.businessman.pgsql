
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Индивидуальный предприниматель

insert into contractor_type (tablename, title) values ('businessman', 'Индивидуальный предприниматель');

create table businessman (

	id serial not null primary key,
	
	contractor_id integer not null references contractor (id) on delete cascade
	
);

comment on table businessman is 
'Индивидуальный предприниматель (контрагент).
Номер документа индивидуального предпринимателя хранит его ОГРНИП.
Документ основание всегда определен и является документ Физическое лицо, на которое ИП зарегистрирован.
Документ основание заполняется и контролируется программным способом.';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Триггеры

create function businessman_before_insert() returns trigger as $$
	begin
		if new.contractor_id is null then
			insert into contractor (type_id) values (contractor_type_get_id('businessman'));
			new.contractor_id = currval('contractor_id_seq');
		end if;
		return new;
	end;
$$ language plpgsql;

comment on function businessman_before_insert()
	is 'Перед создание Индивидуального предпринимателя в таблице Контрагент обязательно должна быть создана запись.';

create trigger businessman_before_insert 
	before insert
	on businessman 
	for each row 
	execute procedure businessman_before_insert();
