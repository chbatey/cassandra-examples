select sum(one_hour_precip) from raw_weather_data where wsid = '725030:14732' and year = 2008 and month = 3 and day = 19;

select min(temperature), max(temperature), avg(temperature), sum(temperature) from raw_weather_data where wsid = '725030:14732' and year = 2008 and month = 12 and day = 29;
