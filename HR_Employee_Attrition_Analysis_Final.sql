
select dbo.HR_Analysis$ from INFORMATION_SCHEMA.TABLES where TABLE_TYPE ='base table'
select * from INFORMATION_SCHEMA.TABLES
select * from [debo].[HR_Analysis]
select top 10 * from dbo.HR_Analysis$
SELECT * FROM DBO.HR_Analysis$
SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'HR_Analysis$'
ORDER BY ORDINAL_POSITION;

exec sp_help 'dbo.HR_Analysis$'

--------start 
---------count total employees
select COUNT (* )as Total_Records from dbo.HR_Analysis$
--Check for duplicate emp IDS
select EmpID ,count (*) as duplicate_count from dbo.HR_Analysis$ group by EmpID having COUNT(*) >1;

---check whether those are true duplicate rows
select COUNT(*) distinct_rows from (select distinct * from dbo.HR_Analysis$) as x
--- inspect the 1475 distinct record
 select distinct * from dbo.HR_Analysis$
 select count(distinct EmpID) as unique_employees from dbo.HR_Analysis$

 ---Find out why employees repeat
 select top 20 empid,count (*) as number_of_records 
 from dbo.HR_Analysis$ group by EmpID
 having  count (*) >1
 order by number_of_records desc 

 --- let's imppact one employee
 select * from dbo.HR_Analysis$ WHERE EmpID = 'RM297';

 -----COMPare the 19 records
  select DISTINCT * from dbo.HR_Analysis$ WHERE EmpID = 'RM297';

  --- find the total number of exact dplicate rows
 select count (*) as total_rows, 
 count (*) - count (distinct empid ) as difference
 from dbo.HR_Analysis$
 --- lets measure the exact duplicate correctly
 select 
 count(*) as total_rows,
 count(*)- (
 select count(*) from(select distinct * from dbo.HR_Analysis$) 
    as uniqueRows 
 )as exact_duplicate_rows
 from dbo.HR_Analysis$

 ---- check missing values
 select * from dbo.HR_Analysis$
 where Department is null
 
 ---
 select count (*) as missing_department 
 from dbo.HR_Analysis$
 where Department is null

 -- Data Quality Check: Missing Department
-- Found 4 rows with NULL Department values.
-- All 4 rows are identical and contain mostly missing information.
-- Action: Investigate as duplicate incomplete records before removal.

--check the next column
select count(*) as missing_age
from dbo.HR_Analysis$
where age is null

-- checking missing values
select count(*) as missing_agegroup
from dbo.HR_Analysis$
where AgeGroup is null

-- checking missing values
select count(*) as missing_attrition
from dbo.HR_Analysis$
where Attrition is null

-- checking missing values
select count(*) as missing_businessTravel
from dbo.HR_Analysis$
where BusinessTravel is null

-- checking missing values
select count(*) as missing_gender
from dbo.HR_Analysis$
where Gender is null                    

-- checking missing values
select count(*) as missing_DailyRate
from dbo.HR_Analysis$
where DailyRate is null              

-- checking missing values
select count(*) as missing_DistanceFromHome
from dbo.HR_Analysis$
where DistanceFromHome is null   

-- checking missing values
select count(*) as missing_Education
from dbo.HR_Analysis$
where Education is null       

-- checking missing values
select count(*) as missing_jobrole
from dbo.HR_Analysis$
where JobRole is null

SELECT
    EmpID,
    CASE WHEN Department IS NULL THEN 1 ELSE 0 END AS Missing_Department,
    CASE WHEN Gender IS NULL THEN 1 ELSE 0 END AS Missing_Gender,
    CASE WHEN DailyRate IS NULL THEN 1 ELSE 0 END AS Missing_DailyRate,
    CASE WHEN DistanceFromHome IS NULL THEN 1 ELSE 0 END AS Missing_Distance,
    CASE WHEN Education IS NULL THEN 1 ELSE 0 END AS Missing_Education
FROM dbo.HR_Analysis$
WHERE Department IS NULL
   OR Gender IS NULL
   OR DailyRate IS NULL
   OR DistanceFromHome IS NULL
   OR Education IS NULL;

---verify the records
   SELECT COUNT(*) AS Incomplete_Rows
