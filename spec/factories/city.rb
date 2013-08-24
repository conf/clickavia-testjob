FactoryGirl.define do
  factory :city do
    sequence(:title) {|n| "Город#{n}" }
    sequence(:iata) do |n|
      n = if n > 600 then n - (n / 600) * 600 else n end
      "C#{('A'..'Z').to_a[n / 25 - 1]}#{('A'..'Z').to_a[n % 25]}"
    end
    country
  end
end