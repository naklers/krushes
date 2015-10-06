# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'csv'

csv_input = File.read("./users_seed.csv")
csv = CSV.new(csv_input, :headers => true, :header_converters => :symbol)
csv.each do |row|
  user_hash = row.to_hash
  generated_password = Devise.friendly_token.first(6).downcase.to_s
  user_hash[:password] = generated_password
  user = User.create(user_hash)
  CSV.open("./users_created_" + DateTime.now.strftime("%Y%m%d%H%M") + ".csv", "a") do |csv|
    csv << [user.name.to_s, user.email.to_s, user_hash[:password].to_s]
  end
  puts("CREATED USER " + user.name.to_s + " with pwd " + user_hash[:password].to_s)
  # Ask mailer to send welcome email as part of the user creation
  # DEACTIVATED
  # UserMailer.welcome_email(user,generated_password).deliver!
end

if AdminUser.count == 0
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  CSV.open("./users_created.csv", "wb") do |csv|
      csv << ["admin", "password"]
  end
end

puts "There are now #{User.count} users and #{AdminUser.count} admins in the database."
