class Special < Weapon

  NAME = "Special Weapon"
  WEIGHT = 50
  DAMAGE = 30
  RANGE = 1

  def initialize
    super(NAME, WEIGHT, DAMAGE)
  end
end