class Team < ActiveRecord::Base

  acts_as_api

  api_accessible :team do |template|
    template.add :id
    template.add :name
    template.add :shortname
  end

  api_accessible :team_info do |template|
    template.add :id
    template.add :name
    template.add :shortname
    template.add :players
  end

  has_many :players

  validates :name, :presence  => true,
                   :uniqueness => true

  validates :shortname, :presence => true

  def goalie
    players.select{ |p| p["goalie"] }
  end

end
