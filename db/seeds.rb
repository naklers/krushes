# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'csv'

if User.count == 0
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
end

if AdminUser.count == 0
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  CSV.open("./users_created.csv", "wb") do |csv|
    csv << ["admin", "password"]
  end
  puts "There are now #{User.count} users and #{AdminUser.count} admins in the database."
end

if Match.count == 0
  # Go through all matched choices not yet with a match id
  Choice.where({:matched => true, :match_id => nil,}).each do |matching_choice|
    #Find the matching choice
    other_matching_choice = Choice.where({:user_id => matching_choice.target_id, :target_id => matching_choice.user_id, :matched => true})
    #Create match
    match = Match.create!(user1_id: matching_choice.user_id, user2_id: matching_choice.target_id, user1_choice: matching_choice.id, user2_choice: matching_choice.id, user1_active: true, user2_active: true)
    #Update both choices with their match id
    matching_choice.match_id = match.id
    matching_choice.save
    other_matching_choice.match_id = match.id
    other_matching_choice.save
  end
end
