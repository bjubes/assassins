# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


(1..51).each do |i|
  user = User.new
  user.email = "#{i}@gmail.com"
  user.username = "my_username_#{i}"
  user.password = "123456"
  user.password_confirmation = "123456"
  user.save!
end

game = Game.new
game.name = "game_name"
game.owner = User.find 51
game.save!

(1..25).each do |i|
  team = Team.new
  team.name = "TEAM_#{i}"
  team.game = game
  team.save!
end

(1..50).each do |i|
  user = User.find(i)
  user.team_id = (1 + (i-1)/2)
  user.save!
end

(1..25).each do |i|
  team = Team.find(i)
  team.target_id = (i+1)%26
  team.target_id = 1 if team.target_id == 0
  team.assassin_id = (i-1) unless i == 1
  team.save!
end
#compelete target loop
Team.first.update(assassin_id: 25)

#request some kills
#choose 10 random teams
(1..25).to_a.shuffle.each do |i|
  killer = Team.find(i).users.first
  target = killer.team.target
  victim_id = target.users.first.id
  killer_id = killer.id

  k = KillConfirmation.new_without_kill({killer_id: killer_id, victim_id: victim_id})
  if i % 2 == 0
    k.accept
  end
  k.save!

end
