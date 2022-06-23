class Amatwitha < ApplicationRecord
  belongs_to :album
  belongs_to :amatemp
  validates :amatemp_id, presence: true
  validates :album_id, presence: true
end
