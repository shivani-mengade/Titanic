/* Surviving female /*
SELECT PassengerId, Age, Sex
FROM titanic
WHERE Survived = 1 AND Sex = "female";

/* Surviving male /*
SELECT PassengerId, Sex 
FROM titanic
WHERE Survived = 1 AND Sex = "male";

/* Didnt survive female /*
SELECT PassengerId, Sex 
FROM titanic
WHERE Survived = 0 AND Sex = "female";

/* Didnt survive male /*
SELECT PassengerId, Sex 
FROM titanic
WHERE Survived = 0 AND Sex = "male";

/* Survival Rate /*
SELECT Survived, COUNT(*) AS Count, 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Titanic) AS Percentage
FROM titanic
GROUP BY Survived;

/* percent of dead and alive /*
SELECT Survived, COUNT(*) AS Count, 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM titanic) AS Percentage
FROM titanic
GROUP BY Survived;

/*Survival by Passenger Class/*
SELECT Pclass, COUNT(*) AS Total_count,
SUM(CASE WHEN Survived = 1 THEN 1 ELSE  0 END) AS Survived,
SUM(CASE WHEN Survived = 1 THEN 1 ELSE  0 END) * 100. / COUNT(*) AS Survival_rate
FROM titanic
GROUP BY Pclass
ORDER BY  Survival_rate DESC;

/* Survival by Gender /*
SELECT Sex, COUNT(*) AS gender,
SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Survived,
SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) *100 / COUNT(*) AS Survival_rate
FROM titanic
GROUP BY Sex
ORDER BY Survival_rate DESC;

/* Survival by Age Group/*
SELECT 
CASE WHEN Age < 10 THEN '0-9'
WHEN Age BETWEEN 10 AND 19 THEN '10-19'
WHEN Age BETWEEN 20 AND 29 THEN '20-29'
WHEN Age BETWEEN 30 AND 39 THEN '30-39'
WHEN Age BETWEEN 40 AND 49 THEN '40-49'
WHEN Age BETWEEN 50 AND 59 THEN '50-59'
ELSE '60+' END AS Age_rate,
COUNT(*) AS Total_Passengers,
SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Survival_count,
SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) * 100/ COUNT(*) AS Survival_Rate
FROM titanic
WHERE Age IS NOT NULL
GROUP BY CASE WHEN Age < 10 THEN '0-9'
WHEN Age BETWEEN 10 AND 19 THEN '10-19'
WHEN Age BETWEEN 20 AND 29 THEN '20-29'
WHEN Age BETWEEN 30 AND 39 THEN '30-39'
WHEN Age BETWEEN 40 AND 49 THEN '40-49'
WHEN Age BETWEEN 50 AND 59 THEN '50-59'
ELSE '60+' END
ORDER BY Age_Rate;

/* Fare Analysis /*
SELECT Pclass,
AVG(Fare) AS avgfare,
MIN(Fare) AS minfare,
MAX(Fare) AS maxfare
FROM titanic
GROUP BY Pclass
ORDER BY Pclass;

/* spent on ticket /*
SELECT ROUND(SUM(Fare),9) AS total_ticket_cost
FROM titanic;

/* Survival Rate for Families vs. Solo Travelers /*
SELECT Family_types, 
COUNT(*) AS count,
SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Survivecount,
SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Surviverate
FROM ( 
SELECT *, CASE 
WHEN SibSp = 1 THEN 'Solo'
WHEN SibSp BETWEEN 2 AND 4 THEN 'Small family'
ELSE 'Large family' 
END AS Family_types
FROM titanic) AS t
GROUP BY Family_types
ORDER BY Surviverate DESC;

/* Relationship Between Fare & Survival /*
SELECT Fare_rate, COUNT(*) AS count,
SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS SurvivelCount,
SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS SurvivalRate
FROM (
SELECT *, CASE
WHEN Fare BETWEEN 0 AND 10 THEN 'Cheaper'
WHEN Fare BETWEEN 11 AND 50 THEN 'Cheap'
WHEN Fare BETWEEN 51 AND 100 THEN 'Costly'
ELSE 'Expensive' END AS Fare_rate
FROM titanic ) AS t
GROUP BY Fare_rate
ORDER BY Fare_rate 

Add a Family_Size Column
ALTER TABLE titanic ADD Family int;
UPDATE titanic
SET Family = SibSp + Parch + 1;

/* Correlation Between Family Size and Survival /*
SELECT Family, COUNT(*) AS count,
SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS SurvivelCount,
SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS SurvivalRate
FROM titanic
GROUP BY Family
ORDER BY Family;

