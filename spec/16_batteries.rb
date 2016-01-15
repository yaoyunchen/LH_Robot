require_relative 'spec_helper'
# Batteries are items that can be used by robot to recharge its shield. Implement Battery item that can be used to recharge the Robot’s shield. Batteries have a weight of 25.

describe Battery do 
  before :each do
    @battery = Battery.new
  end

  it "should be an item" do
    expect(@battery).to be_an(Item)
  end
  
  it "should have name 'Battery'" do
    expect(@battery.name).to eq("Battery")
  end

  it "should weight 25" do
    expect(@battery.weight).to eq(25)
  end

  describe "#feed" do
    before :each do
      @robot = Robot.new
    end

    it "should recharge robot's shield to full" do
      expect(@robot).to receive(:recharge).with(Robot::MAX_SHIELDS)
      @battery.charge(@robot)
    end

    it "should raise RobotAlreadyDeadError if robot is has no health." do
      allow(@robot).to receive(:shields).and_return(0)
      @robot.wound(@robot.health)
      expect{@robot.recharge(20)}.to raise_error(Robot::RobotAlreadyDeadError)
    end
  end
end