# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_hashes = [
  { :name => "Ignacio Naveiras", :email => "inaveiras2015@kellogg.northwestern.edu", :password => "12341234"  },
  { :name => "Andrea Beer", :email => "asilvabeer2015@kellogg.northwestern.edu", :password => "12341234" },
  { :name => "Santi Otaola", :email => "sotaolaarca2015@kellogg.northwestern.edu", :password => "12341234" },
  { :name => "Emily Gipple", :email => "egipple2015@kellogg.northwestern.edu", :password => "12341234" },
  { :name => "Paloma Ishii", :email => "pishii2015@kellogg.northwestern.edu", :password => "12341234" },
  { :name => "Pedro Haces", :email => "phaces2016@kellogg.northwestern.edu", :password => "12341234" },
  { :name => "Pablo Jaramillo", :email => "pjaramillo2016@kellogg.northwestern.edu", :password => "12341234" },
  { :name => "Eyal Klein", :email => "eklein2015@kellogg.northwestern.edu", :password => "12341234" },
  { :name => "Jason Yeh", :email => "jyeh2015@kellogg.northwestern.edu", :password => "12341234" }
]

user_hashes.each do |user_hash|
  User.create(user_hash)
end

puts "There are now #{User.count} users in the database."