FROM dbo.HR_Analysis$
WHERE Department IS NULL
  AND Gender IS NULL
  AND DailyRate IS NULL
  AND DistanceFromHome IS NULL
  AND Education IS NULL;

  SELECT *
FROM dbo.HR_Analysis$
WHERE Department IS NULL
  AND Gender IS NULL
  AND DailyRate IS NULL
  AND DistanceFromHome IS NULL
  AND Education IS NULL;

  SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT EmpID) AS UniqueEmployees
FROM dbo.HR_Analysis$;

SELECT
    EmpID,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis$
GROUP BY EmpID
HAVING COUNT(*) > 1
ORDER BY RecordCount DESC;

SELECT
    EmpID,
    COUNT(*) AS TotalRecords,
    COUNT(DISTINCT Department) AS DifferentDepartments,
    COUNT(DISTINCT Age) AS DifferentAges,
    COUNT(DISTINCT Attrition) AS DifferentAttritionValues
FROM dbo.HR_Analysis$
GROUP BY EmpID
HAVING COUNT(*) > 1
   AND (
       COUNT(DISTINCT Department) > 1
       OR COUNT(DISTINCT Age) > 1
       OR COUNT(DISTINCT Attrition) > 1
   )
ORDER BY TotalRecords DESC;

SELECT
    EmpID,
    COUNT(*) AS TotalRecords,
    COUNT(DISTINCT Department) AS Departments,
    COUNT(DISTINCT Gender) AS Genders,
    COUNT(DISTINCT JobRole) AS JobRoles,
    COUNT(DISTINCT MonthlyIncome) AS IncomeValues
FROM dbo.HR_Analysis$
GROUP BY EmpID
HAVING COUNT(*) > 1
   AND (
       COUNT(DISTINCT Department) > 1
       OR COUNT(DISTINCT Gender) > 1
       OR COUNT(DISTINCT JobRole) > 1
       OR COUNT(DISTINCT MonthlyIncome) > 1
   )
ORDER BY TotalRecords DESC;

SELECT COUNT(*) AS CleanDistinctRows
FROM (
    SELECT DISTINCT *
    FROM dbo.HR_Analysis$
) AS DistinctRecords;

SELECT DISTINCT *
INTO dbo.HR_Analysis_clean
FROM dbo.HR_Analysis$
WHERE NOT (
    Department IS NULL
    AND Gender IS NULL
    AND DailyRate IS NULL
    AND DistanceFromHome IS NULL
    AND Education IS NULL
);
select * from dbo.HR_Analysis_clean

--verify the cleaned table
select count(*) as cleanedRows
from dbo.HR_Analysis_clean

-- check unique employees inthe cleaned
	select count(*) as cleanedRows,
	count(distinct empid) as uniqueemployees
	from dbo.HR_Analysis_clean

--find employees with multiple records
 select EmpID,
 COUNT(*) as recordCount
 from dbo.HR_Analysis_clean
 group by EmpID
  having count(*) >1
  order by recordCount desc

SELECT *
FROM dbo.HR_Analysis_clean
WHERE EmpID IN ('RM1465', 'RM1466', 'RM1467' )
ORDER BY EmpID;



--checking the result
select count(*) as cleanedrows,
count(distinct empid) as uniqueEmplees
from dbo.HR_Analysis_clean_v2

select * from dbo.HR_Analysis_clean
where EmpID= 'RMI85'

 select top 10 empid
 from dbo.HR_Analysis_clean
 where EmpID like '%185%'

 SELECT  * from dbo.HR_Analysis_clean
 where LTRIM (rtrim (empid)) = 'RM185'

 SELECT TOP 10 EMPID
 FROM DBO.HR_Analysis_clean

 SELECT empid ,
 count (*) as recordcount 
 from dbo.HR_Analysis_clean
 group by EmpID
 having COUNT(*)>1
 order by recordcount desc

 -- identify the last column
 select  Ordinal_position,
 COLUMN_NAME,
 data_type 
 from INFORMATION_SCHEMA.COLUMNS
  where TABLE_SCHEMA='dbo'
and TABLE_NAME='HR_Analysis_clean'
order by ORDINAL_POSITION

select TABLE_SCHEMA, TABLE_NAME
from INFORMATION_SCHEMA.TABLES
where TABLE_TYPE='base table'
and TABLE_NAME like 'HR_Analysis_clean'

