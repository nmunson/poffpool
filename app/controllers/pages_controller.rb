class PagesController < ApplicationController

  skip_before_filter :entry_mode_check, :only => [:index, :guide]

  def index
    @pool_status = get_status
    @prize_money = prize_money
    @updates = updates(@pool_status)
    @injuries = injuries(@pool_status)
    @welcome_title = ''
    if @pool_status == 'accepting_entries'
      @welcome_title = "The playoffs are back!"
      @welcome_message = "Welcome to the #{Time.now.year} NHL Playoff Pool. All entries "\
      "must be submitted online before "\
      "#{Time.parse(ENV['SUBMISSION_DEADLINE']).in_time_zone('Eastern Time (US & Canada)').strftime("%B %-d, %Y at %l:%M %p")} "\
      "through this website.  The submission of entries past that time are blocked from processing, "\
      "so please do not leave it until the last minute to submit.  When completing the entry you must "\
      "ensure that you have made arrangements for your entry fee to be paid.  If not, your name and "\
      "entry will be removed from the pool."
      @welcome_link = view_context.link_to "Submit Entry &raquo;".html_safe, new_entrant_path, :class => 'btn btn-primary btn-large'
    elsif @pool_status == 'validating_entries'
      @welcome_title = "Entry period has closed."
      @welcome_message = "We will now be validating all entries.  Feel free to browse "\
        "the site and see other people's picks.  Once NHL.com begins updating playoff statistics, "\
        "you'll see the #{view_context.link_to 'rankings page', entrants_path} updated."
      @welcome_link = view_context.link_to "View Entries &raquo;".html_safe, entrants_path, :class => 'btn btn-primary btn-large'
    elsif @pool_status == 'pool_active'
      @welcome_title = "Good luck!"
      @welcome_message = "Thanks for entering the playoff pool for 2014 and good luck to everyone."
      @welcome_link = view_context.link_to "View Rankings &raquo;".html_safe, entrants_path, :class => 'btn btn-primary btn-large'
    elsif @pool_status == 'validating_winners'
      @welcome_title = "The playoffs are over!"
      @welcome_message = "All the games have now finished.  We will be double checking the statistics "\
      "from NHL.com before officially announcing the winners."
    elsif @pool_status == 'pool_finished'
      @welcome_title = "Congrats to the winners!"
      @welcome_message = "The pool is now over and congratulations to all the winners.  Thanks everyone "\
      "for playing!"
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

  private

  def get_status
    if Time.parse(ENV['SUBMISSION_DEADLINE']) > Time.now
      'accepting_entries'
    elsif Time.parse(ENV['SUBMISSION_DEADLINE']) + 2.days > Time.now
      'validating_entries'
    elsif ENV['WINNERS_DECIDED'] == 'true'
      'pool_finished'
    elsif ENV['GAMES_FINISHED'] == 'true'
      'validating_winners'
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
