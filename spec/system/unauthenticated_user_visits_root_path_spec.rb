require 'rails_helper'

describe 'Unauthenticated user visits root_path' do
  it "and there aren't registered buffets" do
    visit root_path

    expect(page).to have_content 'Nenhum Buffet cadastrado'
  end

  it 'and sees all registered buffets' do
    payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
    payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')

    first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                               password: 'password1', role: :owner)
    buffet_a = Buffet.new(user: first_owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                              crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                              description: 'Description 1')
    buffet_a.payment_methods << payment_method_a
    buffet_a.payment_methods << payment_method_b
    buffet_a.save!
    Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                    state: 'State 1', city: 'City 1', zip: '11111', buffet: buffet_a)

    second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com',
                                password: 'password2', role: :owner)
    buffet_b = Buffet.new(user: second_owner, brand_name: 'Buffet 2', company_name: 'Company 2',
                               crn: '31.602.413/0001-70', phone: '222-222-2222', email: 'buffet2@example.com',
                               description: 'Description 2')
    buffet_b.payment_methods << payment_method_a
    buffet_b.payment_methods << payment_method_b
    buffet_b.save!
    Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                    state: 'State 2', city: 'City 2', zip: '22222', buffet: buffet_b)

    visit root_path

    expect(page).to have_link 'Buffet 1'
    expect(page).to have_content 'Localizado em: City 1 - State 1'
    expect(page).to have_link 'Buffet 2'
    expect(page).to have_content 'Localizado em: City 2 - State 2'
  end

  it "sees all registered buffets and click on buffet's link" do
    payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
    payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
    
    owner_a = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                               password: 'password1', role: :owner)
    buffet_a = Buffet.new(user: owner_a, brand_name: 'Buffet A', company_name: 'Company A',
                              crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                              description: 'Description A')
    buffet_a.payment_methods << payment_method_a
    buffet_a.payment_methods << payment_method_b
    buffet_a.save!
    Address.create!(street_name: 'Street A', neighborhood: 'Neighborhood A', house_or_lot_number: '1',
                    state: 'State A', city: 'City A', zip: '11111', buffet: buffet_a)
    event_a = Event.create!(name: 'Event A', description: 'Description A', buffet: buffet_a,
                          min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu A',
                          offsite_event: false, offers_alcohol: true, offers_decoration: true,
                          offers_valet_parking: true)
    weekday_event_a = EventPrice.create!(standard_price: 5000, extra_guest_price: 200, extra_hour_price: 100,
                                      day_type: :weekday, event: event_a)
    weekend_event_a = EventPrice.create!(standard_price: 6000, extra_guest_price: 300, extra_hour_price: 150,
                                      day_type: :weekend, event: event_a)

    owner_b = User.create!(name: 'Carlos', email: 'email_second_owner@example.com',
                                password: 'password2', role: :owner)
    buffet_b = Buffet.new(user: owner_b, brand_name: 'Buffet 2', company_name: 'Company 2',
                               crn: '31.602.413/0001-70', phone: '222-222-2222', email: 'buffet2@example.com',
                               description: 'Description 2')
    buffet_b.payment_methods << payment_method_a
    buffet_b.payment_methods << payment_method_b
    buffet_b.save!
    Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                    state: 'State 2', city: 'City 2', zip: '22222', buffet: buffet_b)
    event_b = Event.create!(name: 'Event 2', description: 'Description 2', buffet: buffet_b,
                          min_guests: 10, max_guests: 100, standard_duration: 400, menu: 'Menu 2',
                          offsite_event: false, offers_alcohol: true, offers_decoration: true,
                          offers_valet_parking: true)
    weekday_event_b = EventPrice.create!(standard_price: 20000, extra_guest_price: 300, extra_hour_price: 200,
                                      day_type: :weekday, event: event_b)
    weekend_event_b = EventPrice.create!(standard_price: 40000, extra_guest_price: 400, extra_hour_price: 250,
                                      day_type: :weekend, event: event_b)

    visit root_path
    click_on 'Buffet A'

    expect(page).to have_content 'Buffet A'
    expect(page).to have_content 'Descrição: Description A'
    expect(page).to have_content 'CNPJ: 23.261.499/0001-96'
    expect(page).to have_content 'Telefone: 111-111-1111'
    expect(page).to have_content 'Email: buffet1@example.com'
    expect(page).to have_content 'Endereço'
    expect(page).to have_content 'Street A, 1, Neighborhood A, City A - State A, 11111'
    expect(page).to have_content 'Métodos de pagamento'
    expect(page).to have_content 'Payment Method 1'
    expect(page).to have_content 'Payment Method 2'
    expect(page).to have_content 'Evento'
    expect(page).to have_content 'Event A'
    expect(page).to have_content 'Descrição: Description A'
    expect(page).to have_content 'Número de convidados: de 10 a 100'
    expect(page).to have_content 'Duração do evento: 5h'
    expect(page).to have_content 'Cardápio: Menu A'
    expect(page).to have_content 'Evento externo: Não'
    expect(page).to have_content 'Inclui bebidas alcoólicas: Sim'
    expect(page).to have_content 'Inclui decoração: Sim'
    expect(page).to have_content 'Inclui serviço de estacionamento: Sim'
  end

  it 'and sees the search form for buffets' do
    visit root_path

    within "nav" do
      expect(page).to have_field 'Buscar Buffet'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'and finds a buffet by name' do
    payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
    payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
    first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                               password: 'password1', role: :owner)
    first_buffet = Buffet.new(user: first_owner, brand_name: 'Buffet A', company_name: 'Company A',
                              crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                              description: 'Description A')
    first_buffet.payment_methods << payment_method_a
    first_buffet.payment_methods << payment_method_b
    first_buffet.save!
    Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                    state: 'State 1', city: 'City 1', zip: '11111', buffet: first_buffet)

    second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com',
                                password: 'password2', role: :owner)
    second_buffet = Buffet.new(user: second_owner, brand_name: 'Buffet B', company_name: 'Company B',
                               crn: '66.867.496/0001-03', phone: '222-222-2222', email: 'buffet2@example.com',
                               description: 'Description B')
    second_buffet.payment_methods << payment_method_a
    second_buffet.payment_methods << payment_method_b
    second_buffet.save!
    Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                    state: 'State 2', city: 'City 2', zip: '22222', buffet: second_buffet)
    visit root_path
    within "nav" do
      fill_in 'Buscar Buffet', with: 'Buffet'
      click_on 'Buscar'
    end

    within "#buffets div:first-child" do
      expect(page).to have_link 'Buffet A'
      expect(page).to have_content 'Localizado em: City 1 - State 1'
    end

    within "#buffets div:nth-child(2)" do
      expect(page).to have_link 'Buffet B'
      expect(page).to have_content 'Localizado em: City 2 - State 2'
    end
  end
  it 'and sees event details' do
    create_buffets_with_events

    visit root_path
    within "nav" do
      fill_in 'Buscar Buffet', with: 'Buffet'
      click_on 'Buscar'
    end
    click_on 'Buffet 1'

    expect(page).to have_content 'Buffet 1'
    expect(page).to have_content 'Descrição: Description 1'
    expect(page).to have_content 'CNPJ: 31.602.413/0001-70'
    expect(page).to have_content 'Telefone: 111-111-1111'
    expect(page).to have_content 'buffet1@example.com'
    expect(page).to have_content 'Endereço'
    expect(page).to have_content 'Street 1, 1, Neighborhood 1, City 1 - State 1, 11111'
    expect(page).to have_content 'Métodos de pagamento'
    expect(page).to have_content 'Payment Method 1'
    expect(page).to have_content 'Payment Method 2'
    expect(page).to have_content 'Evento'
    expect(page).to have_content 'Event 1'
    expect(page).to have_content 'Description 1'
    expect(page).to have_content 'Número de convidados: de 10 a 100'
    expect(page).to have_content 'Duração do evento: 5h'
    expect(page).to have_content 'Cardápio: Menu 1'
    expect(page).to have_content 'Evento externo: Sim'
    expect(page).to have_content 'Inclui bebidas alcoólicas: Sim'
    expect(page).to have_content 'Inclui decoração: Sim'
    expect(page).to have_content 'Inclui serviço de estacionamento: Sim'
    expect(page).to have_content 'Preço do evento'
    expect(page).to have_content 'Evento em dia de semana'
    expect(page).to have_content 'Preço mínimo: R$ 1.000,00'
    expect(page).to have_content 'Adicional por convidado extra: R$ 100,00'
    expect(page).to have_content 'Adicional por hora extra: R$ 50'
    expect(page).to have_content 'Evento em final de semana'
    expect(page).to have_content 'Preço mínimo: R$ 1.500,00'
    expect(page).to have_content 'Adicional por convidado extra: R$ 150,00'
    expect(page).to have_content 'Adicional por hora extra: R$ 75'
  end
end