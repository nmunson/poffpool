require 'spec_helper'

describe PlayersController do

  describe "GET 'show'" do
    before(:each) do
      @attr = {
        :name => "exampleplayer",
        :team_id => 1,
        :position => "goalie"
      }
      Player.create(@attr)
    end

    let (:player) { Player.first }

    it "returns http success" do
      get 'show', :id => player
      response.should be_success
    end
  end

end
