FactoryGirl.define do
  factory :flight do
    sequence(:code) {|n| "UN #{100 + n}" }
    depart_date  (Time.zone.today + 1.days)
    depart_time '10:00'
    arrive_time '12:00'
    seats_status 'yes'
    association :depart_airport, factory: :airport
    association :arrive_airport, factory: :airport
  end
end