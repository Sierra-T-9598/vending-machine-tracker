class Snack < ApplicationRecord
  validates_presence_of :name, :price
  has_many :machine_snacks
  has_many :machines, through: :machine_snacks

  def self.average_price
    average(:price)
  end

  def snack_locations
    self.machines.pluck(:location)
  end
end
