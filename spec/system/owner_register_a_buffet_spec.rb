require "rails_helper"

describe "Buffet owner register a buffet" do
  it "and view all the information about it" do
    PaymentMethod.create(name: 'Pix')
    PaymentMethod.create(name: 'Cartão de crédito')
    PaymentMethod.create(name: 'Cartão de débito')

    visit root_path
    sign_up
    register_buffet

    expect(page).to have_content 'Buffet do Mateus'
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

    expect(page).to have_link "Editar buffet"
  end
end