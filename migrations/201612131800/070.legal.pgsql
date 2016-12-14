
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Юридическое лицо

insert into contractor_type (tablename, title) values ('legal', 'Юридическое лицо');

create table legal (
	
	id serial not null primary key,
	
	contractor_id integer not null references contractor (id) on delete cascade,
	
	title varchar(200) null default null,
	title_short varchar(200) null default null,
	legal_form_id integer null default null references legal_form (id) on delete set default 

);

comment on table legal is
'Юридическое лицо (контрагент).
Номер документа юридического лица хранит его ОГРН.';

comment on column legal.title 
	is 'Наименование';

comment on column legal.legal_form_id 
	is 'Номер формы собственности';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Триггеры

create function 
	legal_before_insert() 
	returns trigger as $$
	
	begin
		if new.contractor_id is null then
			insert into contractor (type_id) values (contractor_type_get_id('legal'));
			new.contractor_id = currval('contractor_id_seq');
		end if;
		return new;
	end;
	
$$ language plpgsql;

comment on function legal_before_insert()
	is 'Перед создание Юридического лица в таблице Контрагент обязательно должна быть создана запись.';

create trigger 
	legal_before_insert 
		before insert on legal 
		for each row 
		execute procedure legal_before_insert();
	
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Функции

create function 
	legal_title(legal legal, legal_form legal_form) 
	returns varchar as $$
	
	select legal_form.title || ' ' || '«' || legal.title || '»';
		
$$ language sql;

comment on function legal_title(legal legal, legal_form legal_form) 
	is 'Вывод наименования юридического лица с организационно-правовой формой в полном варианте.';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

create function 
	legal_title_short(legal legal, legal_form legal_form) 
	returns varchar as $$
	
	select legal_form.title_short || ' ' || '«' || legal.title_short || '»';
		
$$ language sql;

comment on function legal_title_short(legal legal, legal_form legal_form) 
	is 'Вывод наименования юридического лица с организационно-правовой формой в сокращенном варианте.';

