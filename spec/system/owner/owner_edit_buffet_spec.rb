require "rails_helper"

describe "Owner edit's buffet"  do
  it 'and sees correct information' do
    payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')

    first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com', password: 'password1', role: :owner)

    first_buffet = Buffet.new(user_id: first_owner.id, brand_name: 'Buffet 1', company_name: 'Company 1',
                              crn: '123456', phone: '111-111-1111', email: 'buffet1@example.com',
                              description: 'Description 1')
    first_buffet.payment_methods << payment_method_a
    first_buffet.save!

    Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                    state: 'State 1', city: 'City 1', zip: '11111', buffet_id: first_buffet.id)

    login_as first_owner
    visit owner_buffet_path(first_buffet.id)
    click_on 'Editar'

    expect(page).to have_field 'Nome fantasia'
    expect(page).to have_field 'Razão social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Telefone'
    expect(page).to have_field 'Email'
    expect(page).to have_field 'Rua'
    expect(page).to have_field 'Número ou lote'
    expect(page).to have_field 'Bairro'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Cep'
    expect(page).to have_field 'Descrição'
    expect(page).to have_button "Atualizar Buffet"
  end

  it 'successfully' do
    payment_method_a = PaymentMethod.create!(name: 'Pix')
    payment_method_b = PaymentMethod.create!(name: 'Cartão de crédito')
    payment_method_c = PaymentMethod.create!(name: 'Cartão de débito')
    payment_method_d = PaymentMethod.create!(name: 'Boleto')
    payment_method_e = PaymentMethod.create!(name: 'Trasnferência')

    owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com', password: 'password1', role: :owner)

    buffet = Buffet.new(user_id: owner.id, brand_name: 'Buffet 1', company_name: 'Company 1',
                        crn: '123456', phone: '111-111-1111', email: 'buffet1@example.com',
                        description: 'Description 1')
    buffet.payment_methods << payment_method_a
    buffet.payment_methods << payment_method_c
    buffet.save!

    Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                    state: 'State 1', city: 'City 1', zip: '11111', buffet_id: buffet.id)

    login_as owner
    visit owner_buffet_path(buffet.id)
    click_on 'Editar'

    fill_in 'Nome fantasia', with: 'Buffet do Mateus'
    fill_in 'Razão social', with: 'M.A. LTDA'
    fill_in 'CNPJ', with: '589.123.545-69'
    fill_in 'Telefone', with: '(83)95555-5555'
    fill_in 'Email', with: 'mateus@example.com'
    check 'Pix'
    check 'Cartão de débito'
    fill_in 'Rua', with: 'Rua dos planetas'
    fill_in 'Número ou lote', with: '963'
    fill_in 'Bairro', with: 'Sistema solar'
    fill_in 'Cidade', with: 'Via lactea'
    fill_in 'Estado', with: 'Universo'
    fill_in 'Cep', with: '00000-00'
    fill_in 'Descrição', with: 'Buffet infantil'
    click_on "Atualizar Buffet"

    expect(current_path).to eq owner_buffet_path(buffet.id)
    expect(page).to have_content 'Buffet atualizado com sucesso'
    expect(page).to have_content 'M.A. LTDA'
    expect(page).to have_content '589.123.545-69'
    expect(page).to have_content '(83)95555-5555'
    expect(page).to have_content 'mateus@example.com'
    expect(page).to have_content 'Pix'
    expect(page).to have_content 'Cartão de débito'
    expect(page).to have_content 'Rua dos planetas'
    expect(page).to have_content '963'
    expect(page).to have_content 'Sistema solar'
    expect(page).to have_content 'Via lactea'
    expect(page).to have_content 'Universo'
    expect(page).to have_content '00000-00'
    expect(page).to have_content 'Buffet infantil'
    expect(page).not_to have_content 'Cartão de crédito'
    expect(page).not_to have_content 'Boleto'
    expect(page).not_to have_content 'Trasnferência'
  end
end