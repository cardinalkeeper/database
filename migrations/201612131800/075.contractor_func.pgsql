
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Функции для упрощения представления.

create function contractor_title(
		contractor_type contractor_type, 
		legal legal, 
		individual individual, 
		businessman businessman, 
		legal_form legal_form
	) returns varchar as $$
	
	select case 
		when contractor_type.tablename = 'legal' then legal_title(legal, legal_form)
		when contractor_type.tablename = 'individual' then individual_title(individual)
		when contractor_type.tablename = 'businessman' then individual_businessman_title(individual)
		else null
	end;
		
$$ language sql;

comment on function contractor_title(
	contractor_type contractor_type, 
	legal legal, 
	individual individual, 
	businessman businessman, 
	legal_form legal_form
) is 'Вывод наименования контрагента в полном варианте.';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

create function contractor_title_short(
		contractor_type contractor_type, 
		legal legal, 
		individual individual, 
		businessman businessman, 
		legal_form legal_form
	) returns varchar as $$
	
	select case 
		when contractor_type.tablename = 'legal' then legal_title_short(legal, legal_form)
		when contractor_type.tablename = 'individual' then individual_title_short(individual)
		when contractor_type.tablename = 'businessman' then individual_businessman_title_short(individual)
		else null
	end;
		
$$ language sql;

comment on function contractor_title_short(
	contractor_type contractor_type, 
	legal legal, 
	individual individual, 
	businessman businessman, 
	legal_form legal_form
) is 'Вывод наименования контрагента в сокращенном варианте.';
