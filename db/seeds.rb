# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Review.all.destroy_all
Idea.all.destroy_all
User.all.destroy_all

User.create(
  first_name: 'Admin',
  last_name: 'User',
  email: 'admin@email.com',
  is_admin: true
)

5.times do
  first_name = Faker::Name.first_name
  last_name =  Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}_#{last_name}@email.com"
  )
end

20.times do
  i = Idea.create(
    title: Faker::Simpsons.location,
    description: Faker::Simpsons.quote,
    user: User.all.sample
  )

  5.times do
    Review.create(
      comment: Faker::HarryPotter.quote,
      idea: i,
      user: User.all.sample
    )
  end
end

puts "Seeded #{User.count} users, #{Idea.count} ideas, and #{Review.count} reviews."
