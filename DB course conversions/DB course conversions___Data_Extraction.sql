use db_course_conversions;

select * from student_info i;

select * from student_engagement where student_id = 268727;

select * from student_purchases where student_id = 268727;
 

select * from student_info i left join (select * from (select 
	student_id, 
	row_number() over (partition by student_id order by date_purchased) as purchased_list, 
    date_purchased as first_date_purchased
    from student_purchases) as p where p.purchased_list = 1) as d on i.student_id = d.student_id;
    
    
select i.student_id, i.date_registered, d.first_date_purchased,e.first_date_watched  from student_info i left join 
	(select * from (select 
	student_id, 
	row_number() over (partition by student_id order by date_purchased) as purchased_list, 
    date_purchased as first_date_purchased
    from student_purchases) as p where p.purchased_list = 1) as d on i.student_id = d.student_id
    left join
	(select * from (select 
	student_id, 
	row_number() over (partition by student_id order by date_watched) as watched_list, 
    date_watched as first_date_watched
    from student_engagement) as e where e.watched_list = 1) as e on i.student_id = e.student_id;
    
select 
	de.student_id,
    de.date_registered,
    de.first_date_watched,
    de.first_date_purchased,
	datediff(de.first_date_watched,de.date_registered) as date_diff_reg_watch,
    datediff(de.first_date_watched,de.first_date_purchased) as date_diff_watch_purch 
    from (select i.student_id, i.date_registered, d.first_date_purchased,e.first_date_watched  from student_info i left join 
	(select * from (select 
	student_id, 
	row_number() over (partition by student_id order by date_purchased) as purchased_list, 
    date_purchased as first_date_purchased
    from student_purchases) as p where p.purchased_list = 1) as d on i.student_id = d.student_id
    left join
	(select * from (select 
	student_id, 
	row_number() over (partition by student_id order by date_watched) as watched_list, 
    date_watched as first_date_watched
    from student_engagement) as e where e.watched_list = 1) as e on i.student_id = e.student_id) as de where de.first_date_watched is not null;

-- Q4
select avg(deee.date_diff_reg_watch) from (select 
	de.student_id,
    de.date_registered,
    de.first_date_watched,
    de.first_date_purchased,
	datediff(de.first_date_watched,de.date_registered) as date_diff_reg_watch,
    datediff(de.first_date_watched,de.first_date_purchased) as date_diff_watch_purch 
    from (select i.student_id, i.date_registered, d.first_date_purchased,e.first_date_watched  from student_info i left join 
	(select * from (select 
	student_id, 
	row_number() over (partition by student_id order by date_purchased) as purchased_list, 
    date_purchased as first_date_purchased
    from student_purchases) as p where p.purchased_list = 1) as d on i.student_id = d.student_id
    left join
	(select * from (select 
	student_id, 
	row_number() over (partition by student_id order by date_watched) as watched_list, 
    date_watched as first_date_watched
    from student_engagement) as e where e.watched_list = 1) as e on i.student_id = e.student_id) as de where de.first_date_watched is not null) as deee;
    
-- Q5
select avg(deee.date_diff_watch_purch) from (select 
	de.student_id,
    de.date_registered,
    de.first_date_watched,
    de.first_date_purchased,
	datediff(de.first_date_watched,de.date_registered) as date_diff_reg_watch,
    datediff(de.first_date_watched,de.first_date_purchased) as date_diff_watch_purch 
    from (select i.student_id, i.date_registered, d.first_date_purchased,e.first_date_watched  from student_info i left join 
	(select * from (select 
	student_id, 
	row_number() over (partition by student_id order by date_purchased) as purchased_list, 
    date_purchased as first_date_purchased
    from student_purchases) as p where p.purchased_list = 1) as d on i.student_id = d.student_id
    left join
	(select * from (select 
	student_id, 
	row_number() over (partition by student_id order by date_watched) as watched_list, 
    date_watched as first_date_watched
    from student_engagement) as e where e.watched_list = 1) as e on i.student_id = e.student_id) as de where de.first_date_purchased is not null) as deee;
    
    
select * from ( select 
	de.student_id,
    de.date_registered,
    de.first_date_watched,
    de.first_date_purchased,
	datediff(de.first_date_watched,de.date_registered) as date_diff_reg_watch,
    datediff(de.first_date_watched,de.first_date_purchased) as date_diff_watch_purch 
    from (select i.student_id, i.date_registered, d.first_date_purchased,e.first_date_watched  from student_info i left join 
	(select * from (select 
	student_id, 
	row_number() over (partition by student_id order by date_purchased) as purchased_list, 
    date_purchased as first_date_purchased
    from student_purchases) as p where p.purchased_list = 1) as d on i.student_id = d.student_id
    left join
	(select * from (select 
	student_id, 
	row_number() over (partition by student_id order by date_watched) as watched_list, 
    date_watched as first_date_watched
    from student_engagement) as e where e.watched_list = 1) as e on i.student_id = e.student_id) as de where de.first_date_watched is not null) as dee where dee.date_diff_watch_purch <= 0;
