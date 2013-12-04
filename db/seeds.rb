# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: "Admin", email: "admin@example.com", password: "password", password_confirmation: "password")
User.create!(username: "Alice", email: "alice@example.com", password: "supersafe", password_confirmation: "supersafe")
User.create!(username: "Bob", email: "bob@example.com", password: "abcd1234", password_confirmation: "abcd1234")
User.create!(username: "Eve", email: "eve@example.com", password: "cheaterz", password_confirmation: "cheaterz")

Loan.create!(title: "Cool tractor purchase", business_name: "Kim's Farm Ltd", description: "We want to buy a really big cool-looking tractor.", amount: 5000)
