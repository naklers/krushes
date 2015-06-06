# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

csv_text = File.read("./users2.csv")
csv = CSV.new(csv_text, :headers => true, :header_converters => :symbol)
csv.each do |row|
  user_hash = row.to_hash
  generated_password = Devise.friendly_token.first(6).downcase.to_s
  user_hash[:password] = generated_password
  user = User.create(user_hash)
  puts("CREATED USER " + user.name.to_s + " with pwd " + user_hash[:password].to_s)
  # Ask mailer to send welcome email as part of the user creation
  UserMailer.welcome_email(user,generated_password).deliver!
end

puts "There are now #{User.count} users in the database."
