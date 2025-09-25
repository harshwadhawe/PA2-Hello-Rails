# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Movie.destroy_all

Movie.create!([
  { title: "The Godfather", rating: "R", release_date: Date.new(1972, 3, 24),
    description: "Mafia family saga." },
  { title: "Toy Story", rating: "G", release_date: Date.new(1995, 11, 22),
    description: "Toys come to life." },
  { title: "Inception", rating: "PG-13", release_date: Date.new(2010, 7, 16),
    description: "Dream within a dream." }
])

puts "Seeded #{Movie.count} movies."
