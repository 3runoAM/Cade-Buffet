require 'rails_helper'

describe "User exchange messages" do
  context "as a client" do
    it 'and sees link to chat' do
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
                    status: :approved, payment_method_id: 1, confirmation_date: 7.days.from_now)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO02')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 60,
                    address: "Rua 1, Bairro 1, 1", event_date: 2.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 2 para o evento 1 em Buffet 1",
                    status: :pending)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO03')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 70,
                    address: "Rua 1, Bairro 1, 1", event_date: 3.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 3 para o evento 1 em Buffet 1",
                    status: :pending)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO04')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 80,
                    address: "Rua 1, Bairro 1, 1", event_date: 4.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 4 para o evento 1 em Buffet 1",
                    status: :pending)

      login_as client
      visit root_path
      click_on 'Área do cliente'
      click_on 'CODIGO01'

      expect(page).to have_link "Falar com o estabelecimento"
    end

    it "and sees the field to message the owner" do
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
                    status: :approved, payment_method_id: 1, confirmation_date: 7.days.from_now)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO02')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 60,
                    address: "Rua 1, Bairro 1, 1", event_date: 2.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 2 para o evento 1 em Buffet 1",
                    status: :pending)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO03')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 70,
                    address: "Rua 1, Bairro 1, 1", event_date: 3.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 3 para o evento 1 em Buffet 1",
                    status: :pending)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO04')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 80,
                    address: "Rua 1, Bairro 1, 1", event_date: 4.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 4 para o evento 1 em Buffet 1",
                    status: :pending)

      login_as client
      visit root_path
      click_on 'Área do cliente'
      click_on 'CODIGO01'
      click_on "Falar com o estabelecimento"

      expect(page).to have_field "Mensagem"
      expect(page).to have_button "Enviar"
    end

    it 'sucessfully' do
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
                    status: :approved, payment_method_id: 1, confirmation_date: 7.days.from_now)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO02')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 60,
                    address: "Rua 1, Bairro 1, 1", event_date: 2.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 2 para o evento 1 em Buffet 1",
                    status: :pending)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO03')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 70,
                    address: "Rua 1, Bairro 1, 1", event_date: 3.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 3 para o evento 1 em Buffet 1",
                    status: :pending)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO04')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 80,
                    address: "Rua 1, Bairro 1, 1", event_date: 4.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 4 para o evento 1 em Buffet 1",
                    status: :pending)

      login_as client
      visit root_path
      click_on 'Área do cliente'
      click_on 'CODIGO01'
      click_on "Falar com o estabelecimento"
      fill_in "Mensagem", with: "Olá!"
      click_on "Enviar"

      expect(page).to have_content "Client ONE"
      expect(page).to have_content "Olá!"
      expect(page).to have_content "Enviado em: #{Message.first.sent_at.strftime("%d/%m/%Y %H:%M")}"
    end
  end

  context 'as a buffet owner' do
    it 'and sees link to chat' do
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
                    status: :approved, payment_method_id: 1, confirmation_date: 7.days.from_now)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO02')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 60,
                    address: "Rua 1, Bairro 1, 1", event_date: 2.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 2 para o evento 1 em Buffet 1",
                    status: :pending)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO03')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 70,
                    address: "Rua 1, Bairro 1, 1", event_date: 3.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 3 para o evento 1 em Buffet 1",
                    status: :pending)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO04')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 80,
                    address: "Rua 1, Bairro 1, 1", event_date: 4.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 4 para o evento 1 em Buffet 1",
                    status: :pending)

      login_as owner
      visit root_path
      click_on 'Área do proprietário'
      click_on 'Ver solicitações de evento'
      click_on 'CODIGO01'

      expect(page).to have_link "Falar com o cliente"
    end

    it "and sees the field to message the client" do
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
                    status: :approved, payment_method_id: 1, confirmation_date: 7.days.from_now)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO02')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 60,
                    address: "Rua 1, Bairro 1, 1", event_date: 2.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 2 para o evento 1 em Buffet 1",
                    status: :pending)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO03')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 70,
                    address: "Rua 1, Bairro 1, 1", event_date: 3.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 3 para o evento 1 em Buffet 1",
                    status: :pending)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO04')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 80,
                    address: "Rua 1, Bairro 1, 1", event_date: 4.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 4 para o evento 1 em Buffet 1",
                    status: :pending)

      login_as owner
      visit root_path
      click_on 'Área do proprietário'
      click_on 'Ver solicitações de evento'
      click_on 'CODIGO01'
      click_on 'Falar com o cliente'

      expect(page).to have_field "Mensagem"
      expect(page).to have_button "Enviar"
    end

    it 'sucessfuly' do
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
                    status: :approved, payment_method_id: 1, confirmation_date: 7.days.from_now)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO02')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 60,
                    address: "Rua 1, Bairro 1, 1", event_date: 2.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 2 para o evento 1 em Buffet 1",
                    status: :pending)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO03')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 70,
                    address: "Rua 1, Bairro 1, 1", event_date: 3.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 3 para o evento 1 em Buffet 1",
                    status: :pending)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO04')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 80,
                    address: "Rua 1, Bairro 1, 1", event_date: 4.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 4 para o evento 1 em Buffet 1",
                    status: :pending)

      login_as owner
      visit root_path
      click_on 'Área do proprietário'
      click_on 'Ver solicitações de evento'
      click_on 'CODIGO01'
      click_on 'Falar com o cliente'
      fill_in "Mensagem", with: "Olá!"
      click_on "Enviar"

      expect(page).to have_content "Fabrício"
      expect(page).to have_content "Olá!"
      expect(page).to have_content "Enviado em: #{Message.first.sent_at.strftime("%d/%m/%Y %H:%M")}"
    end
  end
end
