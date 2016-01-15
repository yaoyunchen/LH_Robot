require_relative 'spec_helper'

describe Robot do
  before do
    @robot = Robot.new
  end
  
  describe "#heal!" do
    it "should raise RobotAlreadyDeadError if robot has no health left" do
      allow(@robot).to receive(:shields).and_return(0)
      @robot.wound(@robot.health)
      expect{@robot.heal(20)}.to raise_error(Robot::RobotAlreadyDeadError)
    end

    it "should be able to heal" do
      allow(@robot).to receive(:shields).and_return(0)
      @robot.wound(40)
      @robot.heal(20)
      expect(@robot.health).to eq(80)
    end
  end

  describe "#attack!" do
    it "should raise RobotAlreadyDeadError if robot has no health" do
      enemy = Robot.new
      allow(@robot).to receive(:shields).and_return(0)
      @robot.wound(@robot.health)
      expect{@robot.attack(enemy)}.to raise_error(Robot::RobotAlreadyDeadError)
    end

    it "should raise InvalidTarget if target is not a robot" do
      plasma_cannon = PlasmaCannon.new
      expect{@robot.attack(plasma_cannon)}.to raise_error(Robot::InvalidTarget)
    end

    it "should raise UnattackableEnemy if target has no health" do
      enemy = Robot.new
      allow(enemy).to receive(:shields).and_return(0)
      enemy.wound(enemy.health)
      expect{@robot.attack(enemy)}.to raise_error(Robot::UnattackableEnemy)
    end

    it "should be able to deal damage equal to its attack power to enemy" do
      enemy = Robot.new
      expect(enemy).to receive(:wound).with(5)
      @robot.attack(enemy)
    end
  end

end