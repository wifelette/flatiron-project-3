class Event < ApplicationRecord
  has_many :packages
  scope :not_yet_happened, -> { where("start_date > ?", Time.now) } 
  
  validates :name, uniqueness: true, presence: true

  # This is effectively the same thing as the Scope bit above, I just wanted to practice both ways.
  def self.already_happened
    Event.where("start_date < ?", Time.now)
  end

  # def self.not_yet_happened
  #   Event.where("start_date > ?", Time.now)
  # end
end
