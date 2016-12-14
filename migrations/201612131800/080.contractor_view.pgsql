
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Представление Контрагент

create view contractor_view as 

	select 
	
		document.id as document_id,
		document.parent_id as document_parent_id,
		document.deleted as document_deleted,
		document.subject as document_subject,
		document.number as document_number,
		document.notes as document_notes,
		document.date_start as document_date_start,
		document.date_end as document_date_end,
		
		contractor_type.title as contractor_type,
		contractor_type.tablename as contractor_type_tablename,
	
		contractor.id as contractor_id,
		contractor_title(contractor_type, legal, individual, businessman, legal_form) as contractor_title,
		contractor_title_short(contractor_type, legal, individual, businessman, legal_form) as contractor_title_short
		
	from contractor
	
	left join contractor_type on contractor.type_id = contractor_type.id
	left join document on contractor.document_id = document.id
	left join businessman on businessman.contractor_id = contractor.id
	left join legal on legal.contractor_id = contractor.id
	left join legal_form on legal.legal_form_id = legal_form.id
	
	-- Подсоединяем individual в таком виде, чтобы у него появилась колонка document_id
	left join (
		select 
			individual.id as individual_id, 
			individual.contractor_id, 
			document.id as document_id
		from individual
		left join contractor on contractor.id = individual.contractor_id
		left join document on document.id = contractor.document_id
	) as individual_document on 
		-- Подсоединяем для физических лиц
		individual_document.contractor_id = contractor.id
		-- А также для индивидуальных предпринимателей
		or businessman.contractor_id = contractor.id and individual_document.document_id = document.parent_id
	
	-- Повторно подсоединяем individual, потому что
	-- в функции contractor_* можно вводить записи типа individual, 
	left join individual on individual.id = individual_document.individual_id;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

comment on view contractor_view is 'Контрагенты';