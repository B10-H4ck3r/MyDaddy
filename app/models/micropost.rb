class Micropost < ApplicationRecord
  belongs_to :baby
  default_scope -> { order(created_at: :desc) }
  validates :baby_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
