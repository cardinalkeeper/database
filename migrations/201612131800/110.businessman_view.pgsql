
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Представление Индивидуальный предприниматель

create view businessman_view as 

	select 
	
		contractor_view.*,
		
		businessman.id as businessman_id
		
	from businessman 
	
	left join contractor_view on businessman.contractor_id = contractor_view.contractor_id;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

comment on view businessman_view is 'Индивидуальный предприниматель';