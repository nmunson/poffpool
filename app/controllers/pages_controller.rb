class PagesController < ApplicationController

  skip_before_filter :entry_mode_check, :only => [:index, :guide]

  def index
    @injuries = ENV['INJURIES'].split(",")

    # choose what status the pool is in
    @pool_status = if Time.parse(ENV['SUBMISSION_DEADLINE']) > Time.now
      'accepting_entries'
    elsif Time.parse(ENV['SUBMISSION_DEADLINE']) + 2.days > Time.now
      'validating_entries'
    elsif ENV['GAMES_FINISHED'] == 'true'
      'validating_winners'
    elsif ENV['WINNERS_DECIDED'] == 'true'
      'pool_finished'
    else
      'pool_active'
    end
  end

  def prizes
  end

  def contact
  end

  def guide
  end

end
