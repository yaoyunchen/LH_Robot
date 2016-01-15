require_relative 'spec_helper'

# The Robot class should keep track of all robots that are instantiated.

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe "#list" do
    it "should contain an array of all robots" do
      expect(Robot.list).to eq([@robot])
      @robot2 = Robot.new
      expect(Robot.list).to eq([@robot2, @robot])
      @robot3 = Robot.new 
      expect(Robot.list).to eq([@robot3, @robot2, @robot])
    end
  end
end


