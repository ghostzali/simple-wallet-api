# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = User.all

if users.length < 1
  User.create!([
                 {
                   name: "Satu",
                   email: "user1@example.com",
                   password: "Password",
                   password_confirmation: "Password"
                 },
                 {
                   name: "Dua",
                   email: "user2@example.com",
                   password: "Password",
                   password_confirmation: "Password"
                 }
               ])
end