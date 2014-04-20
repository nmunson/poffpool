class PagesController < ApplicationController

  skip_before_filter :entry_mode_check, :only => [:index, :guide]

  def index
    @pool_status = get_status
    @prize_money = prize_money
    @updates = updates(@pool_status)
    @injuries = injuries(@pool_status)
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

  private

  def get_status
    if Time.parse(ENV['SUBMISSION_DEADLINE']) > Time.now
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

  def prize_money
    if ENV['PRIZE_MONEY']
      "The prize money winnings have been determined. "\
      "See more information on the #{view_context.link_to "Prizes", prizes_path} page."
    else
      "Prizes are dependent on the amount of entries in the pool. "\
      "They will be announced once all entries have been validated and paid for."
    end
  end

  def updates(status)
    @updates = "The site will pull updates from NHL.com daily at 5 AM for all players. "\
      "If you see any inconsistencies with points, please contact me. "
    if status == 'accepting_entries' or status == 'validating_entries'
      @updates += "Please note stats and rankings will be published as soon as NHL.com begins reporting them."
    end
    @updates
  end

  def injuries(status)
    @injuries = ""
    if ENV['INJURIES']
      @injuries = "We have removed #{ENV['INJURIES'].split(',').join(', ')} "
      @injuries += "from the available pool of players due to injuries."
    else
      @injuries = "There were no players removed from the pool due to injuries this year."
    end

    if status == 'accepting_entries' or status == 'validating_entries'
      @injuries += "We suggest you double check the status of all your picks before submitting."
    end
    @injuries
  end

end
