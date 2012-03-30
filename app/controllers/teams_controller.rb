class TeamsController < ApplicationController

  respond_to :json

  def index
    @teams = Team.all
    respond_with(@teams)
  end

end
