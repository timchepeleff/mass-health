-- DEFINE YOUR DATABASE SCHEMA HERE


CREATE TABLE town_health_records (
  id serial PRIMARY KEY,
  geography varchar(255),
  population integer,
  pop_19_below integer,
  pop_65_up integer,
  per_capita currency varchar(255),
  persons_below_200 integer,
  all_persons_below_200 varchar(255),
  adequacy_prenatal varchar(255),
  c_section_deliveries varchar(255),
  infant_deaths integer,
  infant_mortality varchar(255),
  low_birthweight varchar(255),
  multiple_births varchar(255),
  publicaly_financed_prenatal varchar(255),
  teen_births varchar(255)
);
