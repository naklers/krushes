# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

csv_text = File.read("users.csv")
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  user_hash = row.to_hash
  generated_password = Devise.friendly_token.first(8)
  user_hash[:password] = generated_password
  User.create(user_hash)

end


puts "There are now #{User.count} users in the database."