select TABLE_SCHEMA, TABLE_NAME
from INFORMATION_SCHEMA.TABLES
where TABLE_TYPE='base table'
ORDER BY TABLE_NAME 

SELECT *
FROM dbo.[HR_Analysis$]
WHERE EmpID IN ('RM1465', 'RM1466', 'RM1467', 'RM185')
ORDER BY EMPID;




SELECT
    EmpID,
    YearsWithCurrManager,
    COUNT(*) AS RecordCount
FROM dbo.[HR_Analysis$]
WHERE EmpID IN ('RM1465', 'RM1466', 'RM1467', 'RM185')
GROUP BY EmpID, YearsWithCurrManager
ORDER BY EmpID, YearsWithCurrManager;

SELECT
    'Raw Data' AS TableName,
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT EmpID) AS UniqueEmployees
FROM dbo.[HR_Analysis$]

UNION ALL

SELECT
    'Cleaned Data' AS TableName,
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT EmpID) AS UniqueEmployees
FROM dbo.HR_Analysis_clean;

SELECT
    EmpID,
    COUNT(*) AS RecordCount
FROM dbo.[HR_Analysis$]
GROUP BY EmpID
HAVING COUNT(*) > 1
ORDER BY RecordCount DESC;

SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT EmpID) AS UniqueEmployees,
    COUNT(*) - COUNT(DISTINCT EmpID) AS ExtraRows
FROM dbo.HR_Analysis_clean;

SELECT
    EmpID,
    Age,
    YearsWithCurrManager,
    COUNT(*) AS RepeatedCount
FROM dbo.HR_Analysis_clean
WHERE EmpID IN ('RM1465', 'RM1466', 'RM1467', 'RM185')
GROUP BY
    EmpID,
    Age,
    YearsWithCurrManager
ORDER BY EmpID, YearsWithCurrManager;

SELECT COUNT(*) AS TotalRows
FROM dbo.HR_Analysis_clean
WHERE EmpID = 'RM185';


select * from dbo.[HR_Analysis$]
where EmpID= 'RMI85'

SELECT DISTINCT EMPID
FROM DBO.HR_Analysis$
WHERE EmpID LIKE '%185%'

SELECT EmpID, YearsWithCurrManager
from dbo.HR_Analysis$
where LTRIM(rtrim(empid))= 'rm185'

SELECT*
from dbo.HR_Analysis$
where LTRIM(rtrim(empid))= 'rm185'

SELECT
    EmpID,
    YearsWithCurrManager,
    COUNT(*) AS RecordCount
FROM dbo.[HR_Analysis$]
WHERE LTRIM(RTRIM(EmpID)) = 'RM185'
GROUP BY EmpID, YearsWithCurrManager
ORDER BY YearsWithCurrManager;



select * into 
dbo.HR_ANALYSIS_CLEAN_BACKUP
FROM DBO.HR_Analysis_clean


SELECT COUNT(*) AS BACKUPROWS
FROM DBO.HR_ANALYSIS_CLEAN_BACKUP

select EmpID,
count(*) as recordcount
from dbo.HR_Analysis_clean
group by EmpID
having COUNT (*) >1
order by EmpID

select 
count (*) as totalrows,
count(distinct empid) as uniqueemployee
from dbo.HR_Analysis_clean

SELECT
    EmpID,
    Age,
    AgeGroup,
    Attrition,
    BusinessTravel,
    DailyRate,
    Department,
    DistanceFromHome,
    Education,
    EducationField,
    EmployeeCount,
    EnvironmentSatisfaction,
    Gender,
    HourlyRate,
    JobInvolvement,
    JobLevel,
    JobRole,
    JobSatisfaction,
    MaritalStatus,
    MonthlyIncome,
    SalarySlab,
    MonthlyRate,
    NumCompaniesWorked,
    OverTime,
    PercentSalaryHike,
    PerformanceRating,
    RelationshipSatisfaction,
    StandardHours,
    TotalWorkingYears,
    WorkLifeBalance,
    YearsAtCompany,
    YearsInCurrentRole,
    YearsSinceLastPromotion,
    YearsWithCurrManager,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY
    EmpID, Age, AgeGroup, Attrition, BusinessTravel, DailyRate,
    Department, DistanceFromHome, Education, EducationField,
    EmployeeCount, EnvironmentSatisfaction, Gender, HourlyRate,
    JobInvolvement, JobLevel, JobRole, JobSatisfaction, MaritalStatus,
    MonthlyIncome, SalarySlab, MonthlyRate, NumCompaniesWorked,
    OverTime, PercentSalaryHike, PerformanceRating,
    RelationshipSatisfaction, StandardHours, TotalWorkingYears,
    WorkLifeBalance, YearsAtCompany, YearsInCurrentRole,
    YearsSinceLastPromotion, YearsWithCurrManager
