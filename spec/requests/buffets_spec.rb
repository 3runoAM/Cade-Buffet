require 'rails_helper'

RSpec.describe "Buffets", type: :request do
  describe "User edit's Buffet" do
    it "but doesn't own it" do
      first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com', password: 'password1', role: :owner)
      second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com', password: 'password2', role: :owner)

      first_buffet = Buffet.create!(user_id: first_owner.id, brand_name: 'Buffet 1', company_name: 'Company 1',
                                    crn: '123456', phone: '111-111-1111', email: 'buffet1@example.com',
                                    description: 'Description 1')
      second_buffet = Buffet.create!(user_id: second_owner.id, brand_name: 'Buffet 2', company_name: 'Company 2',
                                     crn: '654321', phone: '222-222-2222', email: 'buffet2@example.com',
                                     description: 'Description 2')

      Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                      state: 'State 1', city: 'City 1', zip: '11111', buffet_id: first_buffet.id)
      Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                      state: 'State 2', city: 'City 2', zip: '22222', buffet_id: second_buffet.id)

      payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
      BuffetPaymentMethod.create!(payment_method_id: payment_method_a.id, buffet_id: first_buffet.id)
      BuffetPaymentMethod.create!(payment_method_id: payment_method_b.id, buffet_id: second_buffet.id)

      login_as(first_owner, :scope => :user)

      patch(buffet_path(second_buffet.id), params: { buffet: { brand_name: "Deactivated Buffet" } })

      expect(response).to redirect_to(root_path)
    end
  end
end
