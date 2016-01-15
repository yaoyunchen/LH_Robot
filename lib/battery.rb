class Battery < Item
  NAME = "Battery"
  WEIGHT = 25
  RECHARGE_AMOUNT = 50
  
  def initialize
    super(NAME, WEIGHT)
  end

  def charge(robot)
    robot.recharge(RECHARGE_AMOUNT)
  end
end