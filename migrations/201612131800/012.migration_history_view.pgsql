
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Представление История миграций

create view migration_history_view as 
	
	select 
		mh.applied,
		mh.version,
		mh.title,
		mh.notes,
		mhd.text
		
		from migration_history_detail as mhd
		left join migration_history as mh on mhd.migration_history_id = mh.id;


comment on view migration_history_view is 'История миграций';