require 'csv'
require 'pg'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "mass_health")
    yield(connection)
  ensure
    connection.close
  end
end

def to_integer(number)
 delete_comma = number.delete(",")
 integer = delete_comma.to_i
 integer
end

def to_floating(number)

end



def insert_records(town, corrected_numbers)


  record = [
      town['Geography'],
      corrected_numbers[:population],
      corrected_numbers[:age_19_below],
      corrected_numbers[:age_65_up],
      town["Per Capita Income, year 2000"],
      corrected_numbers[:persons_below_200],
      town["% all Persons Living Below 200% Poverty Level, year 2000"],
      town["% adequacy prenatal care (kotelchuck)"],
      town["% C-section deliveries, 2005-2008"],
      corrected_numbers[:infant_deaths],
      town["Infant mortality rate (deaths per 1000 live births), 2005-2008"],
      town["% low birthweight 2005-2008"],
      town["% multiple births, 2005-2008"],
      town["% publicly financed prenatal care, 2005-2008"],
      town["% teen births, 2005-2008"]
  ]


  db_connection do |conn|
    sql = "INSERT INTO town_health_records (geography,
      population,
      pop_19_below,
      pop_65_up,
      per_capita,
      persons_below_200,
      all_persons_below_200,
      adequacy_prenatal,
      c_section_deliveries,
      infant_deaths,
      infant_mortality,
      low_birthweight,
      multiple_births,
      publicaly_financed_prenatal,
      teen_births)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15)"
      conn.exec_params(sql, record)
    end
end
CSV.foreach("mass-chip-data.csv", headers: true) do |row|
  town = row.to_hash

  population = to_integer(town["total pop, year 2005"])
  age_19_below = to_integer(town["age 0-19, year 2005"])
  age_65_up = to_integer(town["age 65+, year 2005"])
  persons_below_200 = to_integer(town["Persons Living Below 200% Poverty, year 2000 "])
  infant_deaths = to_integer(town["Number of infant deaths, 2005-2008"])

  corrected_numbers = { population: population, age_19_below: age_19_below, age_65_up: age_65_up,
    persons_below_200: persons_below_200, infant_deaths: infant_deaths }
  insert_records(town, corrected_numbers)

end


