class Package < ApplicationRecord
  belongs_to :event
  # If you delete a Package, delete all the Specs tied to it as well:
  has_many :specs, dependent: :destroy
  has_many :perks, through: :specs

  validates :name, presence: true
  validates :price, numericality: { only_integer: true, allow_nil: true }

  accepts_nested_attributes_for :specs, allow_destroy: true, reject_if: ->(attrs) { attrs["qty"] == "0" }
end
