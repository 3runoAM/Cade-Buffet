require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid" do
    it "is invalid with an invalid email" do
      owner = User.new(name: "Mateus Alves", email: 'email', password: 'password', role: :owner)

      expect(owner).not_to be_valid
    end

    it 'is invalid with a non-existent role' do
      expect {
        User.new(name: "Mateus Alves", email: 'invalid', password: 'password', role: :adm)
      }.to raise_error(ArgumentError)
    end

    it 'should be valid' do
      owner = User.new(name: "Mateus Alves", email: 'example@example.com', password: 'password', role: :client)

      expect(owner).to be_valid
    end
  end

  describe "#presence" do
    it 'should have a name' do
      owner = User.new(email: 'email', password: 'password', role: :owner)

      expect(owner).not_to be_valid
    end

    it 'should have an email' do
      owner = User.new(name: "Mateus Alves", password: 'password', role: :client)

      expect(owner).not_to be_valid
    end
  end

  describe ".role_options" do
    it 'should translate properly' do
      role_options = User.role_options

      expect(role_options.first).to eq ["client", "Cliente"]
      expect(role_options.second).to eq ["owner", "Proprietário de Buffet"]
    end
  end
end
