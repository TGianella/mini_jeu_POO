class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end
  
  def show_state
    puts "#{name} a #{life_points} points de vie."
  end

  def gets_damage(damage)
    self.life_points -= damage
    if life_points <= 0
      puts "Le joueur #{name} a été tué !"
      self.life_points = 0
    end      
  end

  def attacks(target)
    puts "Le joueur #{name} attaque le joueur #{target.name} !"
    damage = compute_damage
    puts "Il lui inflige #{damage} points de dommages !"
    target.gets_damage(damage)
  end

  def compute_damage
    rand(1..6)
  end

  def is_alive?
    life_points > 0
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    super(name)
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    puts "#{name} a #{life_points} points de vie et une arme de niveau #{weapon_level}"
  end

  def compute_damage
    rand(1..6) * weapon_level
  end
  
  def search_weapon
    new_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_level} !"
    if new_level > weapon_level
      self.weapon_level = new_level
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else
      puts "Merde... elle ne vaut pas mieux que ton arme actuelle."
    end
  end

  def search_health_pack
    res = rand(1..6)
    case res
    when 1
      puts "Tu n'as rien trouvé..."
    when 2..5
      life_points <= 50 ? self.life_points += 50 : self.life_points = 100
      puts "Bravo, tu as trouvé un pack de 50 points de vie !"
    when 6
      life_points <= 20 ? self.life_points += 80 : self.life_points = 100
      puts "INCROYABLE !! Tu as trouvé un pack de 80 points de vie !"
    end
  end
end
      
