class PagesController < ApplicationController

  skip_before_filter :entry_mode_check, :only => [:index, :guide]

  def index
  end

  def prizes
  end

  def contact
  end

  def guide
  end

end
