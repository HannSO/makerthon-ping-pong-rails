class Player < ActiveRecord::Base
  has_many :games
  validates :name, length: {minimum: 3}
end
