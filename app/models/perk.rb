class Perk < ApplicationRecord
  validates :name, presence: true

  has_many :specs
  has_many :packages, through: :specs
end
