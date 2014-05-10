class List < ActiveRecord::Base

  validates :name, :priority, presence: true

end
