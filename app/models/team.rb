class Team < ActiveRecord::Base

  has_many :players

  validates :name, :presence  => true,
                   :uniqueness => true

  validates :shortname, :presence => true

  def goalie
    players.select{ |p| p["goalie"] }.first
  end

end
