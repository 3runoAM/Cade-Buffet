require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid" do
    it 'should be valid' do
      client = User.new(name: "Mateus Alves", email: 'example@example.com', password: 'password',
                        cpf: '592.428.200-75', role: :client)

      expect(client).to be_valid
    end

    it "is invalid with an invalid email" do
      owner = User.new(name: "Mateus Alves", email: 'email', password: 'password', role: :owner)

      expect(owner).not_to be_valid
    end

    it 'is invalid with a non-existent role' do
      expect {
        User.new(name: "Mateus Alves", email: 'invalid', password: 'password', role: :adm)
      }.to raise_error(ArgumentError)
    end

    it 'invalid with invalid CPF if client' do
      client = User.new(name: "Mateus Alves", email: 'email', password: 'password',
                        cpf: 0000, role: :client)

      expect(client).not_to be_valid
      expect(client.errors).to include :cpf
    end

    it 'invalid if CPF already registered' do
      first_client = User.create(name: "Mateus Alves", email: 'example@example.com', password: 'password',
                        cpf: '000.000.000-00', role: :client)

      second_client = User.new(name: "Fulano Beltrano", email: 'fulano@email.com', password: '123456',
                               cpf: '000.000.000-00', role: :client)

      expect(second_client).not_to be_valid
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

    it 'should have CPF if client' do
      client = User.new(name: "Mateus Alves", email: 'email', password: 'password', role: :client)

      expect(client).not_to be_valid
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
