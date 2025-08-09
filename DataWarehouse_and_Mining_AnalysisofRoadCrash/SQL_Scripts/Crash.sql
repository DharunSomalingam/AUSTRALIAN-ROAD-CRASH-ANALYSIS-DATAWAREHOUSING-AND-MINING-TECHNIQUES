-- Query to calculate the total fatalities by Crash Type, using the CUBE operator to include all possible combinations
SELECT dimcrashtype.crashtype,  -- Select the Crash Type from the dimcrashtype table
       SUM(factaccident.numberfatalities) AS totalfatalities  -- Sum of fatalities from the factaccident table
FROM factaccident  -- Fact table for accidents
JOIN dimcrashtype USING(typeid)  -- Join with the Crash Type dimension table using typeid
GROUP BY CUBE(dimcrashtype.crashtype)  -- Use CUBE to include aggregations for each combination of Crash Type (including nulls)
ORDER BY dimcrashtype.crashtype;  -- Order the results by Crash Type


-- Query to calculate the number of fatalities by Crash Type and National Road Type, using the CUBE operator
SELECT dimcrashtype.crashtype,  -- Select the Crash Type from the dimcrashtype table
       dimroad.Nationalroadtype,  -- Select National Road Type from the dimroad table
       SUM(factaccident.numberfatalities) AS totalfatalities  -- Calculate the number of fatalities from the factaccident table
FROM factaccident  -- Fact table for accidents
JOIN dimcrashtype USING(typeid)  -- Join with the Crash Type dimension table using typeid
JOIN dimroad USING(roadid)  -- Join with the Road dimension table using roadid
WHERE dimroad.Nationalroadtype != 'Undetermined'  -- Filter out 'Undetermined' road types
GROUP BY CUBE(dimroad.Nationalroadtype, dimcrashtype.crashtype)  -- Use CUBE to include all combinations of National Road Type and Crash Type
ORDER BY dimroad.Nationalroadtype, dimcrashtype.crashtype;  -- Order the results by National Road Type, then by Crash Type


-- Query to calculate the total and average fatalities by Crash Type, National Road Type, and Business Involvement, using the CUBE operator
SELECT dimcrashtype.crashtype,  -- Select the Crash Type from the dimcrashtype table
       dimroad.Nationalroadtype,  -- Select National Road Type from the dimroad table
       dimcrash.businvolvement,  -- Select Business Involvement from the dimcrash table
       SUM(factaccident.numberfatalities) AS totalfatalities,  -- Calculate the total fatalities
       AVG(factaccident.numberfatalities) AS averagefatalities  -- Calculate the average fatalities
FROM factaccident  -- Fact table for accidents
JOIN dimcrashtype USING(typeid)  -- Join with the Crash Type dimension table using typeid
JOIN dimroad USING(roadid)  -- Join with the Road dimension table using roadid
JOIN dimcrash USING(involvementid)  -- Join with the Crash dimension table using involvementid
WHERE dimroad.Nationalroadtype IN ('Arterial Road', 'Collector Road', 'Local Road', 'National or State Highway')  -- Filter for specific road types
AND dimcrashtype.crashtype = 'Multiple'  -- Filter for 'Multiple' crash type
GROUP BY CUBE(dimroad.Nationalroadtype, dimcrashtype.crashtype, dimcrash.businvolvement)  -- Use CUBE to include all combinations of National Road Type, Crash Type, and Business Involvement
ORDER BY dimroad.Nationalroadtype, dimcrashtype.crashtype, dimcrash.businvolvement;  -- Order the results by National Road Type, Crash Type, and Business Involvement


