-- Query to calculate the total fatalities by Speed Limit, using the CUBE operator
SELECT dimspeed.speedlimit,  -- Select Speed Limit from the dimspeed table
       SUM(factaccident.numberfatalities) AS totalfatalities  -- Calculate the total fatalities from the factaccident table
FROM factaccident  -- Fact table for accident data
JOIN dimspeed USING(speedid)  -- Join with the Speed dimension table using speedid
GROUP BY CUBE(dimspeed.speedlimit)  -- Use CUBE to generate all combinations (including overall total)
ORDER BY dimspeed.speedlimit;  -- Order the results by Speed Limit


-- Query to calculate total fatalities by Speed Limit and Day of Week, using the CUBE operator
SELECT dimspeed.speedlimit,  -- Select Speed Limit from the dimspeed table
       dimperiod.dayofweek,  -- Select Day of Week from the dimperiod table
       SUM(factaccident.numberfatalities) AS totalfatalities  -- Calculate total fatalities from the factaccident table
FROM factaccident  -- Fact table for accident data
JOIN dimspeed USING(speedid)  -- Join with Speed dimension using speedid
JOIN dimperiod USING(periodid)  -- Join with Period dimension using periodid
GROUP BY CUBE(dimspeed.speedlimit, dimperiod.dayofweek)  -- Use CUBE to group by all combinations of speed limit and day of week
ORDER BY dimspeed.speedlimit, dimperiod.dayofweek;  -- Order results by Speed Limit and Day of Week


-- Query to calculate total fatalities by Speed Limit and Day/Week category,
-- filtered for Weekdays and Speed Limit greater than 30, using the CUBE operator
SELECT dimspeed.speedlimit,  -- Select Speed Limit from the dimspeed table
       dimdate.dayweek,  -- Select Day/Week category (e.g., Weekday/Weekend) from the dimdate table
       SUM(factaccident.numberfatalities) AS totalfatalities  -- Calculate total fatalities from the factaccident table
FROM factaccident  -- Fact table for accident data
JOIN dimspeed USING(speedid)  -- Join with Speed dimension table using speedid
JOIN dimperiod USING(periodid)  -- Join with Period dimension using periodid
JOIN dimdate USING(dateid)  -- Join with Date dimension using dateid
WHERE dimperiod.dayofweek = 'Weekday'  -- Filter to include only Weekday records
  AND dimspeed.speedlimit > 30  -- Filter to include only Speed Limits over 30
GROUP BY CUBE(dimspeed.speedlimit, dimdate.dayweek)  -- Group results by all combinations of Speed Limit and Day/Week
ORDER BY dimspeed.speedlimit, dimdate.dayweek;  -- Order results by Speed Limit and Day/Week


-- Query to calculate total fatalities by Speed Limit, Day of Week (Thursday/Friday), and Time of Day,
-- filtered for Speed Limit greater than 30, using the CUBE operator
SELECT dimspeed.speedlimit,  -- Select Speed Limit from the dimspeed table
       dimdate.dayweek,  -- Select Day of Week (e.g., Thursday/Friday) from the dimdate table
       dimperiod.timeofday,  -- Select Time of Day (e.g., morning, afternoon) from the dimperiod table
       SUM(factaccident.numberfatalities) AS totalfatalities  -- Calculate total fatalities from the factaccident table
FROM factaccident  -- Fact table for accident data
JOIN dimspeed USING(speedid)  -- Join with Speed dimension using speedid
JOIN dimperiod USING(periodid)  -- Join with Period dimension using periodid
JOIN dimdate USING(dateid)  -- Join with Date dimension using dateid
WHERE (dimdate.dayweek = 'Friday' OR dimdate.dayweek = 'Thursday')  -- Filter to include only Thursday and Friday
  AND dimspeed.speedlimit > 30  -- Filter to include only Speed Limits over 30
GROUP BY CUBE(dimspeed.speedlimit, dimdate.dayweek, dimperiod.timeofday)  -- Use CUBE to include all combinations of Speed Limit, Day of Week, and Time of Day
ORDER BY dimspeed.speedlimit, dimdate.dayweek, dimperiod.timeofday;  -- Order the results by Speed Limit, Day of Week, and Time of Day
