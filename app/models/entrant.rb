class Entrant < ActiveRecord::Base

  has_many :picks
  has_many :players, :through => :picks

  validates :name, :presence   => true,
                   :uniqueness => { :case_sensitive => false }

end
