class Inoutplan < ApplicationRecord
  belongs_to :user
   belongs_to :warehouse
  has_many :inoutstocks, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 },
            uniqueness: { case_sensitive: false }
end
