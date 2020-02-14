class Perk < ApplicationRecord
  validates :name, presence: true

  has_many :packages, through: :specs
end
