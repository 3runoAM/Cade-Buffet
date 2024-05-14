require "rails_helper"

describe "Client places order" do
  it "and sees link to do so" do
    client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                          cpf: "595.085.920-01")
    payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
    payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
    first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                               password: 'password1', role: :owner)
    first_buffet = Buffet.new(user: first_owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                              crn: '31.602.413/0001-70', phone: '111-111-1111', email: 'buffet1@example.com',
                              description: 'Description 1')
    first_buffet.payment_methods << payment_method_a
    first_buffet.payment_methods << payment_method_b
    first_buffet.save!
    Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                    state: 'State 1', city: 'City 1', zip: '11111', buffet: first_buffet)
    first_event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: first_buffet,
                                min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu 1',
                                offsite_event: true, offers_alcohol: true, offers_decoration: true,
                                offers_valet_parking: true)
    first_weekdays_event = EventPrice.create!(event: first_event, standard_price: 1000, extra_guest_price: 100,
                                              extra_hour_price: 50, day_type: :weekday)
    first_weekend_event = EventPrice.create!(event: first_event, standard_price: 1500, extra_guest_price: 150,
                                             extra_hour_price: 75, day_type: :weekend)

    login_as client
    visit root_path
    click_on "Buffet 1"

    expect(page).to have_link('Solicitar evento')
  end

  context  "and sees form to place order" do
    it 'with address field for offsite events' do
      client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                            cpf: "595.085.920-01")
      payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
      first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                                 password: 'password1', role: :owner)
      first_buffet = Buffet.new(user: first_owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                                crn: '31.602.413/0001-70', phone: '111-111-1111', email: 'buffet1@example.com',
                                description: 'Description 1')
      first_buffet.payment_methods << payment_method_a
      first_buffet.payment_methods << payment_method_b
      first_buffet.save!
      Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                      state: 'State 1', city: 'City 1', zip: '11111', buffet: first_buffet)
      first_event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: first_buffet,
                                  min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu 1',
                                  offsite_event: true, offers_alcohol: true, offers_decoration: true,
                                  offers_valet_parking: true)
      first_weekdays_event = EventPrice.create!(event: first_event, standard_price: 1000, extra_guest_price: 100,
                                                extra_hour_price: 50, day_type: :weekday)
      first_weekend_event = EventPrice.create!(event: first_event, standard_price: 1500, extra_guest_price: 150,
                                               extra_hour_price: 75, day_type: :weekend)

      login_as client
      visit root_path
      click_on "Buffet 1"
      within '#events' do
        find('div:nth-child(2)').click_on('Solicitar evento')
      end

      expect(current_path).to eq new_client_order_path
      expect(page).to have_content "Buffet 1"
      expect(page).to have_content "Evento: Event 1"
      expect(page).to have_field "Data do evento"
      expect(page).to have_field "Número de convidados"
      expect(page).to have_field "Endereço"
      expect(page).to have_field "Informações adicionais"

      expect(page).to have_button "Solicitar evento"
    end

    it 'without address field for onsite events' do
      client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                            cpf: "595.085.920-01")
      payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
      second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com',
                                  password: 'password2', role: :owner)
      second_buffet = Buffet.new(user: second_owner, brand_name: 'Buffet 2', company_name: 'Company 2',
                                 crn: '18.312.384/0001-43', phone: '222-222-2222', email: 'buffet2@example.com',
                                 description: 'Description 2')
      second_buffet.payment_methods << payment_method_a
      second_buffet.payment_methods << payment_method_b
      second_buffet.save!
      Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                      state: 'State 2', city: 'City 2', zip: '22222', buffet: second_buffet)
      second_event = Event.create!(name: 'Event 2', description: 'Description 2', buffet: second_buffet,
                                   min_guests: 10, max_guests: 100, standard_duration: 600, menu: 'Menu 2',
                                   offsite_event: false, offers_alcohol: true, offers_decoration: true,
                                   offers_valet_parking: true)
      second_weekdays_event = EventPrice.create!(event: second_event, standard_price: 2000, extra_guest_price: 200,
                                                 extra_hour_price: 100, day_type: :weekday)
      second_weekend_event = EventPrice.create!(event: second_event, standard_price: 2500, extra_guest_price: 250,
                                                extra_hour_price: 125, day_type: :weekend)

      login_as client
      visit root_path
      click_on "Buffet 2"
      within '#events' do
        find('div:nth-child(2)').click_on('Solicitar evento')
      end

      expect(current_path).to eq new_client_order_path
      expect(page).to have_content "Buffet 2"
      expect(page).to have_content "Evento: Event 2"
      expect(page).to have_field "Data do evento"
      expect(page).to have_field "Número de convidados"
      expect(page).not_to have_field "Endereço (opcional)"
      expect(page).to have_field "Informações adicionais"

      expect(page).to have_button "Solicitar evento"
    end
  end

  context  "sucessfuly" do
    it 'with address field for offsite events filled' do
      client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                            cpf: "595.085.920-01")
      payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
      first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                                 password: 'password1', role: :owner)
      first_buffet = Buffet.new(user: first_owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                                crn: '31.602.413/0001-70', phone: '111-111-1111', email: 'buffet1@example.com',
                                description: 'Description 1')
      first_buffet.payment_methods << payment_method_a
      first_buffet.payment_methods << payment_method_b
      first_buffet.save!
      Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                      state: 'State 1', city: 'City 1', zip: '11111', buffet: first_buffet)
      first_event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: first_buffet,
                                  min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu 1',
                                  offsite_event: true, offers_alcohol: true, offers_decoration: true,
                                  offers_valet_parking: true)
      first_weekdays_event = EventPrice.create!(event: first_event, standard_price: 1000, extra_guest_price: 100,
                                                extra_hour_price: 50, day_type: :weekday)
      first_weekend_event = EventPrice.create!(event: first_event, standard_price: 1500, extra_guest_price: 150,
                                               extra_hour_price: 75, day_type: :weekend)

      login_as client
      visit root_path
      click_on "Buffet 1"
      within '#events' do
        find('div:nth-child(2)').click_on('Solicitar evento')
      end

      fill_in "Data do evento", with: 1.month.from_now.next_weekday
      fill_in "Número de convidados", with: 50
      fill_in "Endereço", with: "Rua 1, Bairro 1, 1"
      fill_in "Informações adicionais", with: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês"
      click_on "Solicitar evento"

      expect(current_path).to eq client_order_path(Order.last.id)
      expect(page).to have_content "Evento solicitado com sucesso"
      expect(page).to have_content "Pedido #{Order.last.code}"
      expect(page).to have_content "Buffet: Buffet 1"
      expect(page).to have_content "Evento: Event 1"
      expect(page).to have_content "Data do evento: #{1.month.from_now.next_weekday.strftime('%d/%m/%Y')}"
      expect(page).to have_content "Número de convidados: 50"
      expect(page).to have_content "Endereço: Rua 1, Bairro 1, 1"
      expect(page).to have_content "Informações adicionais: Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês"
      expect(page).to have_content "Preço: R$ 5.000,00"
      expect(page).to have_content "Status: Pendente"
    end

    it 'with address field for offsite events unfilled' do
      client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                            cpf: "595.085.920-01")
      payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
      payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
      first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                                 password: 'password1', role: :owner)
      first_buffet = Buffet.new(user: first_owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                                crn: '31.602.413/0001-70', phone: '111-111-1111', email: 'buffet1@example.com',
                                description: 'Description 1')
      first_buffet.payment_methods << payment_method_a
      first_buffet.payment_methods << payment_method_b
      first_buffet.save!
      Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                      state: 'State 1', city: 'City 1', zip: '11111', buffet: first_buffet)
      first_event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: first_buffet,
                                  min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu 1',
                                  offsite_event: true, offers_alcohol: true, offers_decoration: true,
                                  offers_valet_parking: true)
      first_weekdays_event = EventPrice.create!(event: first_event, standard_price: 1000, extra_guest_price: 100,
                                                extra_hour_price: 50, day_type: :weekday)
      first_weekend_event = EventPrice.create!(event: first_event, standard_price: 1500, extra_guest_price: 150,
                                               extra_hour_price: 75, day_type: :weekend)

      login_as client
      visit root_path
      click_on "Buffet 1"
      within '#events' do
        find('div:nth-child(2)').click_on('Solicitar evento')
      end

      fill_in "Data do evento", with: 1.month.from_now.next_weekday
      fill_in "Número de convidados", with: 50
      fill_in "Informações adicionais", with: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês"

      click_on "Solicitar evento"

      expect(current_path).to eq client_order_path(Order.last)
      expect(page).to have_content "Evento solicitado com sucesso"
      expect(page).to have_content "Pedido #{Order.last.code}"
      expect(page).to have_content "Buffet: Buffet 1"
      expect(page).to have_content "Evento: Event 1"
      expect(page).to have_content "Data do evento: #{1.month.from_now.next_weekday.strftime('%d/%m/%Y')}"
      expect(page).to have_content "Número de convidados: 50"
      expect(page).to have_content "Endereço: #{first_buffet.address.full_address}"
      expect(page).to have_content "Informações adicionais: Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês"
      expect(page).to have_content "Preço: R$ 5.000,00"
      expect(page).to have_content "Status: Pendente"
    end

    it 'without address field for onsite events' do
      client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                            cpf: "595.085.920-01")
      payment_method_a = PaymentMethod.create!(name: 'Pix')
      payment_method_b = PaymentMethod.create!(name: 'Cartão de crédito')
      second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com',
                                  password: 'password2', role: :owner)
      second_buffet = Buffet.new(user: second_owner, brand_name: 'Buffet 2', company_name: 'Company 2',
                                 crn: '18.312.384/0001-43', phone: '222-222-2222', email: 'buffet2@example.com',
                                 description: 'Description 2')
      second_buffet.payment_methods << payment_method_a
      second_buffet.payment_methods << payment_method_b
      second_buffet.save!
      Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                      state: 'State 2', city: 'City 2', zip: '22222', buffet: second_buffet)
      second_event = Event.create!(name: 'Event 2', description: 'Description 2', buffet: second_buffet,
                                   min_guests: 10, max_guests: 100, standard_duration: 600, menu: 'Menu 2',
                                   offsite_event: false, offers_alcohol: true, offers_decoration: true,
                                   offers_valet_parking: true)
      second_weekdays_event = EventPrice.create!(event: second_event, standard_price: 2000, extra_guest_price: 200,
                                                 extra_hour_price: 100, day_type: :weekday)
      second_weekend_event = EventPrice.create!(event: second_event, standard_price: 2500, extra_guest_price: 250,
                                                extra_hour_price: 125, day_type: :weekend)
      login_as client
      visit root_path
      click_on "Buffet 2"
      within '#events' do
        find('div:nth-child(2)').click_on('Solicitar evento')
      end

      fill_in "Data do evento", with: 1.month.from_now.next_weekday
      fill_in "Número de convidados", with: 50
      fill_in "Informações adicionais", with: "Informações adicionais do pedido 1 para o evento 2 em Buffet 2 em 1 mês"
      click_on "Solicitar evento"

      expect(current_path).to eq client_order_path(Order.last)
      expect(page).to have_content "Evento solicitado com sucesso"
      expect(page).to have_content "Pedido #{Order.last.code}"
      expect(page).to have_content "Buffet: Buffet 2"
      expect(page).to have_content "Evento: Event 2"
      expect(page).to have_content "Data do evento: #{1.month.from_now.next_weekday.strftime('%d/%m/%Y')}"
      expect(page).to have_content "Número de convidados: 50"
      expect(page).to have_content "Endereço: #{second_buffet.address.full_address}"
      expect(page).to have_content "Informações adicionais: Informações adicionais do pedido 1 para o evento 2 em Buffet 2 em 1 mês"
      expect(page).to have_content "Preço: R$ 10.000,00"
      expect(page).to have_content "Status: Pendente"
    end
  end

  it 'and sees all orders' do
    first_buffet, second_buffet, first_event, second_event = create_buffets_with_events
    client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                          cpf: "595.085.920-01")

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO12')
    Order.create!(user_id: client.id, event: first_event, buffet: first_buffet, total_guests: 50, address: "Rua 1, Bairro 1, 1",
                  additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês",
                  event_date: 1.month.from_now.next_weekday, price: 5000)

    login_as client

    visit root_path
    click_on "Área do cliente"

    expect(current_path).to eq client_dashboards_path
    expect(page).to have_content "Minhas solicitações"
    expect(page).to have_content "CODIGO12"
    expect(page).to have_content 1.month.from_now.next_weekday.strftime('%d/%m/%Y')
  end
end

