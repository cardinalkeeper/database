
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Платежное поручение

insert into document_type (tablename, title) values ('payment_order', 'Платежное поручение');

create table payment_order (

	id serial not null primary key,
	
	document_id integer not null references document (id) on delete cascade,
	
	sender_id integer null default null references contractor (id) on delete set default,
	recipient_id integer null default null references contractor (id) on delete set default,
	
	payment money not null default 0 

);

comment on table payment_order 
	is 'Платежное поручение';

comment on column payment_order.sender_id 
	is 'Номер контрагента плательщика';

comment on column payment_order.recipient_id 
	is 'Номер контрагента получателя';

comment on column payment_order.payment 
	is 'Сумма';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Триггеры 

create function 
	payment_order_before_insert() 
	returns trigger as $$

	begin
		if new.document_id is null then
			insert into document default values;
			new.document_id = currval('document_document_id_seq');
		end if;
		return new;
	end;
	
$$ language plpgsql;

create trigger 
	payment_order_before_insert 
		before insert on payment_order 
		for each row 
		execute procedure payment_order_before_insert();
	
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Функции

create function 
	payment_order_title(document document, payment_order payment_order) 
	returns varchar as $$
	
	select 'Платежное поручение № ' || document.number || ' от ' || document.date_start;
		
$$ language sql;

comment on function payment_order_title(document document, payment_order payment_order) 
	is 'Вывод наименования платежного поручения.';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

create function 
	payment_order_title_short(document document, payment_order payment_order) 
	returns varchar as $$
	
	select payment_order_title(document, payment_order);
		
$$ language sql;

comment on function payment_order_title_short(document document, payment_order payment_order) 
	is 'Вывод сокращенного наименования платежного поручения.';
