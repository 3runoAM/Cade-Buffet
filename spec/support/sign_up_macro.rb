def sign_up
  click_on "Inscrever-se"
  within '#registration' do
    fill_in 'Nome', with: 'Mateus Alves'
    select 'Proprietário de Buffet', from: 'Tipo de conta'
    fill_in 'E-mail', with: 'mateus@exemplo.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Cadastrar'
  end
end