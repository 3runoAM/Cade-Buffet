require 'rails_helper'

describe "Owner updates Event" do
  it 'and the form has all the fields to do so' do
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
    Event.create!(name: 'Festa de 15 anos', description: 'Buffet para festa de 15 anos',
                  min_guests: 10, max_guests: 50, standard_duration: 300,
                  menu: 'Bolo, salgados, doces, refrigerantes, bebidas alcoólicas',offsite_event: true,
                  offers_alcohol: true, offers_decoration: true, offers_valet_parking: false, buffet_id: buffet.id)

    login_as owner
    visit root_path
    click_on 'Área do proprietário'
    click_on 'Festa de 15 anos'

    click_on 'Editar evento'

    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Número mínimo de convidados'
    expect(page).to have_field 'Número máximo de convidados'
    expect(page).to have_field 'Duração do evento'
    expect(page).to have_field 'Cardápio'
    expect(page).to have_field 'Evento externo'
    expect(page).to have_field 'Inclui bebidas alcoólicas'
    expect(page).to have_field 'Inclui decoração'
    expect(page).to have_field 'Inclui serviço de estacionamento'
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
    Event.create!(name: 'Festa de 15 anos', description: 'Buffet para festa de 15 anos',
                  min_guests: 10, max_guests: 50, standard_duration: 300,
                  menu: 'Bolo, salgados, doces, refrigerantes, bebidas alcoólicas',offsite_event: true,
                  offers_alcohol: true, offers_decoration: true, offers_valet_parking: false, buffet_id: buffet.id)

    login_as owner
    visit root_path
    click_on 'Área do proprietário'
    click_on 'Festa de 15 anos'

    click_on 'Editar evento'

    fill_in 'Nome', with: 'Festa de 18 anos'
    fill_in 'Descrição', with: 'Buffet para festa de 18 anos'
    fill_in 'Número mínimo de convidados', with: 20
    fill_in 'Número máximo de convidados', with: 100
    fill_in 'Duração do evento', with: 600
    fill_in 'Cardápio', with: 'Bolo, salgados, doces, refrigerantes, bebidas alcoólicas, jantar'
    check 'Evento externo'
    check 'Inclui bebidas alcoólicas'
    check 'Inclui decoração'
    uncheck 'Inclui serviço de estacionamento'

    click_on 'Atualizar Evento'

    expect(page).to have_content('Festa de 18 anos')
    expect(page).to have_content('Buffet para festa de 18 anos')
    expect(page).to have_content('20')
    expect(page).to have_content('100')
    expect(page).to have_content('10h')
    expect(page).to have_content('Bolo, salgados, doces, refrigerantes, bebidas alcoólicas, jantar')
    expect(page).to have_content('Sim')
    expect(page).to have_content('Sim')
    expect(page).to have_content('Sim')
    expect(page).to have_content('Não')
  end
end