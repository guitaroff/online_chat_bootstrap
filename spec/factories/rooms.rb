FactoryBot.define do
  factory :room do
    title { Faker::Alphanumeric.alpha(number: 10) }
    user { create(:user) }
  end
end
