class TeamsController < ApplicationController

  respond_to :json

  def index
    @teams = Team.all.select{|team| team.players.count > 0}
    respond_with(@teams, :except => [:created_at, :updated_at])
  end

  def show
    @team = Team.find(params[:id])
    respond_with(@team, :except => [:created_at, :updated_at])
  end

end
