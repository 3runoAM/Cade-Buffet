require 'rails_helper'

RSpec.describe "EventPrices", type: :request do
  describe "User creates Event Price" do
    it "but doesn't owns the Buffet that holds the Event" do
      payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')

      first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com', password: 'password1', role: :owner)
      first_buffet = Buffet.new(user: first_owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                                crn: '123456', phone: '111-111-1111', email: 'buffet1@example.com',
                                description: 'Description 1')
      first_buffet.payment_methods << payment_method_a
      first_buffet.payment_methods << payment_method_b
      first_buffet.save!
      Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                     state: 'State 1', city: 'City 1', zip: '11111', buffet: first_buffet)

      second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com', password: 'password2', role: :owner)
      second_buffet = Buffet.new(user: second_owner, brand_name: 'Buffet 2', company_name: 'Company 2',
                                 crn: '654321', phone: '222-222-2222', email: 'buffet2@example.com',
                                 description: 'Description 2')
      second_buffet.payment_methods << payment_method_a
      second_buffet.payment_methods << payment_method_b
      second_buffet.save!
      Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                      state: 'State 2', city: 'City 2', zip: '22222', buffet: second_buffet)

      event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: second_buffet,
                            min_guests: 10, max_guests: 100, standard_duration: 400, menu: 'Menu 1',
                            offsite_event: false, offers_alcohol: true, offers_decoration: true,
                            offers_valet_parking: true)

      login_as first_owner

      post owner_event_prices_path params: { event_price: {standard_price: 5000,
                                  extra_guest_price: 200, extra_hour_price: 100, day_type: 0, event_id: event.id}}

      expect(response).to redirect_to(owner_dashboards_path)
    end
  end
end