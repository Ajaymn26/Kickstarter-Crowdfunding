-- Total number of projects based on outcome
select state, count(ProjectID) from projects
group by state;

-- TOTAL NUMBER OF PROJECTS BASED ON LOCATION
SELECT l.country, COUNT(p.projectid) AS total_projects
FROM projects p
INNER JOIN location l ON p.location_id = l.id
GROUP BY l.country
ORDER BY total_projects DESC;


-- TOTAL NUMBER OF PROJECTS BASED ON category
SELECT c.name, COUNT(p.projectid) AS total_projects
FROM crowdfunding_category c
left JOIN projects p ON c.id = p.category_id
GROUP BY c.name
ORDER BY total_projects DESC;



-- TOTAL NUMBER OF PROJECTS CREATED BY YEAR, QUARTER AND MONTH
SELECT 
    YEAR(created_date) AS years,
    QUARTER(created_date) AS quarters,
    MONTHNAME(created_date) AS months,
    COUNT(ProjectID) AS total_projects
FROM 
    projects
GROUP BY 
    YEAR(created_date),
    QUARTER(created_date),
    MONTH(created_date),
    MONTHNAME(created_date)
ORDER BY 
    YEAR(created_date),
    QUARTER(created_date),
    MONTH(created_date) DESC;


-- Amount raised by successful projects
select sum(usd_pledged) as Amount_raised
from projects
where state='successful';


-- Number of backers for successful projects
select
sum(backers_count) as No_of_Backers
from projects
where state = 'successful';


-- Avg number of days for successful projects
select 
avg(duration_days) as Average_days
from(
	select
    datediff(successful_date,launched_date) as duration_days
    from projects
    where state= 'successful') as successful_projects;
    
    
-- TOP SUCCESSFUL PROJECTS BASED ON NO. OF BACKERS
select name,
sum(backers_count) as no_of_backers
from projects
where state='successful'
group by name
order by no_of_backers desc
limit 5;


-- TOP SUCCESSFUL PROJECTS BASED ON AMOUNT RAISED
select name,
sum(usd_pledged) as Amount_raised
from projects
where state='successful'
group by name
order by Amount_raised desc
limit 5;

-- Percentage of Successful Projects  Overall
SELECT 
    (COUNT(CASE WHEN state = 'successful' THEN 1 END) / COUNT(*)) * 100 AS success_percentage
FROM 
    projects;
    
    
    
-- Percentage of Successful Projects  by Category
SELECT 
    c.name,
    IFNULL((COUNT(CASE WHEN p.state = 'successful' THEN 1 END) / COUNT(*)) * 100, 0) AS success_percentage
FROM 
    projects p
LEFT JOIN 
    crowdfunding_category c ON p.category_id = c.id
GROUP BY 
    c.name
order by success_percentage desc;


-- Percentage of Successful Projects by Year , quarter and  Month
SELECT 
    YEAR(created_date) AS year,
    QUARTER(created_date) AS quarter,
    MONTH(created_date) AS month,
    IFNULL((COUNT(CASE WHEN state = 'successful' THEN 1 END) / COUNT(*)) * 100, 0) AS success_percentage
FROM 
    projects
GROUP BY 
    YEAR(created_date),
    QUARTER(created_date),
    MONTH(created_date)
ORDER BY 
    year,
    quarter,
    month;

-- Percentage of Successful projects by Goal Range
SELECT 
    goal_range,
    IFNULL((COUNT(CASE WHEN state = 'successful' THEN 1 END) / COUNT(*)) * 100, 0) AS success_percentage
FROM 
    (
        SELECT 
            CASE 
                WHEN goal >= 0 AND goal <= 9999 THEN '$0-$9999'
				WHEN goal >= 10000 AND goal <= 19999 THEN '$10000-$19999'
				WHEN goal >= 20000 AND goal <= 29999 THEN '$20000-$29999'
				WHEN goal >= 30000 AND goal <= 39999 THEN '$30000-$39999'
				ELSE 'Over $40000'
            END AS goal_range,
            state
        FROM 
            projects
    ) AS goal_ranges
GROUP BY 
    goal_range;