HAVING COUNT(*) > 1;







--find missing values across the entire dataset
SELECT
    v.ColumnName,
    SUM(v.IsMissing) AS MissingCount
FROM dbo.HR_Analysis_clean AS h
CROSS APPLY (
    VALUES
    ('EmpID', CASE WHEN h.EmpID IS NULL THEN 1 ELSE 0 END),
    ('Age', CASE WHEN h.Age IS NULL THEN 1 ELSE 0 END),
    ('AgeGroup', CASE WHEN h.AgeGroup IS NULL THEN 1 ELSE 0 END),
    ('Attrition', CASE WHEN h.Attrition IS NULL THEN 1 ELSE 0 END),
    ('BusinessTravel', CASE WHEN h.BusinessTravel IS NULL THEN 1 ELSE 0 END),
    ('DailyRate', CASE WHEN h.DailyRate IS NULL THEN 1 ELSE 0 END),
    ('Department', CASE WHEN h.Department IS NULL THEN 1 ELSE 0 END),
    ('DistanceFromHome', CASE WHEN h.DistanceFromHome IS NULL THEN 1 ELSE 0 END),
    ('Education', CASE WHEN h.Education IS NULL THEN 1 ELSE 0 END),
    ('EducationField', CASE WHEN h.EducationField IS NULL THEN 1 ELSE 0 END),
    ('EmployeeCount', CASE WHEN h.EmployeeCount IS NULL THEN 1 ELSE 0 END),
    ('EnvironmentSatisfaction', CASE WHEN h.EnvironmentSatisfaction IS NULL THEN 1 ELSE 0 END),
    ('Gender', CASE WHEN h.Gender IS NULL THEN 1 ELSE 0 END),
    ('HourlyRate', CASE WHEN h.HourlyRate IS NULL THEN 1 ELSE 0 END),
    ('JobInvolvement', CASE WHEN h.JobInvolvement IS NULL THEN 1 ELSE 0 END),
    ('JobLevel', CASE WHEN h.JobLevel IS NULL THEN 1 ELSE 0 END),
    ('JobRole', CASE WHEN h.JobRole IS NULL THEN 1 ELSE 0 END),
    ('JobSatisfaction', CASE WHEN h.JobSatisfaction IS NULL THEN 1 ELSE 0 END),
    ('MaritalStatus', CASE WHEN h.MaritalStatus IS NULL THEN 1 ELSE 0 END),
    ('MonthlyIncome', CASE WHEN h.MonthlyIncome IS NULL THEN 1 ELSE 0 END),
    ('SalarySlab', CASE WHEN h.SalarySlab IS NULL THEN 1 ELSE 0 END),
    ('MonthlyRate', CASE WHEN h.MonthlyRate IS NULL THEN 1 ELSE 0 END),
    ('NumCompaniesWorked', CASE WHEN h.NumCompaniesWorked IS NULL THEN 1 ELSE 0 END),
    ('OverTime', CASE WHEN h.OverTime IS NULL THEN 1 ELSE 0 END),
    ('PercentSalaryHike', CASE WHEN h.PercentSalaryHike IS NULL THEN 1 ELSE 0 END),
    ('PerformanceRating', CASE WHEN h.PerformanceRating IS NULL THEN 1 ELSE 0 END),
    ('RelationshipSatisfaction', CASE WHEN h.RelationshipSatisfaction IS NULL THEN 1 ELSE 0 END),
    ('StandardHours', CASE WHEN h.StandardHours IS NULL THEN 1 ELSE 0 END),
    ('TotalWorkingYears', CASE WHEN h.TotalWorkingYears IS NULL THEN 1 ELSE 0 END),
    ('WorkLifeBalance', CASE WHEN h.WorkLifeBalance IS NULL THEN 1 ELSE 0 END),
    ('YearsAtCompany', CASE WHEN h.YearsAtCompany IS NULL THEN 1 ELSE 0 END),
    ('YearsInCurrentRole', CASE WHEN h.YearsInCurrentRole IS NULL THEN 1 ELSE 0 END),
    ('YearsSinceLastPromotion', CASE WHEN h.YearsSinceLastPromotion IS NULL THEN 1 ELSE 0 END),
    ('YearsWithCurrManager', CASE WHEN h.YearsWithCurrManager IS NULL THEN 1 ELSE 0 END)
) AS v(ColumnName, IsMissing)
GROUP BY v.ColumnName
ORDER BY MissingCount DESC, v.ColumnName;

