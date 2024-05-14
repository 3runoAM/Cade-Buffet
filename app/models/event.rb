class Event < ApplicationRecord
  belongs_to :buffet
  has_many :event_prices
  has_many_attached :photos

  validates :name, presence: true
  validates :name, uniqueness: { scope: :buffet_id }
  validates :description, presence: true
  validates :min_guests, presence: true
  validates :max_guests, presence: true
  validates :standard_duration, presence: true
  validates :menu, presence: true
  validate :max_guest_greater_than_min_guests

  def offsite_event_status
    I18n.t(offsite_event.to_s, scope: 'boolean')
  end

  def offers_alcohol_status
    I18n.t(offers_alcohol.to_s, scope: 'boolean')
  end

  def offers_decoration_status
    I18n.t(offers_decoration.to_s, scope: 'boolean')
  end

  def offers_valet_parking_status
    I18n.t(offers_valet_parking.to_s, scope: 'boolean')
  end

  def convert_to_hours
    hours = standard_duration / 60
    minutes = standard_duration % 60

    return "#{hours}h" if minutes == 0
    "#{hours}h #{minutes}min"
  end

  def min_and_max_guests_format
    "#{min_guests} a #{max_guests}"
  end

  private

  def max_guest_greater_than_min_guests
    if min_guests >= max_guests
      errors.add(:max_guests, I18n.t("error.models.event.max_guest_greater_than_min_guests"))
    end
  end
end