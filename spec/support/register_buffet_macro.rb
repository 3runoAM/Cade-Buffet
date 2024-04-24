def register_buffet
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
end
