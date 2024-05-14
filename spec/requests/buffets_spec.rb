require 'rails_helper'

RSpec.describe "Buffets", type: :request do
  describe "User edit's Buffet" do
    it "but doesn't own it" do
      payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
      first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                                 password: 'password1', role: :owner)
      first_buffet = Buffet.new(user: first_owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                                crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                                description: 'Description 1')
      first_buffet.payment_methods << payment_method_a
      first_buffet.payment_methods << payment_method_b
      first_buffet.save!
      Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                      state: 'State 1', city: 'City 1', zip: '11111', buffet: first_buffet)

      second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com',
                                  password: 'password2', role: :owner)
      second_buffet = Buffet.new(user: second_owner, brand_name: 'Buffet 2', company_name: 'Company 2',
                                 crn: '66.867.496/0001-03', phone: '222-222-2222', email: 'buffet2@example.com',
                                 description: 'Description 2')
      second_buffet.payment_methods << payment_method_a
      second_buffet.payment_methods << payment_method_b
      second_buffet.save!
      Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                      state: 'State 2', city: 'City 2', zip: '22222', buffet: second_buffet)

      login_as first_owner

      patch(owner_buffet_path(second_buffet.id), params: { buffet: { brand_name: "Deactivated Buffet" } })

      expect(response).to redirect_to(root_path)
    end

    it 'sucessfully' do
      payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
      first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                                 password: 'password1', role: :owner)
      first_buffet = Buffet.new(user: first_owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                                crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                                description: 'Description 1')
      first_buffet.payment_methods << payment_method_a
      first_buffet.payment_methods << payment_method_b
      first_buffet.save!
      Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                      state: 'State 1', city: 'City 1', zip: '11111', buffet: first_buffet)

      second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com',
                                  password: 'password2', role: :owner)
      second_buffet = Buffet.new(user: second_owner, brand_name: 'Buffet 2', company_name: 'Company 2',
                                 crn: '66.867.496/0001-03', phone: '222-222-2222', email: 'buffet2@example.com',
                                 description: 'Description 2')
      second_buffet.payment_methods << payment_method_a
      second_buffet.payment_methods << payment_method_b
      second_buffet.save!
      Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                      state: 'State 2', city: 'City 2', zip: '22222', buffet: second_buffet)

      login_as first_owner

      patch(owner_buffet_path(first_buffet.id), params: { buffet: { brand_name: "Deactivated Buffet" } })

      expect(response).to redirect_to(owner_buffet_path(first_buffet.id))
    end
  end

  describe "Buffet API" do
    context 'GET /api/v1/buffets' do
      it "and there's no buffets registered" do
        get '/api/v1/buffets'

        expect(response).to have_http_status 200
        expect(response.content_type).to include 'application/json'
        expect(response.body).to eq "[]"
      end

      it 'sucessfully' do
        payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
        payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
        first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                                   password: 'password1', role: :owner)
        first_buffet = Buffet.new(user: first_owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                                  crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                                  description: 'Description 1')
        first_buffet.payment_methods << payment_method_a
        first_buffet.payment_methods << payment_method_b
        first_buffet.save!
        Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                        state: 'State 1', city: 'City 1', zip: '11111', buffet: first_buffet)

        second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com',
                                    password: 'password2', role: :owner)
        second_buffet = Buffet.new(user: second_owner, brand_name: 'Buffet 2', company_name: 'Company 2',
                                   crn: '66.867.496/0001-03', phone: '222-222-2222', email: 'buffet2@example.com',
                                   description: 'Description 2')
        second_buffet.payment_methods << payment_method_a
        second_buffet.payment_methods << payment_method_b
        second_buffet.save!
        Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                        state: 'State 2', city: 'City 2', zip: '22222', buffet: second_buffet)

        get '/api/v1/buffets'

        expect(response).to have_http_status 200
        expect(response.content_type).to include 'application/json'

        json_response = JSON.parse(response.body)
        expect(json_response[0]['brand_name']).to eq 'Buffet 1'
        expect(json_response[0]['description']).to eq 'Description 1'
        expect(json_response[0]['company_name']).to eq 'Company 1'
        expect(json_response[0]['phone']).to eq '111-111-1111'
        expect(json_response[0]['email']).to eq 'buffet1@example.com'
        expect(json_response[0]['crn']).to eq '23.261.499/0001-96'
        expect(json_response[0]['user_id']).to eq 1

        expect(json_response[1]['brand_name']).to eq 'Buffet 2'
        expect(json_response[1]['description']).to eq 'Description 2'
        expect(json_response[1]['company_name']).to eq 'Company 2'
        expect(json_response[1]['phone']).to eq '222-222-2222'
        expect(json_response[1]['email']).to eq 'buffet2@example.com'
        expect(json_response[1]['crn']).to eq '66.867.496/0001-03'
        expect(json_response[1]['user_id']).to eq 2

        expect(json_response).not_to include 'created_at'
        expect(json_response).not_to include 'updates_at'
      end
    end

    context "GET /api/v1/buffets/search/:query" do
      it 'sucessfully' do
        payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
        payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
        first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                                   password: 'password1', role: :owner)
        first_buffet = Buffet.new(user: first_owner, brand_name: 'Buffet STAR', company_name: 'Company STAR',
                                  crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffetSTAR@example.com',
                                  description: 'Description STAR')
        first_buffet.payment_methods << payment_method_a
        first_buffet.payment_methods << payment_method_b
        first_buffet.save!
        Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                        state: 'State 1', city: 'City 1', zip: '11111', buffet: first_buffet)

        second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com',
                                    password: 'password2', role: :owner)
        second_buffet = Buffet.new(user: second_owner, brand_name: 'Buffet MOON', company_name: 'Company MOON',
                                   crn: '66.867.496/0001-03', phone: '222-222-2222', email: 'buffetMOON@example.com',
                                   description: 'Description MOON')
        second_buffet.payment_methods << payment_method_a
        second_buffet.payment_methods << payment_method_b
        second_buffet.save!
        Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                        state: 'State 2', city: 'City 2', zip: '22222', buffet: second_buffet)

        get "/api/v1/buffets/search/star"

        expect(response).to have_http_status 200
        expect(response.content_type).to eq 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response[0]['brand_name']).to eq 'Buffet STAR'
        expect(json_response[0]['description']).to eq 'Description STAR'
        expect(json_response[0]['company_name']).to eq 'Company STAR'
        expect(json_response[0]['phone']).to eq '111-111-1111'
        expect(json_response[0]['email']).to eq 'buffetSTAR@example.com'
        expect(json_response).not_to include 'Buffet MOON'
        expect(json_response).not_to include 'Company MOON'
        expect(json_response).not_to include '222-222-2222'
        expect(json_response).not_to include 'buffetMOON@example.com'
        expect(json_response).not_to include 'Description MOON'
      end

      it 'return 404 if not found' do
        get "/api/v1/buffets/search/star"

        expect(response).to have_http_status 404
        expect(response.content_type).to eq 'application/json'
        expect(response.body).to eq '{}'
      end
    end

    context 'GET /api/v1/buffets/:id/events' do
      it 'successfully' do
        payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
        payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
        owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                             password: 'password1', role: :owner)
        buffet = Buffet.new(user: owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                            crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                            description: 'Description 1')
        buffet.payment_methods << payment_method_a
        buffet.payment_methods << payment_method_b
        buffet.save!
        Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                        state: 'State 1', city: 'City 1', zip: '11111', buffet: buffet)

        first_event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: buffet,
                                    min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu 1',
                                    offsite_event: true, offers_alcohol: true, offers_decoration: true,
                                    offers_valet_parking: true)
        EventPrice.create!(event: first_event, standard_price: 1000, extra_guest_price: 100,
                           extra_hour_price: 50, day_type: :weekday)
        EventPrice.create!(event: first_event, standard_price: 1500, extra_guest_price: 150,
                           extra_hour_price: 75, day_type: :weekend)
        second_event = Event.create!(name: 'Event 2', description: 'Description 2', buffet: buffet,
                                     min_guests: 10, max_guests: 100, standard_duration: 600, menu: 'Menu 2',
                                     offsite_event: false, offers_alcohol: true, offers_decoration: true,
                                     offers_valet_parking: true)
        EventPrice.create!(event: second_event, standard_price: 2000, extra_guest_price: 200,
                           extra_hour_price: 100, day_type: :weekday)
        EventPrice.create!(event: second_event, standard_price: 2500, extra_guest_price: 250,
                           extra_hour_price: 125, day_type: :weekend)

        get "/api/v1/buffets/1/events"

        expect(response).to have_http_status 200
        json_response = JSON.parse(response.body)
        expect(json_response[0]['name']).to eq 'Event 1'
        expect(json_response[0]['description']).to eq 'Description 1'
        expect(json_response[0]['buffet_id']).to eq 1
        expect(json_response[0]['min_guests']).to eq 10
        expect(json_response[0]['max_guests']).to eq 100
        expect(json_response[0]['standard_duration']).to eq 300
        expect(json_response[0]['menu']).to eq 'Menu 1'
        expect(json_response[0]['offsite_event']).to eq true
        expect(json_response[0]['offers_alcohol']).to eq true
        expect(json_response[0]['offers_decoration']).to eq true
        expect(json_response[0]['offers_valet_parking']).to eq true
        expect(json_response[0]['event_prices'][0]['id']).to eq 1
        expect(json_response[0]['event_prices'][0]['standard_price']).to eq 1000
        expect(json_response[0]['event_prices'][0]['extra_guest_price']).to eq 100
        expect(json_response[0]['event_prices'][0]['extra_hour_price']).to eq 50
        expect(json_response[0]['event_prices'][0]['day_type']).to eq 'weekday'
        expect(json_response[0]['event_prices'][0]['event_id']).to eq 1
        expect(json_response[0]['event_prices'][1]['id']).to eq 2
        expect(json_response[0]['event_prices'][1]['standard_price']).to eq 1500
        expect(json_response[0]['event_prices'][1]['extra_guest_price']).to eq 150
        expect(json_response[0]['event_prices'][1]['extra_hour_price']).to eq 75
        expect(json_response[0]['event_prices'][1]['day_type']).to eq 'weekend'
        expect(json_response[0]['event_prices'][1]['event_id']).to eq  1

        expect(json_response[1]['name']).to eq 'Event 2'
        expect(json_response[1]['description']).to eq 'Description 2'
        expect(json_response[1]['buffet_id']).to eq 1
        expect(json_response[1]['min_guests']).to eq 10
        expect(json_response[1]['max_guests']).to eq 100
        expect(json_response[1]['standard_duration']).to eq 600
        expect(json_response[1]['menu']).to eq 'Menu 2'
        expect(json_response[1]['offsite_event']).to eq false
        expect(json_response[1]['offers_alcohol']).to eq true
        expect(json_response[1]['offers_decoration']).to eq true
        expect(json_response[1]['offers_valet_parking']).to eq true
        expect(json_response[1]['event_prices'][0]['id']).to eq 3
        expect(json_response[1]['event_prices'][0]['standard_price']).to eq 2000
        expect(json_response[1]['event_prices'][0]['extra_guest_price']).to eq 200
        expect(json_response[1]['event_prices'][0]['extra_hour_price']).to eq 100
        expect(json_response[1]['event_prices'][0]['day_type']).to eq 'weekday'
        expect(json_response[1]['event_prices'][0]['event_id']).to eq 2
        expect(json_response[1]['event_prices'][1]['id']).to eq 4
        expect(json_response[1]['event_prices'][1]['standard_price']).to eq 2500
        expect(json_response[1]['event_prices'][1]['extra_guest_price']).to eq 250
        expect(json_response[1]['event_prices'][1]['extra_hour_price']).to eq 125
        expect(json_response[1]['event_prices'][1]['day_type']).to eq 'weekend'
        expect(json_response[1]['event_prices'][1]['event_id']).to eq 2
      end

      it 'return 404 if not found' do
        get '/api/v1/buffets/250/events'

        expect(response).to have_http_status 404
      end
    end

    context "GET '/api/v1/buffets/:id" do
      it 'User sees buffet details, except CRN and Company Name' do
        payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
        payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
        owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                             password: 'password1', role: :owner)
        buffet = Buffet.new(user: owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                            crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                            description: 'Description 1')
        buffet.payment_methods << payment_method_a
        buffet.payment_methods << payment_method_b
        buffet.save!

        Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                        state: 'State 1', city: 'City 1', zip: '11111', buffet: buffet)

        get '/api/v1/buffets/1'

        expect(response).to have_http_status 200
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response['brand_name']).to eq 'Buffet 1'
        expect(json_response['description']).to eq 'Description 1'
        expect(json_response['phone']).to eq '111-111-1111'
        expect(json_response['email']).to eq 'buffet1@example.com'
        expect(json_response['user_id']).to eq 1
        expect(json_response['address']['street_name']).to eq 'Street 1'
        expect(json_response['address']['neighborhood']).to eq 'Neighborhood 1'
        expect(json_response['address']['house_or_lot_number']).to eq '1'
        expect(json_response['address']['state']).to eq 'State 1'
        expect(json_response['address']['city']).to eq 'City 1'
        expect(json_response['address']['zip']).to eq '11111'
        expect(json_response['address']['buffet_id']).to eq 1
      end

      it 'return 404 if buffet is not found' do
        payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
        payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
        owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                             password: 'password1', role: :owner)
        buffet = Buffet.new(user: owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                            crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                            description: 'Description 1')
        buffet.payment_methods << payment_method_a
        buffet.payment_methods << payment_method_b
        buffet.save!

        Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                        state: 'State 1', city: 'City 1', zip: '11111', buffet: buffet)

        first_event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: buffet,
                                    min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu 1',
                                    offsite_event: true, offers_alcohol: true, offers_decoration: true,
                                    offers_valet_parking: true)
        EventPrice.create!(event: first_event, standard_price: 1000, extra_guest_price: 100,
                           extra_hour_price: 50, day_type: :weekday)
        EventPrice.create!(event: first_event, standard_price: 1500, extra_guest_price: 150,
                           extra_hour_price: 75, day_type: :weekend)
        second_event = Event.create!(name: 'Event 2', description: 'Description 2', buffet: buffet,
                                     min_guests: 10, max_guests: 100, standard_duration: 600, menu: 'Menu 2',
                                     offsite_event: false, offers_alcohol: true, offers_decoration: true,
                                     offers_valet_parking: true)
        EventPrice.create!(event: second_event, standard_price: 2000, extra_guest_price: 200,
                           extra_hour_price: 100, day_type: :weekday)
        EventPrice.create!(event: second_event, standard_price: 2500, extra_guest_price: 250,
                           extra_hour_price: 125, day_type: :weekend)

        get '/api/v1/buffets/15'

        expect(response).to have_http_status 404
        expect(response.body).not_to include 'brand_name'
        expect(response.body).not_to include 'phone'
        expect(response.body).not_to include 'email'
        expect(response.body).not_to include 'user_id'
        expect(response.body).not_to include 'address'
      end
    end

    context "GET /api/v1/buffets/:buffet_id/:event_id/:event_date/:total_guests" do
      it 'successfully' do
        payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
        payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
        owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                             password: 'password1', role: :owner)
        buffet = Buffet.new(user: owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                            crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                            description: 'Description 1')
        buffet.payment_methods << payment_method_a
        buffet.payment_methods << payment_method_b
        buffet.save!
        Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                        state: 'State 1', city: 'City 1', zip: '11111', buffet: buffet)

        first_event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: buffet,
                                    min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu 1',
                                    offsite_event: true, offers_alcohol: true, offers_decoration: true,
                                    offers_valet_parking: true)
        EventPrice.create!(event: first_event, standard_price: 1000, extra_guest_price: 100,
                           extra_hour_price: 50, day_type: :weekday)
        EventPrice.create!(event: first_event, standard_price: 1500, extra_guest_price: 150,
                           extra_hour_price: 75, day_type: :weekend)
        second_event = Event.create!(name: 'Event 2', description: 'Description 2', buffet: buffet,
                                     min_guests: 10, max_guests: 100, standard_duration: 600, menu: 'Menu 2',
                                     offsite_event: false, offers_alcohol: true, offers_decoration: true,
                                     offers_valet_parking: true)
        EventPrice.create!(event: second_event, standard_price: 2000, extra_guest_price: 200,
                           extra_hour_price: 100, day_type: :weekday)
        EventPrice.create!(event: second_event, standard_price: 2500, extra_guest_price: 250,
                           extra_hour_price: 125, day_type: :weekend)


        get "/api/v1/buffets/1/1/#{7.days.from_now.next_weekday.to_date}/100"

        expect(response).to have_http_status 200
        json_response = JSON.parse(response.body)

        expect(json_response['price']).to eq 10_000
      end

      describe 'return 404' do
        it "if buffet doesn't exist" do
          get "/api/v1/buffets/1235/1/#{7.days.from_now.next_weekday.to_date}/100"

          expect(response).to have_http_status 404
        end

        it "if event type doesn't exist" do
          get "/api/v1/buffets/1/12345/#{7.days.from_now.next_weekday.to_date}/100"

          expect(response).to have_http_status 404
        end
      end

      describe "return an error message if unavailable" do
        it "because of same date event" do
          owner = User.create!(name: 'Fabrício', email: 'owner@example.com', password: 'password1', role: :owner)
          payment_method_a = PaymentMethod.create!(name: 'Pix')
          payment_method_b = PaymentMethod.create!(name: 'Cartão de crédito')
          buffet = Buffet.new(user_id: owner.id, brand_name: 'Buffet 1', company_name: 'Company 1',
                              crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                              description: 'Description 1')
          buffet.payment_methods << payment_method_a
          buffet.payment_methods << payment_method_b
          buffet.save!
          Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                          state: 'State 1', city: 'City 1', zip: '11111', buffet_id: buffet.id)
          event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: buffet,
                                min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu 1',
                                offsite_event: true, offers_alcohol: true, offers_decoration: true,
                                offers_valet_parking: true)
          EventPrice.create!(event: event, standard_price: 1000, extra_guest_price: 100,
                             extra_hour_price: 50, day_type: :weekday)
          EventPrice.create!(event: event, standard_price: 1500, extra_guest_price: 150,
                             extra_hour_price: 75, day_type: :weekend)
          client = User.create!(email: 'first_client@client.com', password: 'password', name: "Client ONE",
                                role: :client, cpf: "068.302.130-37")
          allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO01')
          Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 50,
                        address: "Rua 1, Bairro 1, 1", event_date: 1.month.from_now.next_weekday, price: 5000,
                        additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1",
                        status: :confirmed, confirmation_date: 2.days.from_now, payment_method: payment_method_a)

          get "/api/v1/buffets/1/1/#{1.month.from_now.next_weekday.to_date}/100"

          expect(response).to have_http_status 200
          json_response = JSON.parse(response.body)
          expect(json_response).to include 'error'
          expect(json_response['error']).to eq "Data indisponível"
        end

        it "because total guests is greater than maximum guests" do
          owner = User.create!(name: 'Fabrício', email: 'owner@example.com', password: 'password1', role: :owner)
          payment_method_a = PaymentMethod.create!(name: 'Pix')
          payment_method_b = PaymentMethod.create!(name: 'Cartão de crédito')
          buffet = Buffet.new(user_id: owner.id, brand_name: 'Buffet 1', company_name: 'Company 1',
                              crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                              description: 'Description 1')
          buffet.payment_methods << payment_method_a
          buffet.payment_methods << payment_method_b
          buffet.save!
          Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                          state: 'State 1', city: 'City 1', zip: '11111', buffet_id: buffet.id)
          event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: buffet,
                                min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu 1',
                                offsite_event: true, offers_alcohol: true, offers_decoration: true,
                                offers_valet_parking: true)
          EventPrice.create!(event: event, standard_price: 1000, extra_guest_price: 100,
                             extra_hour_price: 50, day_type: :weekday)
          EventPrice.create!(event: event, standard_price: 1500, extra_guest_price: 150,
                             extra_hour_price: 75, day_type: :weekend)

          get "/api/v1/buffets/1/1/#{7.days.from_now.next_weekday.to_date}/200"

          expect(response).to have_http_status 412
          json_response = JSON.parse(response.body)
          expect(json_response).to include 'error'
          expect(json_response['error'][0]).to eq "Número de convidados deve estar entre 1 e #{event.max_guests}"
        end

        context "because event date" do
          it 'is in the past' do
            owner = User.create!(name: 'Fabrício', email: 'owner@example.com', password: 'password1', role: :owner)
            payment_method_a = PaymentMethod.create!(name: 'Pix')
            payment_method_b = PaymentMethod.create!(name: 'Cartão de crédito')
            buffet = Buffet.new(user_id: owner.id, brand_name: 'Buffet 1', company_name: 'Company 1',
                                crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                                description: 'Description 1')
            buffet.payment_methods << payment_method_a
            buffet.payment_methods << payment_method_b
            buffet.save!
            Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                            state: 'State 1', city: 'City 1', zip: '11111', buffet_id: buffet.id)
            event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: buffet,
                                  min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu 1',
                                  offsite_event: true, offers_alcohol: true, offers_decoration: true,
                                  offers_valet_parking: true)
            EventPrice.create!(event: event, standard_price: 1000, extra_guest_price: 100,
                               extra_hour_price: 50, day_type: :weekday)
            EventPrice.create!(event: event, standard_price: 1500, extra_guest_price: 150,
                               extra_hour_price: 75, day_type: :weekend)

            get "/api/v1/buffets/1/1/1999-12-21/100"

            expect(response).to have_http_status 412
            json_response = JSON.parse(response.body)
            expect(json_response).to include 'error'
            expect(json_response['error'][0]).to eq "Data do evento não pode estar no passado"
          end

          it 'is invalid' do
            owner = User.create!(name: 'Fabrício', email: 'owner@example.com', password: 'password1', role: :owner)
            payment_method_a = PaymentMethod.create!(name: 'Pix')
            payment_method_b = PaymentMethod.create!(name: 'Cartão de crédito')
            buffet = Buffet.new(user_id: owner.id, brand_name: 'Buffet 1', company_name: 'Company 1',
                                crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                                description: 'Description 1')
            buffet.payment_methods << payment_method_a
            buffet.payment_methods << payment_method_b
            buffet.save!
            Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                            state: 'State 1', city: 'City 1', zip: '11111', buffet_id: buffet.id)
            event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: buffet,
                                  min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu 1',
                                  offsite_event: true, offers_alcohol: true, offers_decoration: true,
                                  offers_valet_parking: true)
            EventPrice.create!(event: event, standard_price: 1000, extra_guest_price: 100,
                               extra_hour_price: 50, day_type: :weekday)
            EventPrice.create!(event: event, standard_price: 1500, extra_guest_price: 150,
                               extra_hour_price: 75, day_type: :weekend)

            get "/api/v1/buffets/1/1/2124-50-693/100"

            expect(response).to have_http_status 412
            json_response = JSON.parse(response.body)
            expect(json_response).to include 'error'
            expect(json_response['error']).to eq "Data inválida"
          end
        end
      end
    end
  end
end
