class Grenade < Weapon
  
  NAME = "Grenade"
  WEIGHT = 40
  DAMAGE = 15
  RANGE = 2

  def initialize
    super(NAME, WEIGHT, DAMAGE)
    @range = 2
  end

end