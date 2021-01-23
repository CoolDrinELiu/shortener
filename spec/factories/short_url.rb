FactoryBot.define do
  factory :short_url do
    target_url { Faker::Internet.url }
  end
end