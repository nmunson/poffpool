class Entrant < ActiveRecord::Base

  acts_as_api

  api_accessible :entrants do |template|
    template.add :id
    template.add :name
    template.add :points
  end

  has_many :picks
  has_many :players, :through => :picks

  has_many :rankings

  validates :name, :presence   => true,
                   :uniqueness => { :case_sensitive => false },
                   :length => { :maximum => 25 }

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence => true,
                    :format => { :with => email_regex }

  def points
    self.players.sum('goals') + self.players.sum('assists') + 
      self.players.sum('shutouts') * Integer(ENV['SHUTOUT_MULTIPLIER']) + 
      self.players.sum('wins') * Integer(ENV['WIN_MULTIPLIER'])
  end

  def yesterdays_rank
    sorted_rankings = rankings.sort_by{|r| r["date"]}
    if sorted_rankings[-2].nil?
      return 0
    else
      return sorted_rankings[-2]["rank"]
    end
  end

end
