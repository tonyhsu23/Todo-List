class Todo < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id
  validates :todo, presence: true
end
