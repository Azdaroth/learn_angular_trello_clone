class Card < ActiveRecord::Base

  belongs_to :list

  validates :name, :priority, presence: true

end
