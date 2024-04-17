class Buffet < ApplicationRecord
  belongs_to :user
  has_one :address
  has_many :buffet_payment_methods
  has_many :payment_methods, through: :buffet_payment_methods
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :buffet_payment_methods
end