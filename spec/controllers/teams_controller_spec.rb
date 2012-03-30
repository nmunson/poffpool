require 'spec_helper'

describe TeamsController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index, :format => :json 
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      @team = Team.first
      get :show, :id => @team, :format => :json
      response.should be_success
    end
  end

end