SELECT
    EmpID,
    PercentSalaryHike,
    PerformanceRating,
    RelationshipSatisfaction,
    StandardHours,
    TotalWorkingYears,
    WorkLifeBalance,
    YearsAtCompany,
    YearsInCurrentRole,
    YearsSinceLastPromotion,
    YearsWithCurrManager
FROM dbo.HR_Analysis_clean
WHERE PercentSalaryHike IS NULL
   OR PerformanceRating IS NULL
   OR RelationshipSatisfaction IS NULL
   OR StandardHours IS NULL
   OR TotalWorkingYears IS NULL
   OR WorkLifeBalance IS NULL
   OR YearsAtCompany IS NULL
   OR YearsInCurrentRole IS NULL
   OR YearsSinceLastPromotion IS NULL
   OR YearsWithCurrManager IS NULL
ORDER BY EmpID;


SELECT
    EmpID,
    Age,
    TotalWorkingYears,
    YearsAtCompany,
    YearsInCurrentRole,
    YearsSinceLastPromotion,
    YearsWithCurrManager
FROM dbo.HR_Analysis_clean
WHERE Age < 18
   OR Age > 100
   OR TotalWorkingYears < 0
   OR YearsAtCompany < 0
   OR YearsInCurrentRole < 0
   OR YearsSinceLastPromotion < 0
   OR YearsWithCurrManager < 0
   OR YearsAtCompany > TotalWorkingYears
   OR YearsInCurrentRole > YearsAtCompany
   OR YearsSinceLastPromotion > YearsAtCompany
   OR YearsWithCurrManager > YearsAtCompany
ORDER BY EmpID;

SELECT
    EmpID,
    TotalWorkingYears,
    YearsAtCompany,
    YearsInCurrentRole,
    YearsSinceLastPromotion,
    YearsWithCurrManager
FROM dbo.HR_Analysis_clean
WHERE YearsAtCompany > TotalWorkingYears
   OR YearsInCurrentRole > YearsAtCompany
   OR YearsSinceLastPromotion > YearsAtCompany
   OR YearsWithCurrManager > YearsAtCompany
ORDER BY EmpID;


select gender ,count(*) 
as recordcount
from dbo.HR_Analysis_clean
group by Gender
order by Gender

SELECT
    Department,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY Department
ORDER BY Department;

SELECT
    BusinessTravel,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY BusinessTravel
ORDER BY BusinessTravel;

SELECT
    JobRole,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY JobRole
ORDER BY JobRole;

SELECT
    EducationField,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY EducationField
ORDER BY EducationField;


SELECT
    MaritalStatus,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY MaritalStatus
ORDER BY MaritalStatus;

SELECT
    Attrition,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY Attrition
ORDER BY Attrition;

SELECT
    OverTime,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY OverTime
ORDER BY OverTime;

SELECT
    AgeGroup,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY AgeGroup
ORDER BY AgeGroup;
SELECT
    SalarySlab,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY SalarySlab
ORDER BY SalarySlab;

SELECT
    EmpID,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY EmpID
ORDER BY EmpID;


select * from dbo.HR_Analysis_clean
where BusinessTravel= 'travel_rarely'
 
 update dbo.HR_Analysis_clean
 set BusinessTravel= 'Travel_Rarely'
 WHERE BusinessTravel = 'travelrarely'

 select BusinessTravel, count(*) as recordcount
 from dbo.HR_Analysis_clean
 group by BusinessTravel
 order by BusinessTravel

 SELECT
    JobRole,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY JobRole
