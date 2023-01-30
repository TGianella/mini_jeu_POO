require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "Bienvenue dans ILS VEULENT TOUS MA POO !"
puts "Le but du jeu est d'être le dernier survivant !"
puts
puts "Quel est ton nom, combattant.e ?"
user_name = gets.chomp
puts "Combien d'ennemis veux-tu combattre ?"
nb_enemies = gets.chomp.to_i
puts
my_game = Game.new(user_name, nb_enemies)
while my_game.is_still_ongoing?
  my_game.show_players
  my_game.new_players_in_sight
  my_game.menu
  my_game.menu_choice(gets.chomp)
  my_game.enemies_attack
end
my_game.ending

