require 'rails_helper'

RSpec.describe "Order", type: :request do
  describe "Clients try to se information about order" do
    it "but doesn't own it" do
      first_buffet, second_buffet, first_event, second_event = create_buffets_with_events
      first_client = User.create!(email: 'first_client@client.com', password: 'password', name: "Client ONE",
                                  role: :client, cpf: "068.302.130-37")
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO12')
      first_order = Order.create!(user_id: first_client.id, event: first_event, buffet: first_buffet, total_guests: 50,
                    address: "Rua 1, Bairro 1, 1", event_date: 1.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês")

      second_client = User.create!(email: 'second_client@client.com', password: 'password', name: "Client TWO",
                                   role: :client, cpf: "485.055.690-67")
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO50')
      second_order = Order.create!(user_id: second_client.id, event: first_event, buffet: first_buffet, total_guests: 50,
                    address: "Rua 1, Bairro 1, 1", event_date: 1.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês")

      login_as first_client

      get client_order_path(second_order.id)

      expect(response).to redirect_to(root_path)
    end
    it 'sucessfully' do
      first_buffet, second_buffet, first_event, second_event = create_buffets_with_events
      first_client = User.create!(email: 'first_client@client.com', password: 'password', name: "Client ONE",
                                  role: :client, cpf: "922.806.920-15")
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO12')
      first_order = Order.create!(user_id: first_client.id, event: first_event, buffet: first_buffet, total_guests: 50,
                                  address: "Rua 1, Bairro 1, 1", event_date: 1.month.from_now.next_weekday, price: 5000,
                                  additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês")

      second_client = User.create!(email: 'second_client@client.com', password: 'password', name: "Client TWO",
                                   role: :client, cpf: "794.737.960-21")
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO50')
      Order.create!(user_id: second_client.id, event: first_event, buffet: first_buffet, total_guests: 50,
                                   address: "Rua 1, Bairro 1, 1", event_date: 1.month.from_now.next_weekday, price: 5000,
                                   additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês")

      login_as first_client

      get client_order_path(first_order.id)

      expect(response).to have_http_status(:ok)
    end
  end
end