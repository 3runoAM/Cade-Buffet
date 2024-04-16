require "rails_helper"

describe "User register as buffet owner" do
  it 'sucessfully' do
    visit root_path
    click_on "Cadastrar"

    within 'form' do
      fill_in 'Nome', with: 'Mateus Alves'
      select 'Proprietário de Buffet', from: 'Tipo de conta'
      fill_in 'E-mail', with: 'mateus@exemplo.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Cadastrar'
    end

    expect(page).not_to have_link "Cadastrar"
    expect(page).to have_content "Boas-vindas! Você realizou seu registro com sucesso."
  end

  it 'then logs out' do
    visit root_path
    click_on "Cadastrar"

    within 'form' do
      fill_in 'Nome', with: 'Mateus Alves'
      select 'Proprietário de Buffet', from: 'Tipo de conta'
      fill_in 'E-mail', with: 'mateus@exemplo.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Cadastrar'
    end
    click_on 'Sair'

    expect(page).to have_content "Logout efetuado com sucesso."
  end
end