require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe '#valid?' do
    it 'invalid without Owner' do
      buffet = Buffet.new(brand_name: 'Buffet 1', company_name: 'Company 1', crn: '123456',
                          phone: '111-111-1111', email: 'buffet1@example.com',
                         description: 'Description 1')

      expect(buffet).not_to be_valid
    end

    it 'invalid without brand name' do
      owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com', password: 'password1',
                           role: :owner)

      buffet = Buffet.new(user_id: owner.id, company_name: 'Company 1', crn: '123456', phone: '111-111-1111',
                          email: 'buffet1@example.com', description: 'Description 1')
      expect(buffet).not_to be_valid
    end

    it 'invalid without company name' do
      owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com', password: 'password1',
                           role: :owner)
      buffet = Buffet.new(user_id: owner.id, brand_name: 'Name 1', crn: '123456', phone: '111-111-1111',
                          email: 'buffet1@example.com', description: 'Description 1')

      expect(buffet).not_to be_valid
    end

    it "invalid without company's CRN" do
      owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com', password: 'password1',
                           role: :owner)

      buffet = Buffet.new(user_id: owner.id, brand_name: 'Name 1',company_name: 'Company 1', phone: '111-111-1111',
                          email: 'buffet1@example.com', description: 'Description 1')

      expect(buffet).not_to be_valid
    end
  end
end