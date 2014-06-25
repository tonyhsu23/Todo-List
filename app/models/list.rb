class List < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id
  has_many :todos, dependent: :destroy
  validates :title, presence: true
end
