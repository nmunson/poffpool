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

    @prize_money = if ENV['PRIZE_MONEY']
      "The prize money winnings have been determined. "\
      "See more information on the #{view_context.link_to "Prizes", prizes_path} page."
    else
      "Prizes are dependent on the amount of entries in the pool. "\
      "They will be announced once all entries have been validated and paid for."
    end
  end

  def prizes
    if ENV['PRIZE_MONEY']
      @prize_money = "The prize money breakdown is as follows:" 
      @prize_money += "<ol>"
      ENV['PRIZE_MONEY'].split(',').each do |prize|
        @prize_money += "<li>$#{prize}</li>"
      end
      @prize_money += "</ol>"
    else
      @prize_money = 'Prizes have yet to be determined.'
    end
  end

  def contact
  end

  def guide
  end

end
