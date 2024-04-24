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
end