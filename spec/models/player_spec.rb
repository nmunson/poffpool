require 'spec_helper'

describe Player do

  before(:each) do
    @attr = {
      :name => "exampleplayer",
      :team_id => 1
    }
  end

  context "attributes" do
    it "should create a new instance given valid attributes" do
      Player.create!(@attr)
    end

    it "should require a name" do
      no_name_player = Player.new(@attr.merge({:name => "" }))
      no_name_player.should_not be_valid
    end

    it "should reject duplicate names" do
      Player.create!(@attr)
      duplicate_name_player = Player.new(@attr)
      duplicate_name_player.should_not be_valid
    end

    it "should require a team_id" do
      no_team_player = Player.new(@attr.merge({:team_id => ""}))
      no_team_player.should_not be_valid
    end

    it "should respond to picks" do
      player = Player.create!(@attr)
      player.should respond_to(:picks)
    end

    it "should respond to entrants" do
      player = Player.create!(@attr)
      player.should respond_to(:entrants)
    end
  end

  context "#points" do
    before(:each) do
      @player = Player.create!(@attr)
    end

    it "should return 0 if there are no points" do 
      @player.points.should == 0
    end

    let(:shutout_multiplier) { Integer(ENV['SHUTOUT_MULTIPLIER']) }
    let(:win_multiplier) { Integer(ENV['WIN_MULTIPLIER']) }

    it "should return the point count for the player" do
      @player.assists = 3
      @player.goals = 2
      @player.shutouts = 2
      @player.wins = 1
      @player.points.should == 3 + 2 + 2 * shutout_multiplier + 1 * win_multiplier
    end
  end
end
