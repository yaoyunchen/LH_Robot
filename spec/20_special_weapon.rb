require_relative 'spec_helper'

describe Special do 
  before :each do
    @special = Special.new
  end
  
  it "should be a weapon" do
    expect(@special).to be_a Weapon
  end
  it "should have name 'Special Weapon'" do
    expect(@special.name).to eq("Special Weapon")
  end
  it "should have range of 1" do
    expect(@special.range).to eq(1)
  end

  it "should do 30 damage to enemies within range, regardless of shield" do
    @robot = Robot.new
    @enemy1 = Robot.new
    @enemy2 = Robot.new
    @enemy2.move_up
    @enemy2.move_right
    @robot.pick_up(@special)
    expect(@robot.equipped_weapon).to eq(@special)
    @robot.attack(@enemy1)
    expect(@enemy1.health).to eq(70)
    expect(@enemy2.health).to eq(70)
  end
end
