FactoryGirl.define do
  factory :country do
    sequence(:title) {|n| "Country#{n}" }
    sequence(:alpha2) do |n|
      n = if n > 625 then n - (n / 625) * 625 else n end
      "#{('A'..'Z').to_a[n / 25]}#{('A'..'Z').to_a[n % 25]}"
    end
    sequence(:alpha3) do |n|
      n = if n > 625 then n - (n / 625) * 625 else n end
      "C#{('A'..'Z').to_a[n / 25]}#{('A'..'Z').to_a[n % 25]}"
    end
  end
end