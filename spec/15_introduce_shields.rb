require_relative 'spec_helper'
# Robots can start with 50 shield points. When the robot is damaged it first drains the shield and then starts affecting actual health.

# You will likely also have to fix previous tests that will fail due to this enhancement. However, focus on running spec 16 until you are done, then rerun all your tests to find other failing tests and modify the tests to modify their expectations.
describe Robot do 
  before do
    @robot = Robot.new
  end

  describe "#shields" do
    it "should be 50" do
      expect(@robot.shields).to eq(50)
    end

  end
  describe "#wound" do
    it "should decrease shield before health if there's shield" do
      @robot.wound(20)
      expect(@robot.shields).to eq(30)
      expect(@robot.health).to eq(Robot::MAX_HEALTH)
    end

    it "should decrease health once shield runs out" do
      @robot.wound(100)
      expect(@robot.shields).to eq(0)
      expect(@robot.health).to eq(50)
    end
  end
end
