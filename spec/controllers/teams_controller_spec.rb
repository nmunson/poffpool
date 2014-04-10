require 'spec_helper'

describe TeamsController do

  describe "GET 'index'" do
    it "returns http success" do
      pending
      get :index
      response.should be_success
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @attr = {
        :name => "Maple Leafs",
        :shortname => "leafs"
      }
      Team.create(@attr)
    end

    let (:team) { Team.first }

    it "returns http success" do
      pending
      get :show, :id => team
      response.should be_success
    end
  end

end
