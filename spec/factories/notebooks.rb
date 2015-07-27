FactoryGirl.define do
  factory :notebook do
    guid { Faker::Lorem.characters(20) }
    name { Faker::Lorem.sentence }
    en_created_at { Faker::Time.between(20.days.ago, 10.days.ago) }
    en_updated_at { Faker::Time.between(10.days.ago, 1.day.ago) }
  end
end
