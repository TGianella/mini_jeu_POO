class Game
  attr_accessor :human_player, :players_left, :enemies_in_sight, :enemies_killed

  def initialize(name, nb_enemies)
    self.human_player = HumanPlayer.new(name)
    self.enemies_in_sight = []
    self.players_left = nb_enemies
    self.enemies_killed = 0
  end

  def kill_player(player)
    self.enemies_in_sight.delete(player)
    self.enemies_killed += 1
  end

  def is_still_ongoing?
    human_player.is_alive? && players_left > 0
  end

  def new_players_in_sight
    if enemies_in_sight.count == players_left
      puts "Tous les ennemis sont déjà en vue."
    else
      res = rand(1..6)
      case res
      when 1
        puts "Aucun nouvel ennemi en vue."
      when 2..4
        self.enemies_in_sight << Player.new("enemy_#{rand(1000..9999)}")
        puts "#{enemies_in_sight.last.name} entre dans ton champ de vision !"
      when 5..6
        2.times do |_| 
          self.enemies_in_sight << Player.new("enemy_#{rand(1000..9999)}") 
          puts "#{enemies_in_sight.last.name} entre dans ton champ de vision !"
        end
      end
    end
    puts
  end

  def show_players
    human_player.show_state
    puts "Il reste #{players_left} ennemis !"
    puts
  end

  def menu
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts
    puts "attaquer un joueur en vie :"
    enemies_in_sight.each_with_index do |enemy, number|
      print number.to_s + " -"
      enemy.show_state
    end
  end

  def menu_choice(user_choice)
    case user_choice
    when "a"
      self.human_player.search_weapon
    when 's'
      self.human_player.search_health_pack
    else
      enemy = self.enemies_in_sight[user_choice.to_i]
      human_player.attacks(enemy)
      kill_player(enemy) unless enemy.is_alive?
    end
    puts
  end

  def enemies_attack
    enemies_in_sight.each { |enemy| enemy.attacks(self.human_player) if human_player.is_alive? }
    puts
  end

  def ending
    puts "Le jeu est fini"
    human_player.is_alive? ? puts("Bravo, tu es le vainqueur") : puts("Tu as perdu ! (#{enemies_killed} ennemis tués)")
  end
end

