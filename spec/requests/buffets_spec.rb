require 'rails_helper'

RSpec.describe "Buffets", type: :request do
  describe "User edit's Buffet" do
    it "but doesn't own it" do
      first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com', password: 'password1', role: :owner)
      second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com', password: 'password2', role: :owner)

      payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')

      first_buffet = Buffet.new(user_id: first_owner.id, brand_name: 'Buffet 1', company_name: 'Company 1',
                                crn: '39.359.775/0001-93', phone: '111-111-1111', email: 'buffet1@example.com',
                                description: 'Description 1')
      first_buffet.payment_methods << payment_method_a
      first_buffet.payment_methods << payment_method_b
      first_buffet.save!

      second_buffet = Buffet.new(user_id: second_owner.id, brand_name: 'Buffet 2', company_name: 'Company 2',
                                 crn: '94.985.368/0001-08', phone: '222-222-2222', email: 'buffet2@example.com',
                                 description: 'Description 2')
      second_buffet.payment_methods << payment_method_b
      second_buffet.save!

      Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                      state: 'State 1', city: 'City 1', zip: '11111', buffet_id: first_buffet.id)
      Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                      state: 'State 2', city: 'City 2', zip: '22222', buffet_id: second_buffet.id)

      login_as first_owner

      patch(owner_buffet_path(second_buffet.id), params: { buffet: { brand_name: "Deactivated Buffet" } })

      expect(response).to redirect_to(root_path)
    end

    it 'sucessfully' do
      first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com', password: 'password1', role: :owner)
      second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com', password: 'password2', role: :owner)

      payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')

      first_buffet = Buffet.new(user_id: first_owner.id, brand_name: 'Buffet 1', company_name: 'Company 1',
                                crn: '94.985.368/0001-08', phone: '111-111-1111', email: 'buffet1@example.com',
                                description: 'Description 1')
      first_buffet.payment_methods << payment_method_a
      first_buffet.payment_methods << payment_method_b
      first_buffet.save!

      second_buffet = Buffet.new(user_id: second_owner.id, brand_name: 'Buffet 2', company_name: 'Company 2',
                                 crn: '59.182.557/0001-33', phone: '222-222-2222', email: 'buffet2@example.com',
                                 description: 'Description 2')
      second_buffet.payment_methods << payment_method_b
      second_buffet.save!

      Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                      state: 'State 1', city: 'City 1', zip: '11111', buffet_id: first_buffet.id)
      Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                      state: 'State 2', city: 'City 2', zip: '22222', buffet_id: second_buffet.id)

      login_as first_owner

      patch(owner_buffet_path(first_buffet.id), params: { buffet: { brand_name: "Deactivated Buffet" } })

      expect(response).to redirect_to(owner_buffet_path(first_buffet.id))
    end
  end

  context "Search for buffets" do
    it 'and return all of them' do
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

      get api_v1_buffets_path

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)
      expect(json_response[0]['brand_name']).to eq 'Buffet 1'
      expect(json_response[0]['description']).to eq 'Description 1'
      expect(json_response[0]['company_name']).to eq 'Company 1'
      expect(json_response[0]['phone']).to eq '111-111-1111'
      expect(json_response[0]['email']).to eq 'buffet1@example.com'
      expect(json_response[1]['brand_name']).to eq 'Buffet 2'
      expect(json_response[1]['description']).to eq 'Description 2'
      expect(json_response[1]['company_name']).to eq 'Company 2'
      expect(json_response[1]['phone']).to eq '222-222-2222'
      expect(json_response[1]['email']).to eq 'buffet2@example.com'

      expect(json_response).not_to include 'user_id'
      expect(json_response).not_to include 'crn'
      expect(json_response).not_to include 'created_at'
      expect(json_response).not_to include 'updates_at'
    end

    # it 'with a name' do
    #
    # end
  end
end