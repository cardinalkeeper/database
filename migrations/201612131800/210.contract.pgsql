
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Договор

insert into document_type (tablename, title) values ('contract', 'Договор');

create table contract (

	id serial not null primary key,
	
	document_id integer not null references document (id) on delete cascade,
	
	provider_id integer null default null references contractor (id) on delete set default,
	consumer_id integer null default null references contractor (id) on delete set default,
	
	payment money null default null
	
);

comment on table contract is 
'Договор. Связывает двух контрагентов договорными обязательствами.
Номер документа хранит номер договора.';

comment on column contract.provider_id  is 'Номер контрагента исполнителя (поставщика услуг или товаров)';
comment on column contract.consumer_id is 'Номер контрагента заказчика (потребителя услуг или товаров)';
comment on column contract.payment is 'Сумма договора.';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Триггеры 

create function 
	contract_before_insert() 
	returns trigger as $$
	
	begin
		if new.document_id is null then
			insert into document (type_id) values (document_type_get_id('contract'));
			new.document_id = currval('document_id_seq');
		end if;
		return new;
	end;
	
$$ language plpgsql;

comment on function contract_before_insert()
	is 'Перед создание Договора в таблице Документ обязательно должна быть создана запись.';

create trigger 
	contract_before_insert 
		before insert on contract 
		for each row 
		execute procedure contract_before_insert();
	
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Функции

create function 
	contract_title(document document, contract contract) 
	returns varchar as $$
	
	select 'Договор № ' || document.number || ' от ' || document.date_start;
		
$$ language sql;

comment on function contract_title(document document, contract contract) 
	is 'Вывод наименования договора.';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

create function 
	contract_title_short(document document, contract contract) 
	returns varchar as $$
	
	select contract_title(document, contract);
		
$$ language sql;

comment on function contract_title_short(document document, contract contract) 
	is 'Вывод сокращенного наименования договора.';
