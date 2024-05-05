class EventPrice < ApplicationRecord
  belongs_to :event
  enum day_type: { weekday: 0, weekend: 1}
  validates :standard_price, presence: true
  validates :extra_guest_price, presence: true
  validates :extra_hour_price, presence: true
  validates :day_type, presence: true
  validates :day_type, uniqueness: { scope: :event_id }
  validates :day_type, inclusion: { in: day_types.keys }

  def self.day_type_options
    day_types.keys.map { |dt| [dt, I18n.t("activerecord.attributes.event_price.day_types.#{dt}")] }
  end
end
