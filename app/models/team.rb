class Team < ActiveRecord::Base

  has_many :players

  validates :name, :presence  => true,
                   :uniqueness => true

  validates :shortname, :presence => true

  # All stats for the team goalie will be logged under this player
  def goalie
    players.select{ |p| p.goalie? }.first
  end

end
