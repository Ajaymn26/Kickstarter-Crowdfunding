SELECT FROM_UNIXTIME(created_at) AS Created_At_Date
FROM projects;
-- Add a new column to store the converted date
ALTER TABLE projects 
ADD COLUMN Created_date DATETIME;

-- Update the new column with human-readable dates
UPDATE projects
SET Created_date = FROM_UNIXTIME(created_at);

-- Optional: Display the updated project table
SELECT * FROM projects;

ALTER TABLE projects 
ADD COLUMN Deadline_date DATETIME;

-- Update the new column with human-readable dates
UPDATE projects
SET Deadline_date = FROM_UNIXTIME(deadline);

-- Optional: Display the updated project table
SELECT * FROM projects;


#Create updated date column
ALTER TABLE projects 
ADD COLUMN Updated_date DATETIME;

-- Update the new column with human-readable dates
UPDATE projects
SET Updated_date = FROM_UNIXTIME(updated_at);

-- Optional: Display the updated project table
SELECT * FROM projects;


#State changed at
#Create updated date column
ALTER TABLE projects 
ADD COLUMN State_changed_date DATETIME;

-- Update the new column with human-readable dates
UPDATE projects
SET State_changed_date = FROM_UNIXTIME(State_changed_at);

#successful at
ALTER TABLE projects 
ADD COLUMN Successful_date DATETIME;

-- Update the new column with human-readable dates
UPDATE projects
SET Successful_date = FROM_UNIXTIME(successful_at)
where state = 'successful';


#Launched at
#Create updated date column
ALTER TABLE projects 
ADD COLUMN Launched_date DATETIME;

-- Update the new column with human-readable dates
UPDATE projects
SET Launched_date = FROM_UNIXTIME(launched_at);

SELECT * FROM projects;



-- Add a new column to store the multiplied result
ALTER TABLE projects ADD COLUMN USD_GOAL_AMOUNT DECIMAL(30,2);

-- Update the new column with the multiplied result
UPDATE projects
SET USD_GOAL_AMOUNT = goal * static_usd_rate;

-- Optional: Display the updated project table
SELECT * FROM projects;


ALTER TABLE projects
ADD COLUMN goal_range VARCHAR(50);

UPDATE projects
SET goal_range = 
    CASE 
        WHEN goal >= 0 AND goal <= 9999 THEN '$0-$9999'
        WHEN goal >= 10000 AND goal <= 19999 THEN '$10000-$19999'
        WHEN goal >= 20000 AND goal <= 29999 THEN '$20000-$29999'
        WHEN goal >= 30000 AND goal <= 39999 THEN '$30000-$39999'
        ELSE 'Over $40000'
    END;

