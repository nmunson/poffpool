require 'spec_helper'

describe Player do

  before(:each) do
    @attr = {
      :name => "exampleplayer",
      :team_id => 1
    }
  end

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
