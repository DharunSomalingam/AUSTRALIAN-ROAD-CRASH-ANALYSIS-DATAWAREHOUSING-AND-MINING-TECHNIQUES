-- Query to calculate the total fatalities by Year, using the CUBE operator to include all possible combinations
SELECT dimdate.Year,  -- Select the Year from the dimdate table
       SUM(factaccident.numberfatalities) AS Total_Fatalities  -- Sum of fatalities from the factaccident table
FROM factaccident  -- Fact table for accidents
JOIN dimdate USING(dateid)  -- Join with the Date dimension table using dateid
GROUP BY CUBE(dimdate.Year)  -- Use CUBE to include aggregations for each combination of Year (including nulls)
ORDER BY dimdate.Year;  -- Order the results by Year


-- Query to calculate the total fatalities by Year and Gender, using the CUBE operator
SELECT dimdate.Year,  -- Select the Year from the dimdate table
       dimroaduser.Gender,  -- Select Gender from the dimroaduser table
       SUM(factaccident.numberfatalities) AS Total_Fatalities  -- Sum of fatalities from the factaccident table
FROM factaccident  -- Fact table for accidents
JOIN dimdate USING(dateid)  -- Join with the Date dimension table using dateid
JOIN dimroaduser USING(userid)  -- Join with the Road User dimension table using userid
GROUP BY CUBE(dimdate.Year, dimroaduser.Gender)  -- Use CUBE to include all combinations of Year and Gender
ORDER BY dimdate.Year, dimroaduser.Gender;  -- Order the results by Year, then by Gender

-- Query to calculate the total fatalities by Year, Agegroup, and Gender (for Males in 1989), using the CUBE operator
SELECT dimdate.Year,  -- Select the Year from the dimdate table
       dimroaduser.Agegroup,  -- Select Agegroup from the dimroaduser table
       dimroaduser.Gender,  -- Select Gender from the dimroaduser table
       SUM(factaccident.numberfatalities) AS Total_Fatalities  -- Sum of fatalities from the factaccident table
FROM factaccident  -- Fact table for accidents
JOIN dimdate USING(dateid)  -- Join with the Date dimension table using dateid
JOIN dimroaduser USING(userid)  -- Join with the Road User dimension table using userid
WHERE dimroaduser.Gender = 'Male' AND dimdate.Year = '1989'  -- Filter for Males in the year 1989
GROUP BY CUBE(dimdate.Year, dimroaduser.Agegroup, dimroaduser.Gender)  -- Use CUBE to include all combinations of Year, Agegroup, and Gender
ORDER BY dimdate.Year, dimroaduser.Agegroup, dimroaduser.Gender;  -- Order the results by Year, then Agegroup, then Gender