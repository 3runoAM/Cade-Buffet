require "rails_helper"

describe "Buffet owner register a buffet" do
  it "and sees all the fields required" do
    PaymentMethod.create(name: 'Pix')
    PaymentMethod.create(name: 'Cartão de crédito')
    PaymentMethod.create(name: 'Cartão de débito')

    visit root_path
    sign_up

    fill_in 'Nome fantasia', with: 'Buffet do Mateus'
    fill_in 'Razão social', with: 'M.A. LTDA'
    fill_in 'CNPJ', with: '23.261.499/0001-96'
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

    expect(page).to have_content 'Buffet do Mateus'
    expect(page).to have_content 'M.A. LTDA'
    expect(page).to have_content '23.261.499/0001-96'
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

    expect(page).to have_link "Editar Buffet"
  end

  it "but doesn't fill in the mandatory fields" do
    PaymentMethod.create(name: 'Pix')
    PaymentMethod.create(name: 'Cartão de crédito')
    PaymentMethod.create(name: 'Cartão de débito')

    visit root_path
    sign_up

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

    expect(page).to have_content "Nome fantasia não pode ficar em branco"
    expect(page).to have_content "Razão social não pode ficar em branco"
    expect(page).to have_content "CNPJ não pode ficar em branco"
  end
end