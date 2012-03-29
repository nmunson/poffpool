class Team < ActiveRecord::Base

  has_many :players

  validates :name, :presence  => true,
                   :uniqueness => true

  validates :shortname, :presence => true

end
