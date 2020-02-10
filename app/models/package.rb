class Package < ApplicationRecord
  belongs_to :event

  validates :name, presence: true
  validates :price, numericality: { only_integer: true, allow_nil: true }
end
