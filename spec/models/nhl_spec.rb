require 'spec_helper'

describe NHL do

  context ".create_teams" do

    it "should create 30 teams" do
      NHL.create_teams
      Team.all.count.should == 30
    end

  end

end
