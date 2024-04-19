require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'Bolleans are translated correctly' do
    describe '#offsite_event_status' do
      it 'translates to "Sim"' do
        event = Event.new(offsite_event: true)
        expect(event.offsite_event_status).to eq('Sim')
      end
      it 'translates to "Não"' do
        event = Event.new(offsite_event: false)
        expect(event.offsite_event_status).to eq('Não')
      end
    end

    describe '#offers_Alcohol_status' do
      it 'translates to "Sim"' do
        event = Event.new(offers_alcohol: true)
        expect(event.offers_alcohol_status).to eq('Sim')
      end
      it 'translates to "Não"' do
        event = Event.new(offers_alcohol: false)
        expect(event.offers_alcohol_status).to eq('Não')
      end
    end

    describe '#offers_decoration_status' do
      it 'translates to "Sim"' do
        event = Event.new(offers_decoration: true)
        expect(event.offers_decoration_status).to eq('Sim')
      end
      it 'translates to "Não"' do
        event = Event.new(offers_decoration: false)
        expect(event.offers_decoration_status).to eq('Não')
      end
    end

    describe '#offers_valet_parking_status' do
      it 'translates to "Sim"' do
        event = Event.new(offers_valet_parking: true)
        expect(event.offers_valet_parking_status).to eq('Sim')
      end
      it 'translates to "Não"' do
        event = Event.new(offers_decoration: false)
        expect(event.offers_decoration_status).to eq('Não')
      end
    end
  end

  context 'Event duration convertion' do
    describe '#convert_to_hours' do
      it 'converts 60 minutes to 1 hour' do
        event = Event.new(standard_duration: 60)
        expect(event.convert_to_hours).to eq('1h')
      end
      it 'converts 90 minutes to 1 hour and 30 minutes' do
        event = Event.new(standard_duration: 90)
        expect(event.convert_to_hours).to eq('1h 30min')
      end
      it 'converts 65 minutes to 1 hour and 5 minutes' do
        event = Event.new(standard_duration: 65)
        expect(event.convert_to_hours).to eq('1h 5min')
      end
      it 'converts 61 minutes to 1 hour and 1 minute' do
        event = Event.new(standard_duration: 61)
        expect(event.convert_to_hours).to eq('1h 1min')
      end
    end
  end

  context 'Format minimum and maximum guests' do
    it '#min_and_max_guests_format' do
      event = Event.new(min_guests: 10, max_guests: 30)
      expect(event.min_and_max_guests_format).to eq('10 a 30')
    end
  end

  context 'Validations' do
    describe '#max_guest_greater_than_min_guests' do
      it 'invalid when min_guest greater than max_guests' do
        event = Event.new(min_guests: 10, max_guests: 5)
        event.valid?
        expect(event.errors.full_messages).to include('Número máximo de convidados precisa ser maior que' +
                                                        ' o número mínimo de convidados')
      end
      it 'invalid when min_guest equal than max_guests' do
        event = Event.new(min_guests: 10, max_guests: 10)
        event.valid?
        expect(event.errors.full_messages).to include('Número máximo de convidados precisa ser maior que' +
                                                        ' o número mínimo de convidados')
      end
      it 'valid when max_guests greater than min_guest' do
        event = Event.new(min_guests: 10, max_guests: 30)
        event.valid?
        expect(event.errors.full_messages).to_not include('Número máximo de convidados precisa ser maior que' +
                                                            ' o número mínimo de convidados')
      end
    end
  end
end
