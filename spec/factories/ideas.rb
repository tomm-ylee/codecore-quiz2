FactoryBot.define do
  factory :idea do
    title Faker::Simpsons.location
    description Faker::Simpsons.quote
    association(:user) { FactoryBot.create(:user) }
  end
end
