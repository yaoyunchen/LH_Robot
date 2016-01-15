class BoxOfBolts < Item
  WEIGHT = 25
  HEAL_AMOUNT = 20

  def initialize
    super('Box of bolts', WEIGHT)
  end

  def feed(robot)
    robot.heal(HEAL_AMOUNT)
  end
end