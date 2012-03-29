class Entrant < ActiveRecord::Base

  has_many :picks
  has_many :players, :through => :picks

  validates :name, :presence => true

end
