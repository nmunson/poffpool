class EntrantsController < ApplicationController

  skip_before_filter :entry_mode_check, :only => [:new, :create, :list]
  before_filter :prevent_late_submissions, :only => [:new, :create]
  before_filter :authenticate_admin, :only => [:list]

  def index
    @entrants = Entrant.all.sort_by{ |e| -e.points }
    @top_movers = Entrant.all.sort_by { |e| -e.rank_change }.take(10)
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

  def list
    @entrants = Entrant.all.sort_by{|e| e.created_at}.reverse
  end

  def show
    @entrant = Entrant.find(params[:id])
  end

  private

  def prevent_late_submissions
    redirect_to root_url if Time.parse(ENV['SUBMISSION_DEADLINE']) < Time.now
  end

  def authenticate_admin
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      username == 'admin' && password == ENV['ADMIN_PASSWORD']
    end
  end

end
