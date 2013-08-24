FactoryGirl.define do
  factory :airport do
    sequence(:title) {|n| "Аэропорт#{n}" }
    sequence(:iata) do |n|
      n = if n > 600 then n - (n / 600) * 600 else n end
      #n = n % 600
      "A#{('A'..'Z').to_a[n / 25 - 1]}#{('A'..'Z').to_a[n % 25]}"
    end
    city
  end
end