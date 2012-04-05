class TeamsController < ApplicationController

  def index
    @teams = Team.all.select{|team| team.players.count > 0}.sort_by{|team| team["name"]}
    respond_to do |format|
      format.html
      format.json { render_for_api :team, :json => @teams, :root => :teams}
    end
  end

  def show
    @team = Team.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render_for_api :team_info, :include => :players, :json => @team }
    end
  end

end