require_relative "spec_helper"

# A given robot should be able to scan its surroundings (tiles immediately next to its current @position) Note: You should leverage the class method implemented in #18

describe Robot do
  before :each do
    @robot = Robot.new
    @robot2 = Robot.new
    @robot3 = Robot.new
    @robot3.move_up
    @robot3.move_right
  end
  describe "#scanning" do
    it "should be able to scan its surroundings for other robots and return an array of robots" do
      expect(@robot.scan(@robot)).to match_array([@robot3, @robot2])
      @robot2.move_up
      @robot3.move_up
      @robot3.move_right
      expect(@robot.scan(@robot)).to match_array([@robot2])
    end 
  end
end