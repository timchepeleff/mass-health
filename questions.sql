-- What 3 towns have the highest population of citizens that are 65 years and older?
SELECT geography,pop_65_up
FROM town_health_records
where geography !=  'Massachusetts Total'
order by pop_65_up desc
limit 3;

-- What 3 towns have the highest population of citizens that are 19 years and younger?
select geography, pop_19_below
from town_health_records
where geography != 'Massachusetts Total'
order by pop_19_below desc
limit 3;

-- What 5 towns have the lowest per capita income?
select geography, per_capita
from town_health_records
order by per_capita
limit 5;

-- Omitting Boston, Becket, and Beverly, what town has the highest percentage of teen births?
select geography, teen_births
from town_health_records
where geography != 'Boston' and geography != 'Becket' and geography != 'Bevery'
and teen_births != 'NA'
order by teen_births desc
limit 1;

-- Omitting Boston, what town has the highest number of infant mortalities?
select geography, infant_mortality
from town_health_records
where geography != 'Boston'
and infant_mortality != 'NA'
order by infant_mortality desc
limit 1;
