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

  context "and sees all orders placed" do
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

    it 'classified by status' do
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
                    status: :pending)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO02')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 60,
                    address: "Rua 1, Bairro 1, 1", event_date: 2.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 2 para o evento 1 em Buffet 1",
                    status: :confirmed)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO03')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 70,
                    address: "Rua 1, Bairro 1, 1", event_date: 3.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 3 para o evento 1 em Buffet 1",
                    status: :approved, payment_method_id: 1, confirmation_date: 2.days.from_now)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO04')
      Order.create!(user_id: client.id, event: event, buffet: buffet, total_guests: 80,
                    address: "Rua 1, Bairro 1, 1", event_date: 4.month.from_now.next_weekday, price: 5000,
                    additional_info: "Informações adicionais do pedido 4 para o evento 1 em Buffet 1",
                    status: :rejected)

      login_as owner
      visit root_path
      click_on 'Área do proprietário'
      click_on 'Ver solicitações de evento'

      within '#pending-orders' do
        expect(page).to have_content 'Eventos pendentes'
        expect(page).to have_content 'CODIGO01'
        expect(page).to have_content 'Event 1'
        expect(page).to have_content 'Client ONE'
      end

      within '#confirmed-orders' do
        expect(page).to have_content 'Eventos confirmados'
        expect(page).to have_content 'CODIGO02'
        expect(page).to have_content 'Event 1'
        expect(page).to have_content 'Client ONE'
      end

      within '#approved-orders' do
        expect(page).to have_content 'Eventos aprovados'
        expect(page).to have_content 'CODIGO03'
        expect(page).to have_content 'Event 1'
        expect(page).to have_content 'Client ONE'
      end

      within '#rejected-orders' do
        expect(page).to have_content 'Eventos rejeitados'
        expect(page).to have_content 'CODIGO04'
        expect(page).to have_content 'Event 1'
        expect(page).to have_content 'Client ONE'
      end
    end
  end

  context "sees order details" do
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

    it "and receive a warning when there's more than one event on the same day" do
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

    it 'and sees the buttons to reject or analyze an order' do
      owner = create_buffet_with_pending_orders

      login_as owner
      visit root_path
      click_on 'Área do proprietário'
      click_on 'Ver solicitações de evento'
      click_on 'CODIGO03'

      expect(page).to have_button 'Rejeitar solicitação'
      expect(page).to have_link 'Analisar solicitação'
    end

    it 'and can reject an order' do
      owner = create_buffet_with_pending_orders

      login_as owner
      visit root_path
      click_on 'Área do proprietário'
      click_on 'Ver solicitações de evento'
      click_on 'CODIGO03'
      click_on 'Rejeitar solicitação'

      expect(page).to have_content 'Status: Rejeitado'
    end
  end

  context "analyzes an order" do
    it 'and the form has all the fields to do so' do
      owner = create_buffet_with_pending_orders

      login_as owner
      visit root_path
      click_on 'Área do proprietário'
      click_on 'Ver solicitações de evento'
      click_on 'CODIGO01'
      click_on 'Analisar solicitação'

      expect(page).to have_content "Análise da solicitação CODIGO01"
      expect(page).to have_content "Evento: Event 1"
      expect(page).to have_content "Data do evento: #{1.month.from_now.next_weekday.strftime('%d/%m/%Y')}"
      expect(page).to have_content "Número de convidados: 50"
      expect(page).to have_content "Endereço: Rua 1, Bairro 1, 1"
      expect(page).to have_content "Informações adicionais: Informações adicionais do pedido 1 para o" +
                                     " evento 1 em Buffet 1"
      expect(page).to have_content "Preço: R$ 5.000,00"
      expect(page).to have_content "Status: Pendente"

      expect(page).to have_field 'Ajuste de preço'
      expect(page).to have_content 'Tipo do ajuste'
      expect(page).to have_content 'Desconto'
      expect(page).to have_content 'Taxa extra'
      expect(page).to have_content 'Nenhum'
      expect(page).to have_field 'Justificativa'
      expect(page).to have_content 'Método de pagamento'
      expect(page).to have_content 'Pix'
      expect(page).to have_content 'Cartão de crédito'
      expect(page).to have_field 'Data final para confirmação'
    end

    it 'and approves it without price adjustments' do
      owner = create_buffet_with_pending_orders

      login_as owner
      visit root_path
      click_on 'Área do proprietário'
      click_on 'Ver solicitações de evento'
      click_on 'CODIGO01'
      click_on 'Analisar solicitação'

      choose 'Pix'
      fill_in 'Data final para confirmação', with: 2.days.from_now
      click_on 'Aprovar'

      expect(current_path).to eq owner_order_path(Order.first.id)
      expect(page).to have_content "Solicitação aprovada com sucesso"
    end

    it 'and approves it with discount adjustments' do
      owner = create_buffet_with_pending_orders

      login_as owner
      visit root_path
      click_on 'Área do proprietário'
      click_on 'Ver solicitações de evento'
      click_on 'CODIGO01'
      click_on 'Analisar solicitação'

      fill_in 'Ajuste de preço', with: '50'
      choose 'Desconto'
      fill_in 'Justifica', with: 'Desconto da amizade'
      choose 'Pix'
      fill_in 'Data final para confirmação', with: 2.days.from_now
      click_on 'Aprovar'

      expect(current_path).to eq owner_order_path(Order.first.id)
      expect(page).to have_content "Solicitação aprovada com sucesso"
      expect(page).to have_content "Preço: R$ 4.950,00"
    end

    it 'and approves it with surcharge adjustments' do
      owner = create_buffet_with_pending_orders

      login_as owner
      visit root_path
      click_on 'Área do proprietário'
      click_on 'Ver solicitações de evento'
      click_on 'CODIGO01'
      click_on 'Analisar solicitação'

      fill_in 'Ajuste de preço', with: 50
      choose 'Taxa extra'
      fill_in 'Justifica', with: 'Desconto da amizade'
      choose 'Pix'
      fill_in 'Data final para confirmação', with: 2.days.from_now
      click_on 'Aprovar'

      expect(current_path).to eq owner_order_path(Order.first.id)
      expect(page).to have_content "Solicitação aprovada com sucesso"
      expect(page).to have_content "Preço: R$ 5.050,00"
    end
  end
end
