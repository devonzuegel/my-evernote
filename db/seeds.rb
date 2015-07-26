# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = CreateAdminService.new.call
user  = User.create(name: 'Devon', email: 'devonzuegel@gmail.com', password: 'password')

10.times do
  Note.create(title: Faker::Lorem.sentence,
              en_updated_at: Faker::Time.between(2.days.ago, Time.now),
              content: Faker::Lorem.paragraph,
              guid: Faker::Lorem.characters(20) )
end