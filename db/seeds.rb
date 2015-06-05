# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

user_hashes = [
  { :name => "Ignacio Naveiras", :email => "inaveiras2015@kellogg.northwestern.edu"  },
  { :name => "Andrea Beer", :email => "asilvabeer2015@kellogg.northwestern.edu" },
  { :name => "Santi Otaola", :email => "sotaolaarca2015@kellogg.northwestern.edu" },
  { :name => "Emily Gipple", :email => "egipple2015@kellogg.northwestern.edu" },
  { :name => "Paloma Ishii", :email => "pishii2015@kellogg.northwestern.edu" },
  { :name => "Pedro Haces", :email => "phaces2016@kellogg.northwestern.edu" },
  { :name => "Pablo Jaramillo", :email => "pjaramillo2016@kellogg.northwestern.edu" },
  { :name => "Eyal Klein", :email => "eklein2015@kellogg.northwestern.edu" },
  { :name => "Jason Yeh", :email => "jyeh2015@kellogg.northwestern.edu" },
  { :name => "Anja Zhao", :email => "azhao2015@kellogg.northwestern.edu" }
]

csv_text = File.read("users.csv")
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  user_hash = row.to_hash
  generated_password = Devise.friendly_token.first(8)
  user_hash[:password] = generated_password
  User.create(user_hash)

end


puts "There are now #{User.count} users in the database."
