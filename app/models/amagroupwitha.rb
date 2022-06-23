class Amagroupwitha < ApplicationRecord
  belongs_to :amagroup
  belongs_to :amatemp
  validates :amatemp_id, presence: true
  validates :amagroup_id, presence: true
end
