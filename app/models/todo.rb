class Todo < ActiveRecord::Base
  validates :todo, presence: true
end
