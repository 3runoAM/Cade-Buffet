class Event < ApplicationRecord
  belongs_to :buffet

  validates :name, presence: true
  validates :description, presence: true
  validates :min_guests, presence: true
  validates :max_guests, presence: true
  validates :standard_duration, presence: true
  validates :menu, presence: true

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
end
