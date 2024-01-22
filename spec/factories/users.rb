FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'AAaa11..' }
  end
end
