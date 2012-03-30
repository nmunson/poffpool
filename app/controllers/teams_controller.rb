class TeamsController < ApplicationController

  respond_to :json

  def index
    @teams = Team.all
    respond_with(@teams)
  end

  def show
    @team = Team.find(params[:id])
    respond_with(@team)
  end

end
