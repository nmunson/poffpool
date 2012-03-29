class Player < ActiveRecord::Base

  has_many :picks
  has_many :entrants, :through => :picks

  belongs_to :team

end
