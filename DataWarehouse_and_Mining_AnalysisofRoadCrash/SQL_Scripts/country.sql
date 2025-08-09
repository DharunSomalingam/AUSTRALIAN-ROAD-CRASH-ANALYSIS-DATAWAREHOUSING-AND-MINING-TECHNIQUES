SELECT state,SUM(NumberFatalities) as totalFatalities
FROM factaccident
JOIN dimlocation USING(locationID)
GROUP BY CUBE(state);

SELECT state,Nationallga,SUM(NumberFatalities) as totalFatalities
FROM factaccident
JOIN dimlocation USING(locationID)
WHERE state='WA'
GROUP BY CUBE(state,Nationallga)
ORDER BY state,Nationallga;

SELECT state,month,sa4Name,SUM(numberfatalities) as totalfatalities
FROM factaccident
JOIN dimlocation USING(locationID)
JOIN dimdate USING(dateID)
WHERE state in ('NSW','VIC','QLD') AND month=12
GROUP BY CUBE(state,sa4Name,month)
ORDER BY state,sa4Name;