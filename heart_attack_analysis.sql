1.whats the count of total patnents.

 select count(patient_id) from hattack


2.Whats the total count by gender.

select count(patient_id) , gender from hattack
group by 2


3--  What is the average, minimum, and maximum age of patients? --

select avg(age)from hattack

select min(age)from hattack

select max(age)from hattack



4-- -- What is the average cholesterol level of patients?--

select avg(cholesterol_level)from hattack


5 -- Count how many patients had a heart attack versus those who didn't (distribute each according to gender) --

select count (patient_id),heart_attack_outcome,gender from hattack
group by 2,3


6 --What is the average blood pressure of patients who had a heart attack?

select 
avg(blood_pressure_systolic) avg_systolic,
avg(blood_pressure_diastolic)avg_diastolic
from hattack
where heart_attack_outcome = 1


7 ----Do smokers have a higher risk of heart attack? 
--(Compare the percentage of smokers in both groups)

SELECT Smoking_Status,
       COUNT(*) AS count,
       COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage
FROM hattack
WHERE heart_attack_outcome = 1
GROUP BY smoking_status;

			as same checking of diabetic patients 

 8 ----Do diabetic patients have a higher chance of heart attack?

SELECT diabetes_status,
       COUNT(*) AS count,
       COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage
FROM hattack
WHERE heart_attack_outcome = 1
GROUP BY diabetes_status;


9     --  Are older patients more likely to have a heart attack and who haven't? 
	--  (Find average age for both groups)

select heart_attack_outcome ,avg(age) from hattack
group by heart_attack_outcome 


10. -- Find the most common risk factor combinations among heart attack patients.

select smoking_status,diabetes_status,obesity_index,count(*) from hattack
where heart_attack_outcome = 1 
group by 1,2,3
order by count desc
limit 5
--obesity = excessive accumulation of body fat.



11.-- Check if high BMI correlates with an increased risk of heart attacks.

select heart_attack_outcome ,avg(obesity_index) as avg_obesity from hattack
group by heart_attack_outcome
order by avg_obesity desc

--yes , the high BMI  correlates with as 


12 --Create an age group distribution and check 
--which age group has the highest heart attack rate.

SELECT  CASE 
WHEN age BETWEEN 20 AND 29 THEN '20-29'
WHEN age BETWEEN 30 AND 39 THEN '30-39'
WHEN age BETWEEN 40 AND 49 THEN '40-49'
WHEN age BETWEEN 50 AND 59 THEN '50-59'
WHEN age BETWEEN 60 AND 69 THEN '60-69'
WHEN age >= 70 THEN '70+'
END AS age_group,
COUNT(*) AS total_patients,
SUM(CASE WHEN heart_attack_outcome = 1 THEN 1 ELSE 0 END) AS heart_attack_cases
FROM hattack
GROUP BY age_group
ORDER BY heart_attack_cases DESC;


13. -- Rank the top 5 highest risk factors based on frequency in heart attack patients

SELECT Risk_Factor, COUNT(*) AS count
FROM 
(
	
SELECT Smoking_Status AS Risk_Factor FROM hattack WHERE Heart_Attack_Outcome = 1
UNION ALL
SELECT Diabetes_Status FROM hattack WHERE Heart_Attack_Outcome = 1
UNION ALL
SELECT Stress_Level FROM hattack WHERE Heart_Attack_Outcome = 1
) sub
GROUP BY Risk_Factor
ORDER BY count DESC
LIMIT 5;



