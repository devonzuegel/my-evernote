FactoryGirl.define do
  factory :note do
    guid { Faker::Lorem.characters(20) }
    title { Faker::Lorem.sentence }
  end
end
