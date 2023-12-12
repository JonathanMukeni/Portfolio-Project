Select *
From [Portfolio project]..CovidDeaths$
order by 3,4
Select *
From [Portfolio project]..CovidVaccinations$
order by 3,4
Select Location, date, total_cases, new_cases, total_deaths, population
From [Portfolio project]..CovidDeaths$
order by 1,2

--Looking at total cases VS total deaths
-- shows the liklihood of dying if you contract covid in your country

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio project]..CovidDeaths$
Where location like '%states%'
order by 1,2


--Looking at the Toatl Cases VS the Population
--Shows what percentage of the population has contracted covid

Select Location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths$
--Where location like '%states%'
order by 1,2


--Looking at countries witht he highest infection rate compared to population

Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths$
--Where location like '%states%'
Group by Location, population
order by PercentPopulationInfected desc

--Countries with the highest death count per population

Select Location, MAX(cast(Total_deaths as int))as TotalDeathCount
From [Portfolio project]..CovidDeaths$
--Where location like '%states%'
Where continent is not null
Group by Location
order by TotalDeathCount desc


--Let's break things down by continent
--Showing the continents with the highest death count population

Select continent, MAX(cast(Total_deaths as int))as TotalDeathCount
From [Portfolio project]..CovidDeaths$
--Where location like '%states%'
Where continent is not null
Group by continent
order by TotalDeathCount desc


--Global numbers

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int))as total_deaths, SUM(cast(new_deaths as int))/ SUM(new_cases)*100 as DeathPercentage
From [Portfolio project]..CovidDeaths$
--Where location like '%states%'
Where continent is not null
--Group by date
order by 1,2

-- Looking at total population VS vaccinations

Select dea.continent, dea.location, dea.date, dea.population, dea.new_vaccinations
     , SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location)
From [Portfolio project]..CovidDeaths$ dea
Join [Portfolio project]..CovidVaccinations$ vac
     On dea.location = vac.location
	 and dea.date = vac.date
	 Where dea.continent is not null
	 order by 2,3

 
	  --Temp Table



	 --USE CTE

	 With PopvsVac (Continent,Location, Date, Population, RollingPeopleVaccinated