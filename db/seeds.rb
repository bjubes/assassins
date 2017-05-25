# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..50).each do |i|
  user = User.new
  user.email = "#{i}@gmail.com"
  user.username = "my_username_#{i}"
  user.password = "123456"
  user.password_confirmation = "123456"
  user.save!
end
(1..25).each do |i|
  Team.create(name: "TEAM_#{i}")
end

(1..50).each do |i|
  user = User.find(i)
  user.team_id = (1 + (i-1)/2)
  user.save!
end

(1..25).each do |i|
  team = Team.find(i)
  team.target_id = (i+1)%25
  team.assassin_id = (i-1) unless i == 1
  team.save!
end
#compelete target loop
Team.first.update(assassin_id: 25)
