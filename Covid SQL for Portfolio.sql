--Selecting all data from table "Covid Deaths".
SELECT 
* 
FROM PortfolioProject.dbo.CovidDeaths; 

--Selecting all data from table "Covid Vacinnations".
SELECT 
* 
FROM PortfolioProject.dbo.CovidVaccinations;

--Selecting the Data that is going to be used specifically.
SELECT
Location,
Date,
Population,
total_cases,
total_deaths
FROM PortfolioProject.dbo.CovidDeaths;

--Show the Covid death perecentage in South Africa from the 2021 to current date.
SELECT 
Location,
Date,
Population,
total_cases,
total_deaths,
DeathPercentage = (CAST(total_deaths AS FLOAT) / CAST(total_cases AS FLOAT)) * 100
FROM PortfolioProject.dbo.CovidDeaths
WHERE Location = 'South Africa'
AND
Date BETWEEN 2021-01-01 AND getdate()
AND total_cases IS NOT NULL
ORDER BY DeathPercentage DESC;

--Show the country with the most Covid cases percentage in 2023 as per the Population.
SELECT
Location,
Date,
total_cases,
Highest_Death_Percentage = MAX(CONVERT(FLOAT, total_cases) / CONVERT(FLOAT, Population)*100)
FROM PortfolioProject.dbo.CovidDeaths
GROUP BY Location, 
		 Date,
		 total_cases
ORDER BY Highest_Death_Percentage DESC;

--Joining the Covid table and Vaccincation table
SELECT
dea.location,
dea.date,
dea.total_cases,
dea.total_deaths,
vac.total_tests,
vac.people_vaccinated
FROM PortfolioProject.dbo.CovidDeaths dea
JOIN PortfolioProject.dbo.CovidVaccinations vac
ON dea.location = vac.location
WHERE vac.people_vaccinated IS NOT NULL


--Selecting the average percentage of South Africa's population that have been vaccinated.

SELECT 
dea.date,
dea.location,
vac.total_vaccinations,
Vaccinated_People_Percentage = AVG(CAST(total_vaccinations as float) / CAST(population as float) * 100)
FROM PortfolioProject.dbo.CovidDeaths dea
JOIN PortfolioProject.dbo.CovidVaccinations vac
ON dea.location = vac.location
WHERE dea.location = 'South Africa' AND vac.total_vaccinations IS NOT NULL
GROUP BY dea.date, 
		 dea.location,
		 vac.total_vaccinations
ORDER BY 3 DESC


