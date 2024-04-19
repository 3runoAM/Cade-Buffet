require 'rails_helper'

RSpec.describe EventPrice, type: :model do
  context 'Validations' do
    describe "standard_price can't be blank" do
      it 'invalid' do
        event_price = EventPrice.new(extra_guest_price: 100, extra_hour_price: 100, day_type: 0,
                                     event_id: 1)

        event_price.valid?

        expect(event_price.errors).to include :standard_price
      end
      it 'valid' do
        event_price = EventPrice.new(standard_price: 1000, extra_guest_price: 100, extra_hour_price: 100,
                                     day_type: 0, event_id: 1)

        event_price.valid?

        expect(event_price.errors).not_to include :standard_price
      end
    end

    describe "extra_hour_price can't be blank" do
      it 'invalid' do
        event_price = EventPrice.new(standard_price: 1000, extra_guest_price: 100, day_type: 0, event_id: 1)

        event_price.valid?

        expect(event_price.errors).to include :extra_hour_price
      end
      it 'valid' do
        event_price = EventPrice.new(standard_price: 1000, extra_guest_price: 100, extra_hour_price: 100,
                                     day_type: 0, event_id: 1)

        event_price.valid?

        expect(event_price.errors).not_to include :extra_hour_price
      end
    end

    describe "extra_guest_price can't be blank" do
      it 'invalid' do
        event_price = EventPrice.new(standard_price: 1000, extra_hour_price: 100, day_type: 0, event_id: 1)

        event_price.valid?

        expect(event_price.errors).to include :extra_guest_price
      end
      it 'valid' do
        event_price = EventPrice.new(standard_price: 1000 , extra_guest_price: 100, extra_hour_price: 100,
                                     day_type: 0, event_id: 1)

        event_price.valid?

        expect(event_price.errors).not_to include :extra_guest_price
      end
    end

    describe "day_type can't be blank" do
      it 'invalid' do
        event_price = EventPrice.new(standard_price: 1000, extra_hour_price: 100, event_id: 1)

        event_price.valid?

        expect(event_price.errors).to include :day_type
      end
      it 'valid' do
        event_price = EventPrice.new(standard_price: 1000 , extra_guest_price: 100, extra_hour_price: 100,
                                     day_type: 0, event_id: 1)

        event_price.valid?

        expect(event_price.errors).not_to include :day_type
      end
    end
  end
  context "uniqueness" do
    describe "For a given event, day_type must be unique in EventPrice" do
      it "invalid" do
        user = User.create!(email: "teste@teste.com", password: "senha123", name: "Teste", role: :owner)
        buffet = Buffet.new(user: user, brand_name: "Buffet Teste", company_name: "Empresa Teste", crn: "123456",
                            phone: "11999999999", email: "buffet@teste.com", description: "Um teste")
        buffet.payment_methods << PaymentMethod.create!(name: "Dinheiro")
        buffet.payment_methods << PaymentMethod.create!(name: "Pix")
        buffet.save!

        event = Event.create!(name: "Evento Teste", description: "Descrição Teste", min_guests: 10, max_guests: 30,
                              standard_duration: 3, menu: "Menu Teste", offsite_event: false, offers_alcohol: true,
                              offers_decoration: true, offers_valet_parking: false, buffet: buffet)

        first_event_price = EventPrice.create!(standard_price: 100, extra_guest_price: 10, extra_hour_price: 20,
                                               day_type: 1, event: event)
        second_event_price = EventPrice.new(standard_price: 200, extra_guest_price: 20, extra_hour_price: 40,
                                            day_type: 1, event: event)

        second_event_price.valid?

        expect(second_event_price.errors).to include :day_type
      end
      it "valid" do
        user = User.create!(email: "teste@teste.com", password: "senha123", name: "Teste", role: :owner)
        buffet = Buffet.new(user: user, brand_name: "Buffet Teste", company_name: "Empresa Teste", crn: "123456",
                            phone: "11999999999", email: "buffet@teste.com", description: "Um teste")
        buffet.payment_methods << PaymentMethod.create!(name: "Dinheiro")
        buffet.payment_methods << PaymentMethod.create!(name: "Pix")
        buffet.save!

        event = Event.create!(name: "Evento Teste", description: "Descrição Teste", min_guests: 10, max_guests: 30,
                              standard_duration: 3, menu: "Menu Teste", offsite_event: false, offers_alcohol: true,
                              offers_decoration: true, offers_valet_parking: false, buffet: buffet)

        first_event_price = EventPrice.create!(standard_price: 100, extra_guest_price: 10, extra_hour_price: 20,
                                               day_type: 1, event: event)
        second_event_price = EventPrice.new(standard_price: 200, extra_guest_price: 20, extra_hour_price: 40,
                                            day_type: 0, event: event)

        second_event_price.valid?

        expect(second_event_price.errors).not_to include :day_type
      end
    end
  end
end