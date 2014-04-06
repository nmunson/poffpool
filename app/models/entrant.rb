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
    goals = self.players.map{|p| p.goals}.sum
    assists = self.players.map{|p| p.assists}.sum
    shutouts = self.players.map{|p| p.shutouts}.sum
    wins = self.players.map{|p| p.wins}.sum
    shutout_mult = Integer(ENV['SHUTOUT_MULTIPLIER'])
    win_mult = Integer(ENV['WIN_MULTIPLIER'])

    goals + assists + (shutouts * shutout_mult) + (wins * win_mult)
  end

  def previous_rank
    sorted_rankings = rankings.sort_by{|r| r["date"]}
    if sorted_rankings[-2].nil?
      return 0
    else
      return sorted_rankings[-2]["rank"]
    end
  end

  def current_rank
    if rankings && rankings.last
      rankings.last["rank"]
    else
      0
    end
  end

  def rank_change
    previous_rank - current_rank
  end

end
