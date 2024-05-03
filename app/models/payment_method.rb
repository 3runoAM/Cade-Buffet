class PaymentMethod < ApplicationRecord
  has_many :buffet_payment_methods
  has_many :buffets, through: :buffet_payment_methods
  has_many :orders
end
