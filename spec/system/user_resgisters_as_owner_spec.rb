require "rails_helper"

describe "User register as buffet owner" do
  it 'and form should have all necessary fields to do so' do
    visit root_path
    click_on "Cadastrar"

    within '#registration' do
      expect(page).to have_field 'Nome'
      expect(page).to have_field 'Tipo de conta'
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_field 'Confirme sua senha'
    end
  end

  it 'sucessfully' do
    visit root_path
    sign_up

    expect(page).not_to have_link "Cadastrar"
    expect(page).to have_content "Boas-vindas! Você realizou seu registro com sucesso."
    expect(page).to have_link "Área do proprietário"
  end

  it 'and should be redirected to the Buffet registration right after' do
    visit root_path
    sign_up

    expect(current_path).to eq new_owner_buffet_path
  end
end