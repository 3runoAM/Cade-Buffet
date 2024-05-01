class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :event
  belongs_to :user
  enum status: { pending: 0, confirmed: 1, approved: 2, rejected: 3 }
  before_validation :generate_code, on: :create
  before_validation :set_address_if_blank
  before_validation :set_price
  validates :event_date, presence: true
  validates :total_guests, presence: true
  validates :code, presence: true
  validates :address, presence: true
  validates :price, presence: true
  validate :event_date_cannot_be_in_the_past
  validate :total_guests_must_be_within_event_limits

  def set_price
    if self.event_date.on_weekday?
      self.price = calculate(self.event.event_prices.find_by(day_type: :weekday))
    else
      self.price = calculate(event.event_prices.find_by(day_type: :weekend))
    end
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def set_address_if_blank
    self.address = self.buffet.address.full_address if self.address.blank?
  end

  def event_date_cannot_be_in_the_past
    if event_date < Date.today
      errors.add(:event_date, 'não pode ser no passado')
    end
  end

  def total_guests_must_be_within_event_limits
    if self.total_guests < event.min_guests || self.total_guests > event.max_guests
      errors.add(:total_guests, "deve ser entre #{event.min_guests} e #{event.max_guests}")
    end
  end

  def has_same_day_order?
    Order.where("id != ? AND event_date = ? AND buffet_id = ? AND status != ?", id, event_date, buffet_id, "rejected").any?
  end

  private

  def calculate(event_prices)
    standard_price = event_prices.standard_price
    standard_price += (total_guests - event.min_guests) * event_prices.extra_guest_price
  end
end
