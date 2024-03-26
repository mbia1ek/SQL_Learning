use sql_and_tableau;
     
select 
	*,
    case
		when
			base_table.days_for_completion = 0
            then 'Same day'
		when
			base_table.days_for_completion <= 7
            then '1 to 7 days'
		when
			base_table.days_for_completion <= 30
            then '8 to 30 days'
		when
			base_table.days_for_completion <= 60
            then '31 to 60 days'
		when
			base_table.days_for_completion <= 90
            then '61 to 90 days'
		when
			base_table.days_for_completion <= 365
            then '91 to 365 days'
		when
			base_table.days_for_completion >= 366
            then '366+ days'
		else
			'0'
	end as completion_bucket
 from
(select 
	row_number() over (partition by s.student_id) as student_track_id, 
    s.student_id,
    t.track_name, 
    s.date_enrolled,
    s.date_completed as track_completed,
    datediff(s.date_completed,s.date_enrolled) as days_for_completion
    from career_track_student_enrollments s
	join
    career_track_info t on s.track_id = t.track_id
     where date_completed is not null) as base_table;
     
select 
	*,
    case
		when
			base_table.days_for_completion = 0
            then 'Same day'
		when
			base_table.days_for_completion <= 7
            then '1 to 7 days'
		when
			base_table.days_for_completion <= 30
            then '8 to 30 days'
		when
			base_table.days_for_completion <= 60
            then '31 to 60 days'
		when
			base_table.days_for_completion <= 90
            then '61 to 90 days'
		when
			base_table.days_for_completion <= 365
            then '91 to 365 days'
		when
			base_table.days_for_completion >= 366
            then '366+ days'
		else
			'0'
	end as completion_bucket
 from
(select 
	row_number() over (partition by s.student_id) as student_track_id, 
    s.student_id,
    t.track_name, 
    s.date_enrolled,
    s.date_completed as track_completed,
    datediff(s.date_completed,s.date_enrolled) as days_for_completion
    from career_track_student_enrollments s
	join
    career_track_info t on s.track_id = t.track_id) as base_table;
     
     
