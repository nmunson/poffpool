require 'spec_helper'

describe Team do

  before(:each) do
    @attr = {
      :name => "New Team",
      :shortname => "team"
    }
  end

  context "attributes" do
    it "should create a new instance given valid attributes" do
      Team.create!(@attr)
    end

    it "should require a name" do
      no_team_name = Team.new(@attr.merge({:name => ""}))
      no_team_name.should_not be_valid
    end

    it "should reject duplicate names" do 
      Team.create!(@attr)
      duplicate_team = Team.new(@attr)
      duplicate_team.should_not be_valid
    end

    it "should require a shortname" do
      no_shortname = Team.new(@attr.merge({:shortname => ""}))
      no_shortname.should_not be_valid
    end
  end

  context "#goalie" do
    it "should return the first goalie on the team" do
      team = Team.create!(@attr)
      team.players.create!({:name => "examplegoalie", :goalie => true})
      team.players.create!({:name => "examplegoalie2", :goalie => true})
      team.goalie.name.should == "examplegoalie"
    end
  end
end
