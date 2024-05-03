require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid' do
    it 'should validate event date in the past' do
      first_buffet, second_buffet, first_event, second_event = create_buffets_with_events
      client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                            cpf: "595.085.920-01")

      order = Order.new(user_id: client.id, event: first_event, buffet: first_buffet, total_guests: 50, address: "Rua 1, Bairro 1, 1",
                    additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês",
                    event_date: Date.today - 1.day)

      expect(order).not_to be_valid
    end

    context 'should validate total guests' do
      it "can't be less than minimun" do
        first_buffet, second_buffet, first_event, second_event = create_buffets_with_events
        client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                              cpf: "595.085.920-01")

        order = Order.new(user_id: client.id, event: first_event, buffet: first_buffet, total_guests: 1, address: "Rua 1, Bairro 1, 1",
                          additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês",
                          event_date: Date.today - 1.day)

        expect(order).not_to be_valid
      end
      it "can't be more than maximun" do
        first_buffet, second_buffet, first_event, second_event = create_buffets_with_events
        client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                              cpf: "595.085.920-01")

        order = Order.new(user_id: client.id, event: first_event, buffet: first_buffet, total_guests: 300, address: "Rua 1, Bairro 1, 1",
                          additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês",
                          event_date: Date.today - 1.day)

        expect(order).not_to be_valid
      end
    end

  end
end
