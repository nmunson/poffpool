class EntrantsController < ApplicationController

  skip_before_filter :entry_mode_check, :only => [:new, :create]
  before_filter :prevent_late_submissions, :only => [:new, :create]

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
      flash[:success] = "Congratulations, you have been successfully entered into the pool.  Check back shortly when the submission period has ended for site updates.  Your picks were: " + @entrant.players.collect{|k| k["name"]}.join(", ") + "."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @entrant = Entrant.find(params[:id])
  end

  private

  def prevent_late_submissions
    redirect_to root_url if Time.parse(ENV['SUBMISSION_DEADLINE']) < Time.now
  end

end
