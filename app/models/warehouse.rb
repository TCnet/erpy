class Warehouse < ApplicationRecord
  belongs_to :user
  has_many :inventories, dependent: :destroy
  has_many :inoutplans, dependent: :destroy
end
