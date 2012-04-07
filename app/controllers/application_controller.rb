class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :entry_mode_check

  private

  # can users submit entries, or is the entry period closed
  def entry_mode_check
    return if Rails.env.development?
    if Time.parse(ENV['SUBMISSION_DEADLINE']) > Time.now
      redirect_to root_url
    end
  end

end
