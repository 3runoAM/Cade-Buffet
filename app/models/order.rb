class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :event
  enum status: { pending: 0, confirmed: 1, approved: 2, rejected: 3 }
end
