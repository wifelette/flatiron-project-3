class Package < ApplicationRecord
  belongs_to :event
  has_many :specs
  has_many :perks, through: :specs

  validates :name, presence: true
  validates :price, numericality: { only_integer: true, allow_nil: true }
end
