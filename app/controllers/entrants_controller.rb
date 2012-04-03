class EntrantsController < ApplicationController

  def index
    @entrants = Entrant.by_season_points
    respond_to do |format|
      format.json { render_for_api :entrants, :json => @entrants, :root => :entrants}
    end
  end

end
