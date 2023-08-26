# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


user_count = 3

users = []
user_count.times do |i|
    user = User.find_or_create_by(name: "sample#{i+1}",email: "sample#{i+1}@example.com")
    user.password = "sample#{i+1}"
    user.save
    users << user
end

user_count.times do |i|
  secret_phrase = SecretPhrase.find_or_create_by(user_id: users[i].id)
  secret_phrase.password = "secret#{i+1}"
  secret_phrase.save

  ApprovedUser.find_or_create_by(
    user_id: users[i].id,
    approved_user_id: users[i-1].id
  )

  ApprovedUser.find_or_create_by(
    user_id: users[i].id,
    approved_user_id: users[i-2].id
  )
end

puts "#{user_count} posts have been created!"
