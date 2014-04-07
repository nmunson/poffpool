class TeamsController < ApplicationController

  def index
    @teams = Team.all.select{|team| team.players.count > 0}.sort_by{|team| team["name"]}
  end

  def show
    @team = Team.find(params[:id])
  end

end