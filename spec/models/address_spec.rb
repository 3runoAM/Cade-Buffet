require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '#valid?' do
    it 'invalid without street_name' do
      payment_method1 = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method2 = PaymentMethod.create!(name: 'Payment Method 2')
      owner = User.create!(email: 'owner1@example.com', password: 'password1', role: 0, name: 'Owner 1')

      buffet = Buffet.new(user_id: owner.id, brand_name: 'Buffet 1', company_name: 'Company 1', crn: '123456',
                          phone: '111-111-1111', email: 'buffet1@example.com', description: 'Description 1')

      buffet.payment_methods << payment_method1
      buffet.payment_methods << payment_method2

      buffet.save!

      address1 = Address.new(neighborhood: 'Neighborhood 1', house_or_lot_number: '1', state: 'State 1',
                             city: 'City 1', zip: '11111', buffet_id: buffet.id)

      expect(address1).not_to be_valid
    end

    it 'invalid without neighborhood' do
      payment_method1 = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method2 = PaymentMethod.create!(name: 'Payment Method 2')
      owner = User.create!(email: 'owner1@example.com', password: 'password1', role: 0, name: 'Owner 1')

      buffet = Buffet.new(user_id: owner.id, brand_name: 'Buffet 1', company_name: 'Company 1', crn: '123456',
                          phone: '111-111-1111', email: 'buffet1@example.com', description: 'Description 1')

      buffet.payment_methods << payment_method1
      buffet.payment_methods << payment_method2

      buffet.save!
      address1 = Address.new(street_name: 'Street 1', house_or_lot_number: '1',
                                 state: 'State 1', city: 'City 1', zip: '11111', buffet_id: buffet.id)

      expect(address1).not_to be_valid
    end

    it 'invalid without house_or_lot_number' do
      payment_method1 = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method2 = PaymentMethod.create!(name: 'Payment Method 2')
      owner = User.create!(email: 'owner1@example.com', password: 'password1', role: 0, name: 'Owner 1')

      buffet = Buffet.new(user_id: owner.id, brand_name: 'Buffet 1', company_name: 'Company 1', crn: '123456',
                          phone: '111-111-1111', email: 'buffet1@example.com', description: 'Description 1')

      buffet.payment_methods << payment_method1
      buffet.payment_methods << payment_method2

      buffet.save!
      address1 = Address.new(street_name: 'Street 1', neighborhood: 'Neighborhood 1', state: 'State 1',
                                 city: 'City 1', zip: '11111', buffet_id: buffet.id)

      expect(address1).not_to be_valid
    end

    it 'invalid without state' do
      payment_method1 = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method2 = PaymentMethod.create!(name: 'Payment Method 2')
      owner = User.create!(email: 'owner1@example.com', password: 'password1', role: 0, name: 'Owner 1')

      buffet = Buffet.new(user_id: owner.id, brand_name: 'Buffet 1', company_name: 'Company 1', crn: '123456',
                          phone: '111-111-1111', email: 'buffet1@example.com', description: 'Description 1')

      buffet.payment_methods << payment_method1
      buffet.payment_methods << payment_method2

      buffet.save!
      address1 = Address.new(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                                city: 'City 1', zip: '11111', buffet_id: buffet.id)

      expect(address1).not_to be_valid
    end

    it 'invalid without city' do
      payment_method1 = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method2 = PaymentMethod.create!(name: 'Payment Method 2')
      owner = User.create!(email: 'owner1@example.com', password: 'password1', role: 0, name: 'Owner 1')

      buffet = Buffet.new(user_id: owner.id, brand_name: 'Buffet 1', company_name: 'Company 1', crn: '123456',
                          phone: '111-111-1111', email: 'buffet1@example.com', description: 'Description 1')

      buffet.payment_methods << payment_method1
      buffet.payment_methods << payment_method2

      buffet.save!
      address1 = Address.new(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                                 state: 'State 1',  zip: '11111', buffet_id: buffet.id)

      expect(address1).not_to be_valid
    end

    it 'invalid without zip' do
      payment_method1 = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method2 = PaymentMethod.create!(name: 'Payment Method 2')
      owner = User.create!(email: 'owner1@example.com', password: 'password1', role: 0, name: 'Owner 1')

      buffet = Buffet.new(user_id: owner.id, brand_name: 'Buffet 1', company_name: 'Company 1', crn: '123456',
                          phone: '111-111-1111', email: 'buffet1@example.com', description: 'Description 1')

      buffet.payment_methods << payment_method1
      buffet.payment_methods << payment_method2

      buffet.save!
      address1 = Address.new(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                                 state: 'State 1', city: 'City 1', buffet_id: buffet.id)

      expect(address1).not_to be_valid
    end
  end
  describe '#full_address' do
    it 'returns full address' do
      owner = User.create!(name: 'Owner 1', email: 'example@example.com', password: 'password1', role: :owner)
      payment_method1 = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method2 = PaymentMethod.create!(name: 'Payment Method 2')
      buffet = Buffet.new(user: owner, brand_name: 'Buffet 1', company_name: 'Company 1', crn: '123456',
                              phone: '111-111-1111', email: 'email@email.com', description: 'Description')
      buffet.payment_methods << payment_method1
      buffet.payment_methods << payment_method2
      buffet.save!
      address = Address.new(buffet: buffet, street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                           city: 'City 1', state: 'State 1', zip: '11111')

      expect(address.full_address).to eq('Street 1, 1, Neighborhood 1, City 1 - State 1, 11111')
    end
  end
end