require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "Bienvenue dans ILS VEULENT TOUS MA POO !"
puts "Le but du jeu est d'être le dernier survivant !"
puts
puts "Quel est ton nom, combattant.e ?"
player1 = HumanPlayer.new(gets.chomp)
enemies = []
enemies << Player.new("Josiane")
enemies << Player.new("José")
puts
while player1.is_alive? && enemies.any?(&:is_alive?)
  player1.show_state
  puts
  puts "Quelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"
  puts
  puts "attaquer un joueur en vie :"
  enemies.each_with_index do |enemy, number|
    print number.to_s + " -"
    enemy.show_state
  end
  input = gets.chomp
  puts
  case input
  when "a"
    player1.search_weapon
  when 's'
    player1.search_health_pack
  when '0'
    player1.attacks(enemies[0])
  when '1'
    player1.attacks(enemies[1])
  end
  puts
  if enemies.any?(&:is_alive?)
    puts "Les autres joueurs t'attaquent !"
    enemies.each { |enemy| enemy.attacks(player1) if enemy.is_alive? }
  end
end
puts "La partie est finie !"
if player1.is_alive?
  puts "BRAVO ! TU ES LE VAINQUEUR !"
else
  puts "C'est perdu !"
end

