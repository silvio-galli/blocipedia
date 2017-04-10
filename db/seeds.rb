# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
5.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  domain = Faker::Internet.domain_name
  user = User.create!(
    user_name:          "#{first_name} #{last_name}",
    email:              "#{first_name}.#{last_name}@#{domain}",
    password:           Faker::Internet.password(8),
    confirmation_token: Faker::Internet.password(20),
    confirmed_at:       Faker::Time.between(DateTime.now - 2, DateTime.now)
  )
end

member = User.create!(
  user_name:          "Member User",
  email:              "member@example.com",
  password:           "password",
  confirmation_token: "UULUxBpinJyT7Yy8PEJK",
  confirmed_at:       "2016-03-11 17:01:47"
)

me = User.create!(
  user_name:          "Fake",
  email:              "fakeuser@example.com",
  password:           "password",
  confirmation_token: "nUL2xBpinJyT7Yy8PEJK",
  confirmed_at:       "2016-03-12 17:01:47"
)

users = User.all


50.times do
  wiki = Wiki.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(5, true, 10)
  )
end

md_wiki = Wiki.create!(
  user: User.last,
  title: "Markdown Wiki",
  body: "# This is a h1 title\n## this is a h2 title\nthis is a list\n* item\n* item\n* item\n``` this is code```"
)

puts "Seed finished!"
puts "Blocipedia was populated with #{User.count} new users."
puts "Blocipedia was populated with #{Wiki.count} new wikis."
