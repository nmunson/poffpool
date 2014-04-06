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
    players.map{|p| p.points}.sum
  end

  def rank_change
    previous_rank - current_rank
  end

  def previous_rank
    if sorted_rankings[-2].nil?
      return 0
    else
      return sorted_rankings[-2]["rank"]
    end
  end

  def current_rank
    if sorted_rankings[-1].nil?
      return 0
    else
      return sorted_rankings[-1]["rank"]
    end
  end

  private

  def sorted_rankings
    rankings.sort_by{|r| r["date"]}
  end

end
