# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
# <Match id: 1, winner: "Adam", loser: "Bob", created_at: "2011-07-08 00:21:06", updated_at: "2011-07-08 00:21:06", occured_at: "2011-07-07 20:20:59">
#
@players = [ Player.create(name: "Alice"),
             Player.create(name: "Bob"),
             Player.create(name: "Carol"),
             Player.create(name: "Dave"),
             Player.create(name: "Eve"),
             Player.create(name: "Mallory"),
             Player.create(name: "Peggy")
           ]

def rand_match(time)
  player_one = @players[rand(@players.size)]
  player_two = @players[rand(@players.size)]
  while player_one == player_two 
    player_two = @players[rand(@players.size)]
  end
  Match.create(winner: player_one, loser: player_two, occured_at: time)
end

# Make up two weeks worth of matches to play around with.
14.downto(0) do |i|
  8.times { rand_match( Time.now - i.days ) }
end