ORDER BY RecordCount DESC;

SELECT
    BusinessTravel,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY BusinessTravel
ORDER BY BusinessTravel;

SELECT
    EmpID,
    COUNT(*) AS RecordCount
FROM dbo.[HR_Analysis_clean]
GROUP BY EmpID
HAVING COUNT(*) > 1
ORDER BY EmpID ;

select * 
from dbo.HR_Analysis_clean
where EmpID= 'rm185'

SELECT
    EmpID,
    COUNT(*) AS TotalRecords,
    SUM(CASE
        WHEN PercentSalaryHike IS NULL
          AND PerformanceRating IS NULL
          AND RelationshipSatisfaction IS NULL
          AND StandardHours IS NULL
          AND TotalWorkingYears IS NULL
          AND WorkLifeBalance IS NULL
          AND YearsAtCompany IS NULL
          AND YearsInCurrentRole IS NULL
          AND YearsSinceLastPromotion IS NULL
          AND YearsWithCurrManager IS NULL
        THEN 1 ELSE 0
    END) AS IncompleteRecords
FROM dbo.HR_Analysis_clean
WHERE EmpID = 'RM185'
GROUP BY EmpID;


SELECT
    EmpID,
    YearsAtCompany,
    TotalWorkingYears,
    YearsWithCurrManager
FROM dbo.HR_Analysis_clean
WHERE EmpID IN ('RM1465', 'RM1466', 'RM1467')
ORDER BY EmpID;

SELECT
    Department,
    Attrition,
    COUNT(*) AS EmployeeRecords
FROM dbo.HR_Analysis_clean
GROUP BY Department, Attrition
ORDER BY Department, Attrition;

SELECT
    Department,
    COUNT(*) AS TotalRecords,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS AttritionRecords,
    CAST(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) AS DECIMAL(5,2)
    ) AS AttritionRatePercent
FROM dbo.HR_Analysis_clean
GROUP BY Department
ORDER BY AttritionRatePercent DESC;



-- basic HR analysis attrition by overtime
select OverTime,
count(*) as totalRecord,
sum(case when attrition ='yes' then 1  else 0 end) as attritionRecord,
CAST(100.0 *sum( case when attrition ='yes' then 1 else 0 end)
/ count(*) as decimal (5,2))as attritionRatePercent
from dbo.HR_Analysis_clean
group by OverTime
order by attritionRatePercent desc

select JobRole,
count(*) as totalRecord,
sum(case when attrition ='yes' then 1  else 0 end) as attritionRecord,
CAST(100.0 *sum( case when attrition ='yes' then 1 else 0 end)
/ count(*) as decimal (5,2))as attritionRatePercent
from dbo.HR_Analysis_clean
group by JobRole
order by attritionRatePercent desc


select JobSatisfaction,
count(*) as totalRecord,
sum(case when attrition ='yes' then 1  else 0 end) as attritionRecord,
CAST(100.0 *sum( case when attrition ='yes' then 1 else 0 end)
/ count(*) as decimal (5,2))as attritionRatePercent
from dbo.HR_Analysis_clean
group by JobSatisfaction
order by attritionRatePercent desc


select AgeGroup,
count(*) as totalEmployees,
sum(case when attrition ='yes' then 1 else 0 end) as EmployeeWhoLeft,
CAST(100.0 * sum(case when attrition ='yes' then 1 else 0 end)
/count (*) as decimal (5,2)) as attririonRatePecent
from dbo.HR_Analysis_clean
group by AgeGroup
order by attririonRatePecent desc


select SalarySlab,
count(*) as totalEmployees,
sum(case when attrition ='yes' then 1 else 0 end) as EmployeeWhoLeft,
CAST(100.0 * sum(case when attrition ='yes' then 1 else 0 end)
/count (*) as decimal (5,2)) as attririonRatePecent
from dbo.HR_Analysis_clean
group by SalarySlab
order by attririonRatePecent desc

select BusinessTravel,
count(*) as totalEmployees,
sum(case when attrition ='yes' then 1 else 0 end) as EmployeeWhoLeft,
CAST(100.0 * sum(case when attrition ='yes' then 1 else 0 end)
/count (*) as decimal (5,2)) as attririonRatePecent
from dbo.HR_Analysis_clean
group by BusinessTravel
order by attririonRatePecent desc


