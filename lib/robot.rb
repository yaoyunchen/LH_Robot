require_relative 'movement'
require_relative 'item'
require_relative 'weapon'
require_relative 'box_of_bolts'
require_relative 'battery'


class Robot
  include Movement

  attr_reader :position, :items, :attack_points, :auto_heal, :shields
  attr_accessor :equipped_weapon, :health 

  MAX_CAPACITY = 250
  MAX_HEALTH = 100
  MAX_SHIELDS = 50
  DEFAULT_ATTACK = 5

  def initialize
    @position = [0,0]

    @items = []

    @health = MAX_HEALTH
    @shields = MAX_SHIELDS
    @attack_points = DEFAULT_ATTACK

    @equipped_weapon
  end

  def over_max_weight?
    items_weight >= MAX_CAPACITY
  end

  def pick_up(item)
    auto_heal?(item) ? item.feed(self) : add_to_inventory(item) unless over_max_weight?
  end

  def auto_heal?(item)
    (health <= MAX_HEALTH - BoxOfBolts::HEAL_AMOUNT) && item.is_a?(BoxOfBolts)
  end

  # def auto_recharge?(item)
  #   (shields <= MAX_SHIELDS - Battery::HEAL_AMOUNT) && item.is_a?(Battery)
  # end


  def add_to_inventory(item)
    @items << item
    equip(item)
    items_weight
  end

  def items_weight
    return items.inject(0) {|item_weight, item| item_weight + item.weight}
  end

  def equip(item)
    @equipped_weapon = item if item.is_a?(Weapon)
  end

  
  def wound(damage)
    if shields > 0
      drain_shields(damage)
    else
      drain_health(damage)
    end  
  end
  
  def drain_shields(damage)
    @shields -= damage
    if shields < 0
      drain_health(@shields.abs)
      @shields = 0
    end
  end

  def drain_health(damage)
    health - damage < 0 ? @health = 0 : @health -= damage 
  end


  def heal(amount)
    raise RobotAlreadyDeadError if health == 0
    health + amount > MAX_HEALTH ? @health = MAX_HEALTH : @health += amount
  end

  def recharge(amount)
    raise RobotAlreadyDeadError if shields == 0
    shields + amount > MAX_SHIELDS ? @shields = MAX_SHIELDS : @shields += amount
  end

  def attack(enemy)
    raise RobotAlreadyDeadError if health == 0
    raise InvalidTarget if enemy.is_a? Item 
    raise UnattackableEnemy if enemy.health == 0

    equipped_weapon ? weapon_attack(enemy) : standard_attack(enemy)
  end

  def standard_attack(enemy)
    enemy.wound(@attack_points) if enemy_within_range?(enemy, 1)
  end

  def weapon_attack(enemy)
    if equipped_weapon.is_a? Special
      special_weapon_attack
    else
      @equipped_weapon.hit(enemy) if enemy_within_range?(enemy, @equipped_weapon.range)
      discard_weapon(@equipped_weapon) if equipped_weapon.is_a?(Grenade) || equipped_weapon.is_a?(Special)
    end
  end

  def special_weapon_attack
    nearby_enemyies = scan(self)
    nearby_enemyies.each do |enemy|
      enemy.health -= 30
    end
  end

  def discard_weapon(weapon)
    @equipped_weapon = nil
    @items.delete(weapon)
  end


  def enemy_within_range?(enemy, range)
    enemy_x_position(enemy) <= range && enemy_y_position(enemy) <= range
  end

  def enemy_x_position(enemy)
    (@position[0].abs + enemy.position[0]).abs
  end

  def enemy_y_position(enemy)
    (@position[1].abs + enemy.position[1]).abs
  end 

  def scan(robot)
    all_robots = Robot.list
    all_robots.each do |element|
      all_robots.delete(element) if element == robot 

      if enemy_x_position(element) >= 2 || enemy_y_position(element) >= 2
        all_robots.delete(element)
      end
    end
  end

  def self.list
    ObjectSpace.each_object(self).to_a
  end


  def self.in_position
    array = Robot.list
    position_array = []
    array.each do |element|
      position_array << element.position
    end
    position_array
  end


  class RobotAlreadyDeadError < StandardError

  end
  class InvalidTarget < StandardError

  end
  class UnattackableEnemy < StandardError

  end


end
