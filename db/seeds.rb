# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
countries = Country.create(
  [
    { title: 'Russia', alpha2: 'RU', alpha3: 'RUS' },
    { title: 'Turkey', alpha2: 'TR', alpha3: 'TUR' }
  ]
)
cities= City.create(
  [
    { title: 'Moscow', iata: 'MOW', country: countries.find {|country| country.alpha2 == 'RU'} },
    { title: 'Istanbul', iata: 'IST', country: countries.find {|country| country.alpha2 == 'TR'} },
  ]
)
airports = Airport.create(
  [
    { title: 'Vnukovo', iata: 'VKO', city: cities.find {|city| city.iata == 'MOW'} },
    { title: 'Istanbul', iata: 'IST', city: cities.find {|city| city.iata == 'IST'} },
  ]
)
flights = Flight.create(
  [
    {depart_airport: airports[0], arrive_airport: airports[1], code: 'SU 100', 
     depart_date: '2014-01-01', depart_time: '06:00:00', arrive_time: '09:00:00', seats_status: 'yes'},
    {depart_airport: airports[0], arrive_airport: airports[1], code: 'SU 100',   
     depart_date: '2014-01-02', depart_time: '06:00:00', arrive_time: '09:00:00', seats_status: 'yes'},
    {depart_airport: airports[0], arrive_airport: airports[1], code: 'SU 100',   
     depart_date: '2014-01-03', depart_time: '06:00:00', arrive_time: '09:00:00', seats_status: 'yes'},
    {depart_airport: airports[0], arrive_airport: airports[1], code: 'UN 200',   
     depart_date: '2014-01-04', depart_time: '07:00:00', arrive_time: '10:00:00', seats_status: 'few'},
    {depart_airport: airports[0], arrive_airport: airports[1], code: 'UN 200',   
     depart_date: '2014-01-05', depart_time: '07:00:00', arrive_time: '10:00:00', seats_status: 'no'},

    {depart_airport: airports[0], arrive_airport: airports[1], code: 'SU 101', 
     depart_date: '2014-01-01', depart_time: '10:00:00', arrive_time: '13:00:00', seats_status: 'yes'},
    {depart_airport: airports[0], arrive_airport: airports[1], code: 'SU 101',   
     depart_date: '2014-01-02', depart_time: '10:00:00', arrive_time: '13:00:00', seats_status: 'few'},
    {depart_airport: airports[0], arrive_airport: airports[1], code: 'SU 101',   
     depart_date: '2014-01-03', depart_time: '10:00:00', arrive_time: '13:00:00', seats_status: 'yes'},
    {depart_airport: airports[0], arrive_airport: airports[1], code: 'UN 201',   
     depart_date: '2014-01-04', depart_time: '10:00:00', arrive_time: '13:00:00', seats_status: 'no'},
    {depart_airport: airports[0], arrive_airport: airports[1], code: 'UN 201',   
     depart_date: '2014-01-05', depart_time: '10:00:00', arrive_time: '13:00:00', seats_status: 'few'},
  ]
)
