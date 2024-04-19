class Address < ApplicationRecord
  belongs_to :buffet
  validates :street_name, presence: true
  validates :neighborhood, presence: true
  validates :house_or_lot_number, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  def full_address
    "#{street_name}, #{house_or_lot_number}, #{neighborhood}, #{city} - #{state}, #{zip}"
  end
end