select sum(one_hour_precip) from raw_weather_data where wsid = '725030:14732' and year = 2008 and month = 3 and day = 19;
select sum(one_hour_precip) from raw_weather_data where wsid = '725030:14732' and year = 2008 and month = 3;
select sum(one_hour_precip) from raw_weather_data where wsid = '725030:14732' and year = 2008;
select sum(one_hour_precip) from raw_weather_data where wsid = '725030:14732';

select min(temperature), max(temperature), avg(temperature), count(temperature) from raw_weather_data where wsid = '725030:14732' and year = 2008 and month = 12 and day = 29;
select min(temperature), max(temperature), avg(temperature), count(temperature) from raw_weather_data where wsid = '725030:14732' and year = 2008 and month = 12;
select min(temperature), max(temperature), avg(temperature), count(temperature) from raw_weather_data where wsid = '725030:14732' and year = 2008;
select min(temperature), max(temperature), avg(temperature), count(temperature) from raw_weather_data where wsid = '725030:14732';

CREATE FUNCTION threeIncreases(lastThree list<int>, next int)
CALLED ON NULL INPUT
RETURNS int LANGUAGE java AS
'if (current == null) return candidate; else return Math.max(current, candidate);' ;

CREATE AGGREGATE maxAgg(int)
SFUNC threeIncreases
STYPE set<int>
INITCOND ;


