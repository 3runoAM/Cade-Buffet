class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :event
  belongs_to :user
  belongs_to :payment_method, optional: true
  enum status: { pending: 0, confirmed: 1, approved: 2, rejected: 3 }
  enum adjustment_type: { nonexistent: 0, discount: 1, surcharge: 2 }
  before_validation :generate_code, on: :create
  before_validation :set_address_if_blank
  before_validation :set_price
  validates :status, inclusion: { in: statuses.keys }
  validates :adjustment_type, inclusion: { in: adjustment_types.keys }
  validates :event_date, presence: true
  validates :total_guests, presence: true
  validates :code, presence: true
  validates :address, presence: true
  validates :price, presence: true
  validates :payment_method, presence: true, if: :approved?
  validates :confirmation_date, presence: true, if: :approved?
  validate :confirmation_date_cannot_be_in_the_past, if: :approved?
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

  def confirmation_date_cannot_be_in_the_past
    if confirmation_date < Date.today
      errors.add(:confirmation_date, 'não pode ser no passado')
    end
  end

  def total_guests_must_be_within_event_limits
    if self.total_guests <= 0 || self.total_guests > event.max_guests
      errors.add(:total_guests, "deve ser entre #{event.min_guests} e #{event.max_guests}")
    end
  end



  def has_same_day_order?
    Order.where("id != ? AND event_date = ? AND buffet_id = ? AND status != ?", id, event_date, buffet_id, "rejected").any?
  end

  def self.adjustment_type_options
    adjustment_types.keys.map do |adjustment|
      [adjustment, I18n.t("activerecord.attributes.order.adjustment_types.#{adjustment}")]
    end
  end

  def self.approved?
    status == 'approved'
  end

  private

  def calculate(event_prices)
    standard_price = event_prices.standard_price
    standard_price += (total_guests - event.min_guests) * event_prices.extra_guest_price
    apply_adjustments(standard_price)
  end

  def apply_adjustments(standard_price)
    case self.adjustment_type
    when 'discount'
      return standard_price - self.adjustment
    when 'surcharge'
      return standard_price + self.adjustment
    end
    standard_price
  end
end