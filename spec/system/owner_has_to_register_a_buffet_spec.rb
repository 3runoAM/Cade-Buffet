require 'rails_helper'

describe "Owner has to register a Buffet" do
  it "and can't navigate to the root path without register a Buffet" do
    visit root_path
    sign_up
    click_on 'Cadê Buffet?'

    expect(current_path).to eq new_buffet_path
  end

  it 'and sees all required fields' do
    PaymentMethod.create(name: 'Pix')
    PaymentMethod.create(name: 'Cartão de crédito')
    PaymentMethod.create(name: 'Cartão de débito')

    visit root_path
    sign_up

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

    expect(page).to have_content 'Métodos de pagamento'
    expect(page).to have_unchecked_field 'Pix'
    expect(page).to have_unchecked_field 'Cartão de crédito'
    expect(page).to have_unchecked_field 'Cartão de débito'
  end

  it 'and do it successfully' do
    PaymentMethod.create(name: 'Pix')
    PaymentMethod.create(name: 'Cartão de crédito')
    PaymentMethod.create(name: 'Cartão de débito')

    visit root_path
    sign_up

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

    click_on 'Criar Buffet'

    expect(current_path).to eq buffet_path(1)
    expect(page).to have_content "Buffet do Mateus criado com sucesso!"
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
  end
end