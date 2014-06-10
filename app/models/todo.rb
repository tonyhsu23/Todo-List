class Todo < ActiveRecord::Base
  belongs_to :list, foreign_key: :list_id
  validates :todo, presence: true
end
