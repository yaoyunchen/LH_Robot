require_relative 'spec_helper'

# The Robot class can be asked to return all robots in a given position (x,y). It should return an array of all the robots since multiple robots could potentially be at position 0,0 (for example)

describe Robot do
  before :each do
    @robot1 = Robot.new
    @robot2 = Robot.new
    @robot3 = Robot.new
  end

  it "should return all robot's position in an array" do
    expect(Robot.in_position).to match_array([@robot3.position, @robot2.position, @robot1.position])
    @robot3.move_up
    expect(Robot.in_position).to match_array([[0, 1], @robot2.position, @robot1.position])
  end
end

