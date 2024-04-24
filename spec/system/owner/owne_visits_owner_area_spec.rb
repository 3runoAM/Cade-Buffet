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
end