select MaritalStatus,
count(*) as totalEmployees,
sum(case when attrition ='yes' then 1 else 0 end) as EmployeeWhoLeft,
CAST(100.0 * sum(case when attrition ='yes' then 1 else 0 end)
/count (*) as decimal (5,2)) as attririonRatePecent
from dbo.HR_Analysis_clean
group by MaritalStatus
order by attririonRatePecent desc



---calculate Attrition by department using a CTE
with departmentAttrition as (select 
Department, 
count(*) as TotalEmployees,
sum(case when attrition ='yes' then 1 else 0 end) as EmployeesWhoLeft
from dbo.HR_Analysis_clean
group by Department
)
select 
Department,
TotalEmployees,
EmployeesWhoLeft,
cast(100.0 * EmployeesWhoLeft / 
TotalEmployees as decimal(5,2))
 as attritionRatePercent
from departmentAttrition
 order by attritionRatePercent desc

----window function
with DepartmentAttrition as (
select 
Department,
count(*) as totalEmployees,
sum(case when attrition = 'yes' then 1 else 0 end)
as EmployeesWithLeft
from dbo.HR_Analysis_clean
group by Department),
DepartmentRates as (
select
department,
totalEmployees,
EmployeesWithLeft,
cast(100.0 * EmployeesWithLeft /
totalemployees as decimal(5,2)
) as attritionRatePercent
from DepartmentAttrition
)
select Department,
totalEmployees,
EmployeesWithLeft,
attritionratepercent,
RANK () over (order by attritionratepercent desc) as attritinrank
from DepartmentRates
order by attritinrank

----partition by
with RoleAttrition as (
select 
Department,
JobRole,
COUNT(*) as TotalEmployees,
sum(
case when attrition = 'yes' then 1
else 0 end) as EmployeeWithLeft
from dbo.HR_Analysis_clean
group by Department, JobRole),
RoleRates as (
select
department,
JobRole,
totalemployees,
employeewithleft,
cast(
100.0 * employeewithleft / totalemployees as decimal(5,2)
)as attritionratepercent
from roleattrition
)select 
department,
jobrole,
totalemployees,
employeewithleft,
attritionratepercent,
RANK() over (partition by department 
order by attritionratepercent desc
)as rankwithdepartment
from rolerates
order by department, rankwithdepartment


---ROW_NUMBER
with EmployeeRows as (
select 
Empid,
department,
jobrole,
YearsAtCompany,
YearsWithCurrManager,
row_number ()over (
partition by empid
order by empid)as RowNum,
count(*)over (partition by empid)as idcount
from dbo.HR_Analysis_clean)
select* from EmployeeRows
where idcount >1
order by EmpID,RowNum

---check for impossible manager-tenure values
select 
empid,
department,
jobrole,
YearsAtCompany,
YearsWithCurrManager
from dbo.HR_Analysis_clean
where YearsWithCurrManager> YearsAtCompany

---check for negativer tenure values
select 
empid,
YearsAtCompany,
YearsWithCurrManager
from dbo.HR_Analysis_clean
where YearsWithCurrManager <0 or YearsAtCompany<0

---LAG() 
	SELECT 
	EmpID,
	Department,
	JobRole,
	MonthlyIncome,
	LAG(MonthlyIncome) OVER (
	PARTITION BY DEPARTMENT
	order by MonthlyIncome)as previousSalaryDepartment
	FROM DBO.HR_Analysis_clean
		order by department, MonthlyIncome

	SELECT 
	EmpID,
	Department,
	JobRole,
	MonthlyIncome,
	LAG(MonthlyIncome) OVER (
	PARTITION BY DEPARTMENT
	order by MonthlyIncome)as previousSalary,
	MonthlyIncome-LAG(MonthlyIncome) over 
	( partition by department
	order by MonthlyIncome)as salarydiffrence
	FROM DBO.HR_Analysis_clean
		order by department, MonthlyIncome

----Advanced SQL 
    ------sum() over()
select
EmpID,
Department,
MonthlyIncome,
sum(MonthlyIncome)over (
partition by department
order by MonthlyIncome,empid
rows between unbounded preceding 
and current row
) as runningIncomeTotal
from dbo.HR_Analysis_clean
order by Department, MonthlyIncome, EmpID

