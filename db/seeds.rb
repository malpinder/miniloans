# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: "Admin", is_admin: true, email: "admin@example.com", password: "password", password_confirmation: "password")
alice = User.create!(username: "Alice", email: "alice@example.com", password: "supersafe", password_confirmation: "supersafe")
bob   = User.create!(username: "Bob", email: "bob@example.com", password: "abcd1234", password_confirmation: "abcd1234")
eve   = User.create!(username: "Eve", email: "eve@example.com", password: "cheaterz", password_confirmation: "cheaterz")

tractor = Loan.create!(title: "Cool tractor purchase", business_name: "Kim's Farm Ltd", description: "We want to buy a really big cool-looking tractor.", amount: 5000)
cakes = Loan.create!(title: "Cream cakes purchase", business_name: "Tasty Treats Inc", description: "Creams cakes are delicious and we want to buy a lot of them", amount: 1200)

Bid.create!(loan: tractor, user: alice, amount: 500)
Bid.create!(loan: tractor, user: bob, amount: 100)
Bid.create!(loan: tractor, user: eve, amount: 1000)
Bid.create!(loan: cakes, user: eve, amount: 800)

Comment.create!(user: alice, loan: tractor, text: "I hope you get the tractor soon!")

comment = Comment.create!(user: eve, loan: tractor, text: "What if the tractor breaks?")
Comment.create!(user: alice, parent: comment, text: "I'm sure they'll manage.")

Comment.create!(user: eve, loan: cakes, text: "Cakes are delicious.")

sweary = Comment.create!(user: bob, loan: cakes, text: "Sounds like a #*&!ing terrible idea.")
Comment.create!(user: alice, parent: sweary, text: "I say, I don't think that's appropriate language!")
