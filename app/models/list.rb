class List < ActiveRecord::Base

  has_many :cards

  validates :name, :priority, presence: true


end