---average monthly income
select 
Department,
count(*) as totalEmployees,
cast (AVG(MonthlyIncome)AS decimal(10,2))as averagemonthlyincome,
min(MonthlyIncome) as lowestmonthlyicome,
max(MonthlyIncome) as highestmonthlyincome
from dbo.HR_Analysis_clean
group by Department
order by averagemonthlyincome

----average income by jobrole
select
jobrole,
count(*)as totalemployees,
cast(avg(monthlyIncome) as decimal(10,2))
as averagemontlyincome
from dbo.HR_Analysis_clean
group by JobRole
order by averagemontlyincome desc

----does income differ between employees who leave and those who stay
select 
Attrition, 
count(*) as totalemployees,
cast(AVG(MonthlyIncome)as decimal (10,2))as averagemonthlyincome,
cast(avg(YearsAtCompany)as decimal (10,2))as averageyearsofcompany
from dbo.HR_Analysis_clean
group by Attrition
order by Attrition

----compare attrition by yearsat the company
select
case 
when yearsatcompany < 2 then 'less than 2 years'
when YearsAtCompany < 5 then '2 to 4 years'
when YearsAtCompany < 10 then '5 to 9 years'
else '10+ years'
end as TensureGroup,
count(*) as totalemployees, 
sum(case
when Attrition ='yes' then 1 else 0
end)as employeeswholeft,
cast(100.0 * sum (case when attrition = 'yes' then 1 else 0 end)
/count(*) as decimal(5,2)) as attritionratepercent
from dbo.HR_Analysis_clean
where YearsAtCompany is not null
group by 
case
when yearsatcompany < 2 then 'less than 2 years'
when YearsAtCompany < 5 then '2 to 4 years'
when YearsAtCompany < 10 then '5 to 9 years'
else '10+ years'
 end 
 order by min(YearsAtCompany)


 ----data quality
 select 
 SUM(case when empid is null 
 then 1 else 0 end) as missingEmployeeid,
  sum(case when attrition is null 
 then 1 else 0 end) as missingattrition,
  sum(case when department is null 
 then 1 else 0 end) as missingdepartment,
  sum(case when monthlyincome is null 
 then 1 else 0 end) as missingmonthlyibcome,
  sum(case when yearsatcompany is null 
 then 1 else 0 end) as missingyearsatcompany
 from dbo.HR_Analysis_clean


 ----verify missing record
 select
 EmpID,
 JobRole,
 Department,
 Attrition,
 YearsAtCompany
 from dbo.HR_Analysis_clean
 where YearsAtCompany is null

 select * from HR_Analysis_clean
 where EmpID = 'rm185'

  select * from HR_Analysis$
 where EmpID = 'rm185'


 select 
 count(*) as totalRM185records,
 SUM(case when YearsAtCompany is null 
 then 1 else 0 end) as missingyearsatcompany,
  sum(case when YearsWithCurrManager is null 
 then 1 else 0 end) as missingmanager
 from dbo.HR_Analysis$
 where EmpID= 'rm185'

 SELECT
    COUNT(*) AS TotalRecords,
    COUNT(DISTINCT CONCAT(
        EmpID, '|',
        Age, '|',
        Department, '|',
        JobRole, '|',
        MonthlyIncome, '|',
        YearsAtCompany
    )) AS DistinctRecordPatterns
FROM dbo.[HR_Analysis$]
WHERE EmpID = 'RM185';

SELECT
    EmpID,
    Age,
    Department,
    JobRole,
    MonthlyIncome,
    YearsAtCompany,
    COUNT(*) AS RecordsInPattern
FROM dbo.[HR_Analysis$]
WHERE EmpID = 'RM185'
GROUP BY
    EmpID,
    Age,
    Department,
    JobRole,
    MonthlyIncome,
    YearsAtCompany
ORDER BY RecordsInPattern DESC;


SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT EmpID) AS UniqueEmployeeIDs
FROM dbo.HR_Analysis_clean;

SELECT
    EmpID,
    COUNT(*) AS RecordCount
FROM dbo.HR_Analysis_clean
GROUP BY EmpID
HAVING COUNT(*) > 1
ORDER BY EmpID;

