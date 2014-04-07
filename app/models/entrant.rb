class Entrant < ActiveRecord::Base

  has_many :picks
  has_many :players, :through => :picks

  has_many :rankings

  validates :name, :presence   => true,
                   :uniqueness => { :case_sensitive => false },
                   :length => { :maximum => 25 }

  validate :player_picks_are_valid

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

  def player_picks_are_valid
    #three_players_per_main_five_columns
    single_goalie
    #single_mulligan_man
    #mulligan_man_different_team_than_goalie
    #one_player_per_team
    picks_count_within_bounds
  end

  def three_players_per_main_five_columns
    errors.add(:picks, "did not have three players for each of the five main columns")
  end

  def single_goalie
    if players.map{|p| p.goalie}.count > 1
      errors.add(:picks, "has too many goalies")
    end
  end

  def single_mulligan_man
    errors.add(:picks, "did not have a single mulligan man")
  end

  def mulligan_man_different_team_than_goalie
    errors.add(:picks, "did not choose a mulligan man from a different team than the goalie")
  end

  def one_player_per_team
    errors.add(:picks, "did not have a single player per team, excluding the mulligan man")
  end

  def picks_count_within_bounds
    player_count = 5 * 3 + 1 + 1 # 3 per five columns, one goalie, one mulligan man
    if players.count != player_count && players.count > 02
      errors.add(:picks, "count must be #{player_count}") 
    end
  end

end