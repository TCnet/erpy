class Amatemp < ApplicationRecord
  belongs_to :user

  has_many :amatwithas, dependent: :destroy
  has_many :amagroupwithas, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
  has_many :amagroups, through: :amagroupwithas, source: :amagroup

end
