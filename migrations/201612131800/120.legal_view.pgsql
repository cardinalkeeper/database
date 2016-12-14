
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Представление Юридическое лицо

create view legal_view as 

	select 
	
		contractor_view.*,
	
		legal.id as legal_id,
		legal.title as legal_title,
		legal.title_short as legal_title_short,
		
		legal_form.id as legal_form_id,
		legal_form.title as legal_form_title,
		legal_form.title_short as legal_form_title_short
		
	from legal 
	
	left join contractor_view on legal.contractor_id = contractor_view.contractor_id
	left join legal_form on legal.legal_form_id = legal_form.id;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

comment on view legal_view is 'Юридическое лицо';