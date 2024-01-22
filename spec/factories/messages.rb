FactoryBot.define do
  factory :message do
    body { Faker::Quote.famous_last_words }
    user
    room
  end
end
