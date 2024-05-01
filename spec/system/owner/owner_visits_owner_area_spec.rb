require 'rails_helper'

describe "Owner visits owner area" do
  it 'successfully' do
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

    login_as owner
    visit root_path
    click_on 'Área do proprietário'

    expect(current_path).to eq owner_dashboards_path
  end

  it 'and see buffet and events information' do
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

    login_as owner
    visit root_path
    click_on 'Área do proprietário'

    expect(page).to have_content 'Buffet 1'
    expect(page).to have_content 'Description 1'
    expect(page).to have_link 'Ver detalhes' # Leva para Buffet => Show
    expect(page).to have_content 'Cadastrar evento' # Leva para Event => New, Create
    expect(page).to have_content 'Eventos cadastrados'
    expect(page).to have_content 'Nenhum evento cadastrado'
  end

  it 'and sees link to orders' do
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

    login_as owner
    visit root_path
    click_on 'Área do proprietário'

    expect(page).to have_link 'Ver solicitações de evento'
  end

  it "and sees all orders placed" do
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

    first_client = User.create!(email: 'first_client@client.com', password: 'password', name: "Client ONE",
                                role: :client, cpf: "068.302.130-37")
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO12')
    first_order = Order.create!(user_id: first_client.id, event: event, buffet: buffet, total_guests: 50,
                                address: "Rua 1, Bairro 1, 1", event_date: 2.month.from_now.next_weekday, price: 5000,
                                additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês")

    second_client = User.create!(email: 'second_client@client.com', password: 'password', name: "Client TWO",
                                 role: :client, cpf: "485.055.690-67")
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO50')
    second_order = Order.create!(user_id: second_client.id, event: event, buffet: buffet, total_guests: 50,
                                 address: "Rua 1, Bairro 1, 1", event_date: 1.month.from_now.next_weekday, price: 5000,
                                 additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês")

    login_as owner
    visit root_path
    click_on 'Área do proprietário'
    click_on 'Ver solicitações de evento'

    expect(page).to have_content 'Solicitações'
    expect(page).to have_content 'CODIGO12'
    expect(page).to have_content 'Event 1'
    expect(page).to have_content 'Client ONE'
    expect(page).to have_content 'CODIGO50'
    expect(page).to have_content 'Event 1'
    expect(page).to have_content 'Client TWO'
  end

  context "and sees order details" do
    it 'successfully' do
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

      first_client = User.create!(email: 'first_client@client.com', password: 'password', name: "Client ONE",
                                  role: :client, cpf: "068.302.130-37")
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO12')
      first_order = Order.create!(user_id: first_client.id, event: event, buffet: buffet, total_guests: 50,
                                  address: "Rua 1, Bairro 1, 1", event_date: 2.month.from_now.next_weekday, price: 5000,
                                  additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1")

      second_client = User.create!(email: 'second_client@client.com', password: 'password', name: "Client TWO",
                                   role: :client, cpf: "485.055.690-67")
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO50')
      second_order = Order.create!(user_id: second_client.id, event: event, buffet: buffet, total_guests: 50,
                                   address: "Rua 1, Bairro 1, 1", event_date: 1.month.from_now.next_weekday, price: 5000,
                                   additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês")

      login_as owner
      visit root_path
      click_on 'Área do proprietário'
      click_on 'Ver solicitações de evento'
      click_on 'CODIGO12'

      expect(page).to have_content "Evento: Event 1"
      expect(page).to have_content "Data do evento: #{2.month.from_now.next_weekday.strftime('%d/%m/%Y')}"
      expect(page).to have_content "Número de convidados: 50"
      expect(page).to have_content "Endereço: Rua 1, Bairro 1, 1"
      expect(page).to have_content "Informações adicionais: Informações adicionais do pedido 1 para o evento 1 em Buffet 1"
      expect(page).to have_content "Preço: R$ 5.000,00"
      expect(page).to have_content "Código do pedido: #{Order.first.code}"
      expect(page).to have_content "Status: Pendente"
    end

    it "and warns when there's more than one event on the same day" do
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

      first_client = User.create!(email: 'first_client@client.com', password: 'password', name: "Client ONE",
                                  role: :client, cpf: "068.302.130-37")
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO12')
      first_order = Order.create!(user_id: first_client.id, event: event, buffet: buffet, total_guests: 50,
                                  address: "Rua 1, Bairro 1, 1", event_date: 1.month.from_now.next_weekday, price: 5000,
                                  additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1")

      second_client = User.create!(email: 'second_client@client.com', password: 'password', name: "Client TWO",
                                   role: :client, cpf: "485.055.690-67")
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO50')
      second_order = Order.create!(user_id: second_client.id, event: event, buffet: buffet, total_guests: 50,
                                   address: "Rua 1, Bairro 1, 1", event_date: 1.month.from_now.next_weekday, price: 5000,
                                   additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês")

      login_as owner
      visit root_path
      click_on 'Área do proprietário'
      click_on 'Ver solicitações de evento'
      click_on 'CODIGO12'

      expect(page).to have_content "Existe outra solicitação de evento para a mesma data"
      expect(page).to have_content "Evento: Event 1"
      expect(page).to have_content "Data do evento: #{1.month.from_now.next_weekday.strftime('%d/%m/%Y')}"
      expect(page).to have_content "Número de convidados: 50"
      expect(page).to have_content "Endereço: Rua 1, Bairro 1, 1"
      expect(page).to have_content "Informações adicionais: Informações adicionais do pedido 1 para o evento 1 em Buffet 1"
      expect(page).to have_content "Preço: R$ 5.000,00"
      expect(page).to have_content "Código do pedido: #{Order.first.code}"
      expect(page).to have_content "Status: Pendente"
    end
  end
end