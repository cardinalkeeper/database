
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Физическое лицо

insert into contractor_type (tablename, title) values ('individual', 'Физическое лицо');

create table individual (

	id serial not null primary key,
	
	contractor_id integer not null references contractor (id) on delete cascade,
	
	first_name varchar(200) null default null,
	surname varchar(200) null default null,
	patronymic varchar(200) null default null
	
);

comment on table individual is 
'Физическое лицо (контрагент).
Номер документа физического лица хранит его ИНН.';

comment on column individual.first_name is 'Имя';
comment on column individual.surname is 'Фамилия';
comment on column individual.patronymic is 'Отчество';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Триггеры

create function individual_before_insert() returns trigger as $$
	begin
		if new.contractor_id is null then
			insert into contractor (type_id) values (contractor_type_get_id('individual'));
			new.contractor_id = currval('contractor_id_seq');
		end if;
		return new;
	end;	
$$ language plpgsql;

comment on function individual_before_insert()
	is 'Перед создание Физического лица в таблице Контрагент обязательно должна быть создана запись.';

create trigger 
	individual_before_insert 
		before insert on individual 
		for each row 
		execute procedure individual_before_insert();
	
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Функции

create function individual_title(individual individual) returns varchar as $$
	select
		trim(both from 
			individual.surname || ' ' || 
			individual.first_name || ' ' || 
			individual.patronymic
		);
$$ language sql;

comment on function individual_title(individual individual)
	is 'Вывод имени физического лица в полном варианте.';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

create function 
	individual_title_short(individual individual) 
	returns varchar as $$
	
	select
	
		trim(both from 
		
			individual.surname || ' ' || 
			
			case 
				when individual.first_name is null then ''
				when trim(both from individual.first_name) = '' then ''
				else ' ' || upper(substring(individual.first_name from 1 for 1)) || '.'
			end || 
			
			case 
				when individual.patronymic is null then ''
				when trim(both from individual.patronymic) = '' then ''
				else ' ' || upper(substring(individual.patronymic from 1 for 1)) || '.'
			end
			
		);
		
$$ language sql;

comment on function individual_title_short(individual individual) 
	is 'Вывод имени физического лица в сокращенном варианте.';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

create function 
	individual_businessman_title(individual individual) 
	returns varchar as $$
	
	select 'Индивидуальный предприниматель «' || individual_title(individual)  || '»';
			
$$ language sql;

comment on function individual_businessman_title(individual individual) 
	is 'Вывод наименования индивидуального предпринимателя в полном варианте.';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

create function 
	individual_businessman_title_short(individual individual) 
	returns varchar as $$
	
	select 'ИП «' || individual_title_short(individual)  || '»';
			
$$ language sql;

comment on function individual_businessman_title_short(individual individual) 
	is 'Вывод наименования индивидуального предпринимателя в сокращенном варианте.';
