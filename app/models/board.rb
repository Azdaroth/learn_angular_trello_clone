class Board < ActiveRecord::Base

  validates :name, presence: true

  has_many :lists
  has_many :cards, through: :lists

end
