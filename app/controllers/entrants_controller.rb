class EntrantsController < ApplicationController

  def index
    @entrants = Entrant.by_season_points
    respond_to do |format|
      format.html
      format.json { render_for_api :entrants, :json => @entrants, :root => :entrants}
    end
  end

  def new
    @entrant = Entrant.new
  end

  def create
    @entrant = Entrant.new(params[:entrant])
    if @entrant.save
      flash[:success] = "Congratulations, you have been successfully entered into the pool.  Check back shortly."
      redirect_to @entrant
    else
      render 'new'
    end
  end

  def show
    @entrant = Entrant.find(params[:id])
  end

end
