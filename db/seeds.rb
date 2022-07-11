# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "aono", email: "aono0321@yahoo.co.jp", password: "aaa", admin: true)
counter = 0
10.times do
  p Label.create!(name: "project#{counter}")
  counter += 1
end

counter = 0
10.times do
  user = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: "aaa")
  10.times do
    task =Task.create!(title: counter, user_id: user.id, priority: rand(1..3), deadline: Faker::Date.birthday(min_age: 18, max_age: 65))
    task.groups.create!(label_id: rand(1..10))
  end
  counter += 1
end
