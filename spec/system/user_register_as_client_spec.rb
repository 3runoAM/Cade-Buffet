require "rails_helper"

describe "User register as client" do
  it 'and sees all fields to do so' do
    visit root_path
    click_on "Cadastrar"

    within '#registration' do
      expect(page).to have_field 'Nome'
      expect(page).to have_field 'Tipo de conta'
      expect(page).to have_field 'CPF'
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_field 'Confirme sua senha'
    end
  end
  it 'successfully' do
    visit root_path
    click_on "Cadastrar"

    within '#registration' do
      fill_in 'Nome', with: 'Fulano Beltrano'
      select 'Cliente', from: 'Tipo de conta'
      fill_in 'CPF', with: '592.428.200-75'
      fill_in 'E-mail', with: 'fulano@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Cadastrar'
    end
    user = User.first

    expect(page).not_to have_link "Cadastrar"
    expect(page).to have_link "Área do cliente"
    expect(page).to have_content "Boas-vindas! Você realizou seu registro com sucesso."
    expect(user.name).to eq 'Fulano Beltrano'
    expect(user.cpf).to eq '592.428.200-75'
    expect(user.email).to eq 'fulano@email.com'
    expect(user.role).to eq 'client'
  end
end