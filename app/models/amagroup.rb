class Amagroup < ApplicationRecord
  belongs_to :user
  has_many :amatemps
  has_many :amagroupwithas, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
  default_scope -> {order(created_at: :desc)}

end
