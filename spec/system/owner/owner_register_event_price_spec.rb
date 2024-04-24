require 'rails_helper'

describe 'Owner register event price' do
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
    event = Event.create!(buffet: buffet, name: 'Festa de 15 anos', description: 'Buffet para festa de 15 anos', min_guests: 10,
                  max_guests: 50, standard_duration: 300, menu: 'Bolo, salgados, doces, refrigerantes,' +
                  ' bebidas alcoólicas', offsite_event: true, offers_alcohol: true, offers_decoration: true,
                  offers_valet_parking: false)

    login_as owner
    visit root_path
    click_on 'Área do proprietário'
    click_on 'Festa de 15 anos'
    click_on 'Cadastrar Preço'

    expect(page).to have_field 'Preço mínimo'
    expect(page).to have_field 'Adicional por convidado extra'
    expect(page).to have_field 'Adicional por hora extra'
    expect(page).to have_field 'Tipo de evento'
  end
  it "and register weekday's event price" do
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
    event = Event.create!(buffet: buffet, name: 'Festa de 15 anos', description: 'Buffet para festa de 15 anos', min_guests: 10,
                          max_guests: 50, standard_duration: 300, menu: 'Bolo, salgados, doces, refrigerantes,' +
        ' bebidas alcoólicas', offsite_event: true, offers_alcohol: true, offers_decoration: true,
                          offers_valet_parking: false)

    login_as owner
    visit root_path
    click_on 'Área do proprietário'
    click_on 'Festa de 15 anos'
    click_on 'Cadastrar Preço'

    fill_in 'Preço mínimo', with: 1000
    fill_in 'Adicional por convidado extra', with: 50
    fill_in 'Adicional por hora extra', with: 100
    select 'Evento em dia de semana', from: 'Tipo de evento'

    click_on 'Cadastrar preço do evento'

    expect(current_path).to eq owner_buffet_event_path(buffet.id, event.id)
    expect(page).to have_content 'Evento em dia de semana'
    expect(page).to have_content 'R$ 1.000,00'
    expect(page).to have_content 'R$ 50,00'
    expect(page).to have_content 'R$ 100,00'
  end

  it "and register weekend's event price" do
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
    event = Event.create!(buffet: buffet, name: 'Festa de 15 anos', description: 'Buffet para festa de 15 anos', min_guests: 10,
                          max_guests: 50, standard_duration: 300, menu: 'Bolo, salgados, doces, refrigerantes,' +
        ' bebidas alcoólicas', offsite_event: true, offers_alcohol: true, offers_decoration: true,
                          offers_valet_parking: false)

    login_as owner
    visit root_path
    click_on 'Área do proprietário'
    click_on 'Festa de 15 anos'
    click_on 'Cadastrar Preço'

    fill_in 'Preço mínimo', with: 2000
    fill_in 'Adicional por convidado extra', with: 100
    fill_in 'Adicional por hora extra', with: 200
    select 'Evento em final de semana', from: 'Tipo de evento'

    click_on 'Cadastrar preço do evento'

    expect(current_path).to eq owner_buffet_event_path(buffet.id, event.id)
    expect(page).to have_content 'Evento em final de semana'
    expect(page).to have_content 'R$ 2.000,00'
    expect(page).to have_content 'R$ 100,00'
    expect(page).to have_content 'R$ 200,00'
  end
end