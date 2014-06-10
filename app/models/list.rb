class List < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id
  has_many :todos
  validates :title, presence: true
end
