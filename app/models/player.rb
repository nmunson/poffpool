class Player < ActiveRecord::Base

  has_many :picks
  has_many :entrants, :through => :picks

  belongs_to :team

  validates :name, :presence  => true,
                   :uniqueness => { :case_sensitive => false }

  validates :team_id, :presence => true

end
