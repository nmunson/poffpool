class Player < ActiveRecord::Base

  has_many :picks
  has_many :entrants, :through => :picks

  belongs_to :team

  validates :name, :presence  => true,
                   :uniqueness => { :case_sensitive => false }

  validates :team_id, :presence => true

  validates :position, :presence => true,
    inclusion: { in: %w(column1 column2 column3 column4 column5 goalie mulligan) }

  def points
    goals + assists + shutouts * Integer(ENV['SHUTOUT_MULTIPLIER']) + wins * Integer(ENV['WIN_MULTIPLIER'])
  end

  def goalie?
    position == "goalie"
  end

  def mulligan?
    position == "mulligan"
  end

end
