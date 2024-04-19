require 'rails_helper'

describe 'User register event' do
  it 'and the form has all the fields to do so' do
    owner = User.create!(name: 'Fabrício', email: 'owner@example.com', password: 'password1', role: :owner)
    payment_method_a = PaymentMethod.create!(name: 'Pix')
    payment_method_b = PaymentMethod.create!(name: 'Cartão de crédito')
    buffet = Buffet.new(user_id: owner.id, brand_name: 'Buffet 1', company_name: 'Company 1',
                        crn: '123456', phone: '111-111-1111', email: 'buffet1@example.com',
                        description: 'Description 1')
    buffet.payment_methods << payment_method_a
    buffet.payment_methods << payment_method_b
    buffet.save!
    Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                    state: 'State 1', city: 'City 1', zip: '11111', buffet_id: buffet.id)

    login_as owner
    visit root_path
    click_on 'Área do proprietário'
    click_on 'Cadastrar evento'

    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Número mínimo de convidados'
    expect(page).to have_field 'Número máximo de convidados'
    expect(page).to have_field 'Duração do evento (em minutos)'
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
                        crn: '123456', phone: '111-111-1111', email: 'buffet1@example.com',
                        description: 'Description 1')
    buffet.payment_methods << payment_method_a
    buffet.payment_methods << payment_method_b
    buffet.save!
    Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                    state: 'State 1', city: 'City 1', zip: '11111', buffet_id: buffet.id)

    login_as owner
    visit root_path
    click_on 'Área do proprietário'
    click_on 'Cadastrar evento'

    fill_in 'Nome', with: 'Festa de 15 anos'
    fill_in 'Descrição', with: 'Buffet para festa de 15 anos'
    fill_in 'Número mínimo de convidados', with: '10'
    fill_in 'Número máximo de convidados', with: '50'
    fill_in 'Duração do evento (em minutos)', with: '300'
    fill_in 'Cardápio', with: 'Bolo, salgados, doces, refrigerantes, bebidas alcoólicas'
    check 'Evento externo'
    check 'Inclui bebidas alcoólicas'
    check 'Inclui decoração'

    click_on "Criar Evento"

    expect(current_path).to eq owner_buffet_event_path(1, 1)
    expect(page).to have_content "Evento criado com sucesso"
    expect(page).to have_content 'Festa de 15 anos'
    expect(page).to have_content 'Buffet para festa de 15 anos'
    expect(page).to have_content 'Número mínimo de convidados: 10'
    expect(page).to have_content 'Número máximo de convidados: 50'
    expect(page).to have_content 'Duração do evento (em minutos): 300 minutos'
    expect(page).to have_content 'Cardápio: Bolo, salgados, doces, refrigerantes, bebidas alcoólicas'
    expect(page).to have_content 'Evento externo: Sim'
    expect(page).to have_content 'Inclui bebidas alcoólicas: Sim'
    expect(page).to have_content 'Inclui decoração: Sim'
    expect(page).to have_content 'Inclui serviço de estacionamento: Não'
  end
end