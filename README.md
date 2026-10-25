HR Employee Attrition Analysis
1.	Project Overview
This project analyzes employee attrition using SQL Server to identify workforce patterns and explore factors associated with employees leaving an organization.
The analysis examines attrition across departments, job roles, overtime status, age groups, salary levels, job satisfaction, business travel, marital status, and employee tenure.
The goal is to demonstrate practical SQL skills, data-quality validation, exploratory data analysis, and the ability to turn query results into useful business insights.
2.	Project Objectives
•	Analyze employee attrition rates across different workforce groups.
•	identify departments and job roles with higher observed attrition.
•	Explore the relationship between overtime, job satisfaction, salary, tenure, and attrition.
•	Check for missing values, repeated employee IDs, and inconsistent data.
•	Apply basic and advanced SQL techniques to answer business questions.
•	Provide recommendations to support further HR investigation.
3.	Tools and Technologies
•	Microsoft SQL Server
•	SQL Server Management Studio (SSMS)
•	SQL
4.	Dataset Description
The dataset contains employee information, including:
•	Employee ID
•	Age and age group
•	Department and job role
•	Attrition status
•	Gender
•	Business travel
•	Overtime
•	Job satisfaction
•	Monthly income and salary slab
•	Years at company
•	Years with current manager

Working table: dbo.HR_Analysis_clean
Dataset summary:
•	Total records: 1,474
•	Distinct employee IDs: 1,470
The difference between these figures indicates that some employee IDs appear more than once. This is documented as a data-quality limitation.
5.	Data Cleaning and Quality Checks
•	The SQL workflow included:
•	Comparing raw and cleaned record counts.
•	Checking total records and distinct employee IDs.
•	Identifying repeated employee IDs.
•	Inspecting repeated records for missing or conflicting values.
•	Checking missing values across multiple columns.
•	Identifying potentially invalid tenure values.
•	Checking whether years with the current manager exceed years at the company.
•	Standardizing business-travel category labels.
•	Validating the cleaned table before analysis.
The cleaning process excluded rows where five specified fields were all NULL: Department, Gender, DailyRate, DistanceFromHome, and Education.
This condition does not remove every record containing missing values. Some repeated employee IDs and incomplete or conflicting records remain and require further verification.
6.	SQL Analysis Performed
	Workforce Overview
Analyzed employee records by:
•	Department
•	Job role
•	Gender
•	Age group
•	Salary slab
•	Attrition status
	 Attrition Analysis

Calculated employee counts and attrition rates by:
•	Department
•	Overtime status
•	Job role
•	Job satisfaction
•	Age group
•	Salary slab
•	Business travel
•	Marital status
•	Tenure group
	C. Compensation Analysis
•	Compared average monthly income by department.
•	Compared average monthly income by job role.
•	Compared average monthly income and average years at the company for employees who stayed and employees who left.
	Advanced SQL Techniques
•	The project demonstrates:
•	Common Table Expressions (CTEs)
•	Aggregate functions such as COUNT(), SUM(), and AVG()
•	Conditional logic using CASE
•	Ranking with RANK()
•	Window functions using OVER() and PARTITION BY
•	Duplicate investigation using ROW_NUMBER() and COUNT() OVER()
•	Previous-row comparisons using LAG()
•	Running totals using SUM() OVER()
•	Grouping, sorting, and filtering data
The LAG() and running-total queries demonstrate window-function techniques. They do not represent historical salary changes because the data is not being analyzed as a salary time series.
7.	Key Findings
The following findings are based on the current cleaned working table. Because repeated employee IDs remain, the rates should be treated as record-based results until the data is fully validated.
Overall Attrition
•	237 records are marked as attrition.
•	The overall recorded attrition rate is approximately 16.08%.
Attrition by Department
•	Sales: 20.58%
•	Human Resources: 19.05%
•	Research and Development: 13.80%
	Sales has the highest observed department-level attrition rate.
Attrition by Overtime
•	Overtime: Yes — 30.53%
•	Overtime: No — 10.40%
Records marked as working overtime have a higher observed attrition rate.
Attrition by Job Role
•	Sales Representative: 39.29%
•	Laboratory Technician: 23.85%
•	Human Resources: 23.08%
Sales Representatives have the highest observed attrition rate among the listed job roles.
Attrition by Age Group
•	Age 18–25: 35.77%
•	Age 26–35: 19.11%
•	Age 55+: 17.02%
•	Age 46–55: 11.45%
•	Age 36–45: 9.15%
The 18–25 age group has the highest observed attrition rate.
Attrition by Salary Slab
•	Up to 5k: 21.68%
•	5k–10k: 11.11%
•	10k–15k: 13.51%
•	15k+: 3.76%
The lowest salary slab has the highest observed attrition rate, while the highest salary slab has the lowest.
Attrition by Job Satisfaction
•	Satisfaction score 1: 22.68%
•	Satisfaction score 2: 16.43%
•	Satisfaction score 3: 16.48%
•	Satisfaction score 4: 11.30%
Records with the lowest job-satisfaction score have the highest observed attrition rate.
Attrition by Tenure
•	Less than 2 years: 34.88%
•	2–4 years: 18.03%
•	5–9 years: 11.03%
•	10 or more years: 10.38%
Records for employees with less than two years at the company have the highest observed attrition rate among these tenure groups.
8.	Recommendations
Based on these descriptive findings, the organization could consider:
1. Investigating workload, scheduling, and employee feedback among staff working overtime.
2. Reviewing onboarding, training, and manager support for newer employees.
3. Exploring retention challenges among Sales Representatives and within the Sales department.
4. Reviewing compensation and career-development opportunities across salary levels and job roles.
5. Gathering feedback from employees with low job-satisfaction scores.
6. Validating repeated employee IDs and resolving conflicting records before making employee-level decisions.
7. Monitoring attrition over time using reliable employee records and dated historical data.
These recommendations suggest areas for further investigation. The analysis does not establish that any individual factor causes employees to leave.
9.	Data Limitations
* The working table contains 1,474 records and 1,470 distinct employee IDs.
* Some employee IDs appear more than once.
* Some repeated records contain incomplete or conflicting values.
* The cleaning condition does not remove all records with missing values.
* Results may change after repeated records are investigated and resolved.
* The analysis identifies associations, not causal relationships.
* The window-function examples are analytical exercises and do not establish historical salary trends.
These limitations are documented to support transparent and responsible interpretation of the results.
10.	Repository Structure
HR-Employee-Attrition-Analysis/
├── HR_Employee_Attrition_Analysis_Final.sql
├── README.md
└── screenshots/
11.	How to Run the Project
1. Open Microsoft SQL Server Management Studio.
2. Connect to the SQL Server instance containing the project tables.
3. Open HR_Employee_Attrition_Analysis_Final.sql.
4. Confirm that the table names match your database.
5. Run the queries section by section.
6. Review the output and data-quality checks.
12.	Conclusion
This project demonstrates the use of SQL to validate HR data, investigate employee attrition, compare workforce groups, and identify patterns that may support HR decision-making.
It combines data-quality checks, descriptive analysis, and advanced SQL techniques while documenting the limitations that affect interpretation.
The project represents a practical application of SQL for data analysis and business problem-solving.
