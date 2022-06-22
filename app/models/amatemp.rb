class Amatemp < ApplicationRecord
  belongs_to :user
  has_many :amatwithas, dependent: :destroy
end
